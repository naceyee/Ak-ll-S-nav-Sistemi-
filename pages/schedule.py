import streamlit as st
import pandas as pd
from db import get_connection

st.set_page_config(page_title="Sınav Programı", layout="wide")

st.title("📅 Haftalık Sınav Programı")
st.markdown("---")

# Raporlama için kısıtlı 'Viewer' yetkisi yeterlidir [cite: 192, 193]
conn = get_connection("Viewer")

if conn:
    try:
        # Senin yazdığın View'ı sorguluyoruz 
        query = "SELECT * FROM v_SinavProgrami ORDER BY Tarih, BaslangicSaat"
        df_program = pd.read_sql(query, conn)

        if not df_program.empty:
            # 1. Filtreleme Seçenekleri (Kullanıcı dostu arayüz)
            col1, col2 = st.columns(2)
            with col1:
                search_ders = st.text_input("🔍 Ders Adı ile Ara")
            with col2:
                selected_bolum = st.multiselect("Filter: Bölüm Seçin", options=df_program["BolumAd"].unique())

            # Filtreleme Mantığı
            filtered_df = df_program.copy()
            if search_ders:
                filtered_df = filtered_df[filtered_df["DersAd"].str.contains(search_ders, case=False)]
            if selected_bolum:
                filtered_df = filtered_df[filtered_df["BolumAd"].isin(selected_bolum)]

            # 2. Ana Tablo (Doküman Sayfa 4'teki çıktıya benzer yapı) 
            st.subheader("📋 Sınav Listesi")
            st.dataframe(
                filtered_df, 
                use_container_width=True,
                hide_index=True,
                column_config={
                    "Tarih": st.column_config.DateColumn("Sınav Tarihi"),
                    "BaslangicSaat": "Başlangıç",
                    "BitisSaat": "Bitiş",
                    "Salonlar": "Atanan Salonlar",
                    "Gozetmenler": "Görevli Gözetmenler"
                }
            )

            # 3. İstatistikler (Bonus Görselleştirme)
            st.divider()
            c1, c2 = st.columns(2)
            with c1:
                st.metric("Toplam Planlanan Sınav", len(filtered_df))
            with c2:
                # Toplam derslik kullanım sayısı
                total_rooms = filtered_df["Salonlar"].str.split(',').str.len().sum()
                st.metric("Toplam Derslik Kullanımı", int(total_rooms) if not pd.isna(total_rooms) else 0)

        else:
            st.warning("Sistemde henüz planlanmış bir sınav bulunmamaktadır.")

    except Exception as e:
        st.error(f"Rapor yüklenirken hata oluştu: {e}")
    finally:
        conn.close()
else:
    st.error("Veritabanı bağlantısı kurulamadı.")