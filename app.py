import streamlit as st
import pandas as pd
from db import get_connection

# Sayfa genel ayarları
st.set_page_config(page_title="Akıllı Sınav Sistemi", layout="wide")

# --- Oturum Durumu İlk Değer Atamaları ---
if "logged_in" not in st.session_state:
    st.session_state["logged_in"] = False
if "user_role" not in st.session_state:
    st.session_state["user_role"] = None
if "user_full_name" not in st.session_state:
    st.session_state["user_full_name"] = ""

# --- Çıkış Fonksiyonu ---
def logout():
    st.session_state["logged_in"] = False
    st.session_state["user_role"] = None
    st.session_state["user_full_name"] = ""
    st.rerun()

# --- GİRİŞ FORMU FONKSİYONU ---
def login_form():
    st.title("🎓 Akıllı Sınav Yönetim Sistemi")
    st.subheader("Kurumsal E-posta ile Giriş")
    
    with st.form("login_container"):
        email = st.text_input("E-posta Adresiniz", placeholder="örnek@cbu.edu.tr")
        password = st.text_input("Şifre", type="password")
        submit_button = st.form_submit_button("Sisteme Giriş Yap")
        
        if submit_button:
            if not email or not password:
                st.warning("Lütfen tüm alanları doldurun.")
            else:
                # DÜZELTME: db.py sözlüğü "Viewer" beklediği için parametreyi eski haline getirdik.
                # db.py bunu arka planda otomatik olarak "App_Viewer" kullanıcısına dönüştürecek!
                conn = get_connection("Viewer")
                if conn:
                    try:
                        # SifreHash olarak düzelttiğin için sorguyu güncelledik
                        query = "SELECT Rol, Ad, Soyad FROM Kullanicilar WHERE Email = ? AND SifreHash = ? AND Aktif = 1"
                        user_data = pd.read_sql(query, conn, params=[email, password])
                        
                        if not user_data.empty:
                            row = user_data.iloc[0]
                            st.session_state["logged_in"] = True
                            st.session_state["user_role"] = str(row['Rol']).strip()  # Boşlukları temizle
                            st.session_state["user_full_name"] = f"{row['Ad']} {row['Soyad']}"
                            st.success(f"Hoş geldiniz, {st.session_state['user_full_name']}!")
                            st.rerun()
                        else:
                            st.error("Hatalı e-posta veya şifre!")
                    except Exception as e:
                        st.error(f"Giriş hatası: {e}")
                    finally:
                        conn.close()
                else:
                    st.error("Veritabanı bağlantısı kurulamadı.")

# --- DİNAMİK NAVİGASYON VE ROL KONTROLÜ ---
if not st.session_state["logged_in"]:
    login_page = st.Page(login_form, title="Giriş Ekranı", icon=":material/lock:")
    pg = st.navigation([login_page])
    pg.run()

else:
    # Sayfa Nesnelerinin Klasik İkonlarla Tanımlanması
    dashboard_page = st.Page("pages/dashboard.py", title="Genel Durum", icon=":material/dashboard:")
    schedule_page = st.Page("pages/schedule.py", title="Haftalık Sınav Programı", icon=":material/calendar_month:")
    planning_page = st.Page("pages/planning.py", title="Salon ve Kapasite Planla", icon=":material/settings:")
    invigilator_page = st.Page("pages/invigilator.py", title="Gözetmen Ata", icon=":material/supervisor_account:")
    logs_page = st.Page("pages/logs.py", title="Log Bilgileri", icon=":material/history_toggle_off:")
    mazeret_page = st.Page("pages/mazeret.py", title="Mazeret/İzin Yönetimi", icon=":material/assignment_late:")
    # Rol Bazlı Dinamik Sayfa Listesi Oluşturma
    sayfa_listesi = []

    if st.session_state["user_role"] == "Admin":
        sayfa_listesi = [dashboard_page, schedule_page, planning_page, invigilator_page, logs_page, mazeret_page]
    elif st.session_state["user_role"] == "Personel":
        sayfa_listesi = [ schedule_page, mazeret_page]
    else:
        sayfa_listesi = [schedule_page]

    # Navigasyonu çalıştır
    pg = st.navigation(sayfa_listesi)
    pg.run()

    # Kullanıcı Bilgileri Paneli
    st.sidebar.write("")    
    st.sidebar.markdown(f"### :material/person: {st.session_state['user_full_name']}")
    st.sidebar.markdown(f"**:material/lock_person: Yetki:** {st.session_state['user_role']}")
    
    st.sidebar.markdown("")
    if st.sidebar.button("Güvenli Çıkış", type="secondary", use_container_width=True):
        logout()