import streamlit as st
import pandas as pd
from db import get_connection

st.title("📊 Genel Durum Paneli ")
st.markdown("---")

# Dashboard için genel Viewer yetkisi yeterlidir
conn = get_connection("Admin")

if conn:
    try:
        # Metrikleri çekiyoruz
        total_exam = pd.read_sql("SELECT COUNT(*) as total FROM Sinavlar", conn)
        total_room = pd.read_sql("SELECT COUNT(*) as total FROM Derslikler", conn)
        total_staff = pd.read_sql("SELECT COUNT(*) as total FROM Personel", conn)

        c1, c2, c3 = st.columns(3)
        c1.metric("Toplam Planlanan Sınav", int(total_exam.iloc[0]["total"]) if not total_exam.empty else 0)
        c2.metric("Toplam Tanımlı Derslik", int(total_room.iloc[0]["total"]) if not total_room.empty else 0)
        c3.metric("Toplam Görevli Personel", int(total_staff.iloc[0]["total"]) if not total_staff.empty else 0)

        st.divider()

        # Aktif Dersliklerin Tablo Görünümü
        st.subheader("🏢 Aktif Sınav Salonları ve Kapasiteleri")
        df_rooms = pd.read_sql("SELECT DerslikAd, Kapasite, Kat, Aktif FROM Derslikler", conn)

        if not df_rooms.empty:
            # Kullanıcı dostu isimlendirme ve filtreleme
            df_rooms = df_rooms[df_rooms["Aktif"] == 1]
            st.dataframe(
                df_rooms[["DerslikAd", "Kapasite", "Kat"]], 
                use_container_width=True, 
                hide_index=True,
                column_config={
                    "DerslikAd": "Derslik Adı",
                    "Kapasite": "Kapasite (Kişi)",
                    "Kat": "Bulunduğu Kat"
                }
            )
        else:
            st.info("Sistemde aktif derslik bulunamadı.")

    except Exception as e:
        st.error(f"Dashboard verileri yüklenirken bir hata oluştu: {e}")
    finally:
        conn.close()
else:
    st.error("Veritabanı bağlantısı kurulamadı.")