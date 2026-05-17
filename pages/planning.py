import streamlit as st
import pandas as pd
from db import get_connection

st.set_page_config(page_title="Sınav Planlama", layout="wide")

st.title("⚙️ Modül 2: Akıllı Salon ve Kapasite Planlama")
st.markdown("---")

# Bağlantı hatası alıyorsan şimdilik 'Trusted_Connection=yes' ile kendi yetkinle bağlanmayı deneyebilirsin
conn = get_connection("Admin") 

if conn:
    try:
        # SQL'den Ders ve Oturum listesini çekiyoruz [cite: 11, 13]
        df_dersler = pd.read_sql("SELECT DersID, DersKodu, DersAd, OgrenciSayisi FROM Dersler", conn)
        df_oturumlar = pd.read_sql("SELECT OturumID, OturumAd FROM Oturumlar", conn)

        with st.container():
            col1, col2 = st.columns(2)
            with col1:
                # Kullanıcı ders seçince kontenjan bilgisini de görecek [cite: 13, 14]
                selected_ders_id = st.selectbox(
                    "📖 Sınavı Yapılacak Ders", 
                    df_dersler["DersID"],
                    format_func=lambda x: f"{df_dersler[df_dersler['DersID']==x]['DersAd'].values[0]} ({df_dersler[df_dersler['DersID']==x]['OgrenciSayisi'].values[0]} Kişi)"
                )
                sinav_tarihi = st.date_input("📅 Sınav Tarihi")

            with col2:
                # Sınavlar önceden belirlenmiş "Slotlara" atanır [cite: 11]
                selected_oturum_id = st.selectbox(
                    "⏰ Sınav Oturumu",
                    df_oturumlar["OturumID"],
                    format_func=lambda x: f"{df_oturumlar[df_oturumlar['OturumID']==x]['OturumAd'].values[0]}"
                )

        if st.button("🚀 Salonları Hesapla ve Sınavı Oluştur", type="primary"):
            cursor = conn.cursor()
            try:
                # Transaction Yönetimi: Hata olursa ROLLBACK yapılır [cite: 187]
                # Yazdığın SP: @DersID, @Tarih, @OturumID bekliyor [cite: 35]
                cursor.execute("EXEC sp_SinavVeSalonOlustur ?, ?, ?", (selected_ders_id, sinav_tarihi, selected_oturum_id))
                
                # SP içindeki sonuçları (Önerilen Salonlar) alıyoruz [cite: 20, 23]
                rows = cursor.fetchall()
                if rows:
                    columns = [column[0] for column in cursor.description]
                    df_sonuc = pd.DataFrame.from_records(rows, columns=columns)
                    
                    conn.commit() # İşlem başarılıysa kaydet
                    st.success("✅ Sınav başarıyla oluşturuldu ve salonlar atandı!")
                    st.subheader("🏢 Atanan Salon Detayları")
                    st.table(df_sonuc)
                
            except Exception as e:
                conn.rollback() # Hata oluşursa işlemi geri al [cite: 187]
                st.error(f"❌ Planlama Hatası: {e}")
        
        conn.close()

    except Exception as e:
        st.error(f"Veri çekme hatası: {e}")
else:
    st.warning("Veritabanı bağlantısı kurulamadı. Lütfen SQL Server kullanıcı yetkilerini kontrol edin.")