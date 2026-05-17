import streamlit as st
import pandas as pd
from db import get_connection

# Sayfa genel ayarları
st.set_page_config(page_title="Akıllı Sınav Sistemi", layout="centered")

def login_page():
    st.title("🎓 Akıllı Sınav Yönetim Sistemi")
    st.subheader("Kurumsal E-posta ile Giriş")
    
    # Form yapısı kullanımı sayfanın sürekli yenilenmesini engeller
    with st.form("login_container"):
        email = st.text_input("E-posta Adresiniz", placeholder="örnek@cbu.edu.tr")
        password = st.text_input("Şifre", type="password")
        submit_button = st.form_submit_button("Sisteme Giriş Yap")
        
        if submit_button:
            if not email or not password:
                st.warning("Lütfen tüm alanları doldurun.")
                return

            # Önce kısıtlı Viewer yetkisiyle bağlanıp kullanıcıyı doğrula [cite: 192]
            conn = get_connection("Viewer")
            if conn:
                # Kullanicilar tablosundan rolü ve isim bilgilerini al
                query = "SELECT Rol, Ad, Soyad FROM Kullanicilar WHERE Email = ? AND SifreHash = ? AND Aktif = 1"
                user_data = pd.read_sql(query, conn, params=[email, password])
                conn.close()
                
                if not user_data.empty:
                    # Giriş başarılı; session bilgilerini doldur
                    row = user_data.iloc[0]
                    st.session_state["logged_in"] = True
                    st.session_state["user_role"] = row['Rol'] # 'Admin' veya 'Personel'
                    st.session_state["user_full_name"] = f"{row['Ad']} {row['Soyad']}"
                    
                    st.success(f"Hoş geldiniz, {st.session_state['user_full_name']}!")
                    st.rerun() # Sayfayı yenileyerek içeriği göster
                else:
                    st.error("Hatalı e-posta veya şifre!")

# --- Uygulama Kontrol Mantığı ---
if "logged_in" not in st.session_state:
    st.session_state["logged_in"] = False

if not st.session_state["logged_in"]:
    login_page()
else:
    # Giriş yapıldıktan sonra görünecek Sidebar ve İçerik
    st.sidebar.title("Menü")
    st.sidebar.write(f"👤 {st.session_state['user_full_name']}")
    st.sidebar.write(f"🔑 Yetki: {st.session_state['user_role']}")
    
    # Çıkış Butonu
    if st.sidebar.button("Güvenli Çıkış"):
        st.session_state["logged_in"] = False
        st.rerun()

    # Rol bazlı modül erişimi
    if st.session_state["user_role"] == "Admin":
        st.header("Yönetici Kontrol Paneli")
        st.info("Sınav planlama ve gözetmen atama modülleri aktif.")
        # Buraya Modül 2 ve Modül 3 bileşenlerini ekleyeceğiz [cite: 17, 24]
    else:
        st.header("Personel Bilgi Paneli")
        st.write("Sınav görevlerinizi ve takviminizi buradan takip edebilirsiniz.")