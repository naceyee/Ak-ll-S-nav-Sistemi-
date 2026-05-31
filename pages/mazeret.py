import streamlit as st
import pandas as pd
from db import get_connection

st.title("Personel Mazeret ve İzin Kayıt Paneli")
st.markdown("---")

# Veritabanı bağlantısını Admin yetkisiyle açıyoruz (Ekleme işlemi yapılacağı için)
conn = get_connection("Admin")

if conn:
    try:
        # Seçim kutularını beslemek için verileri çekiyoruz
        df_personel = pd.read_sql("SELECT PersonelID, Unvan + ' ' + Ad + ' ' + Soyad AS AdSoyad FROM Personel", conn)
        df_oturumlar = pd.read_sql("SELECT OturumID, OturumAd FROM Oturumlar", conn)

        # Aktif kullanıcının bilgilerini session_state'den güvenle alıyoruz
        current_user_role = st.session_state.get("user_role", "Personel")
        current_user_name = st.session_state.get("user_full_name", "")
        
        # Giriş yapan personelin veritabanındaki PersonelID'sini Kullanicilar tablosundan buluyoruz
        # (Eğer session_state'e daha önce eklemediysek, isim üzerinden dinamik olarak çekiyoruz)
        user_personel_id = st.session_state.get("user_personel_id", None)
        if not user_personel_id and current_user_role == "Personel":
            p_query = f"SELECT PersonelID FROM Kullanicilar WHERE Email = '{st.session_state.get('login_email', '')}'"
            try:
                user_personel_id = int(pd.read_sql(p_query, conn).iloc[0]['PersonelID'])
            except:
                user_personel_id = 38 # Hata durumunda Selin Hanım'ın ID'si (Fallback)

        # --- MAZERET EKLEME FORMU ---
        with st.form("mazeret_container_form"):
            st.subheader("Yeni Mazeret / İzin Tanımla")
            
            # ROL KONTROLÜ: Admin herkesi seçebilir, Personel sadece kendini görür [cite: 193]
            if current_user_role == "Admin":
                selected_personel = st.selectbox(
                    " Mazeretli Personel Seçin", 
                    df_personel["PersonelID"], 
                    format_func=lambda x: df_personel[df_personel['PersonelID'] == x]['AdSoyad'].values[0]
                )
            else:
                st.info(f"İzin Kaydı Yapılacak Personel: **{current_user_name}**")
                selected_personel = user_personel_id # Personel ise kendi ID'si kilitlenir
            
            mazeret_tarihi = st.date_input("Mazeret Tarihi")
            
            # İzin tipi seçimi [cite: 16, 50]
            izin_tipi = st.radio("İzin Kapsamı", ["Tüm Gün İzinli/Mazeretli", "Belirli Bir Oturumda İzinli"])
            
            # NULL hatası Python'da 'None' yapılarak çözüldü
            selected_oturum = None
            if izin_tipi == "Belirli Bir Oturumda İzinli":
                selected_oturum = st.selectbox(
                    " Oturum Seçin", 
                    df_oturumlar["OturumID"],
                    format_func=lambda x: df_oturumlar[df_oturumlar['OturumID'] == x]['OturumAd'].values[0]
                )
            
            mazeret_nedeni = st.text_input("📝 Mazeret Nedeni", placeholder="Örn: Yıllık İzin, Sağlık Raporu, Kongre...")
            
            # FORM SUBMIT BUTTON (Formun tam olarak içinde, hata çözüldü)
            submit_button = st.form_submit_button("Mazereti Veritabanına İşle")
            
            if submit_button:
                if not mazeret_nedeni:
                    st.warning("Lütfen mazeret nedenini belirtin.")
                else:
                    cursor = conn.cursor()
                    insert_query = """
                        INSERT INTO PersonelDurum (PersonelID, Tarih, OturumID, MazeretTuru, Uygun)
                        VALUES (?, ?, ?, ?, 0)
                    """
                    # Eğer oturum seçilmediyse veritabanına NULL (None) basıyoruz
                    oturum_val = int(selected_oturum) if selected_oturum is not None else None
                    
                    cursor.execute(insert_query, (int(selected_personel), mazeret_tarihi, oturum_val, mazeret_nedeni))
                    conn.commit()
                    st.success("✅ Mazeret kaydı başarıyla işlendi!")
                    st.rerun()

        # --- MAZERET LİSTELEME PANELI (ROL BAZLI FİLTRELEMELİ) ---
        st.write("")
        st.markdown("---")
        
        # SQL sorgusunu hazırlıyoruz
        base_query = """
            SELECT pd.DurumID, p.Ad + ' ' + p.Soyad AS [Personel], b.BolumAd AS [Bölüm], pd.Tarih, ISNULL(o.OturumAd, 'Tüm Gün') AS [Oturum Dilimi], pd.MazeretTuru AS [Açıklama]
            FROM PersonelDurum pd
            JOIN Personel p ON pd.PersonelID = p.PersonelID
            JOIN Bolumler b ON p.BolumID = b.BolumID
            LEFT JOIN Oturumlar o ON pd.OturumID = o.OturumID
        """
        
        # ROL KONTROLÜ: Admin her şeyi görür, Personel sadece kendi satırlarını görür [cite: 193]
        if current_user_role == "Admin":
            st.subheader("📋 Sistemde Kayıtlı Tüm Personel Mazeretleri (Yönetici Görünümü)")
            df_goster = pd.read_sql(base_query + " ORDER BY pd.Tarih DESC", conn)
        else:
            st.subheader("📋 Geçmiş Mazeret ve İzin Kayıtlarınız")
            df_goster = pd.read_sql(base_query + f" WHERE pd.PersonelID = {selected_personel} ORDER BY pd.Tarih DESC", conn)
            
        if not df_goster.empty:
            st.dataframe(df_goster, use_container_width=True, hide_index=True)
        else:
            st.info("Henüz kayıtlı bir mazeret verisi bulunmuyor.")

        conn.close()
    except Exception as e:
        st.error(f"Bir hata oluştu: {e}")
else:
    st.error("Veritabanı bağlantısı kurulamadı.")