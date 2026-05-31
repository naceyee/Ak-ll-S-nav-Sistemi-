import streamlit as st
import pandas as pd
from db import get_connection

st.title("Haftalık Sınav Programı")
st.markdown("---")

# Raporlama ve izleme için Viewer yetkisi yeterlidir
conn = get_connection("Viewer")

if conn:
    try:
        # Görünümü (View) sorguluyoruz
        query = "SELECT * FROM v_SinavProgrami ORDER BY Tarih, BaslangicSaat"
        df_program = pd.read_sql(query, conn)

        if not df_program.empty:
            
            # --- PERSONEL/ADMIN İÇİN ÖZEL ALAN (DİNAMİK GÖREV TAKİBİ) ---
            if "logged_in" in st.session_state and st.session_state["logged_in"]:
                current_user_name = st.session_state.get("user_full_name", "")
                user_role = st.session_state.get("user_role", "Personel")
                
                if current_user_name:
                    # Giriş yapan kullanıcının adını gözetmen listesinde aratıyoruz
                    my_tasks = df_program[df_program["Gozetmenler"].str.contains(current_user_name, case=False, na=False)]
                    
                    # Eğer atanmış bir görev VARSA hem Admin hem Personel görsün
                    if not my_tasks.empty:
                        st.subheader(" Size Atanan Sınav Görevleri")
                        st.success(f"🔔 Sayın {current_user_name}, bu hafta görevli olduğunuz sınavlar aşağıda listelenmiştir.")
                        st.dataframe(
                            my_tasks,
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
                        st.divider()
                    
                    # Eğer atanmış görev YOKSA ve giren kişi "Personel" ise bilgi kutusunu göster
                    # Giriş yapan kişi "Admin" ise burayı tamamen es geç, hiçbir şey basma!
                    elif user_role == "Personel":
                        st.subheader(" Size Atanan Sınav Görevleri")
                        st.info("💡 Yakın zamanda adınıza tanımlanmış bir sınav görevi bulunmamaktadır.")
                        st.divider()

            # --- GENEL HAFTALIK PROGRAM (TÜM LİSTE) ---
            st.subheader(" Genel Sınav Listesi")
            
            # Filtreleme Seçenekleri (Kullanıcı dostu arayüz)
            col1, col2 = st.columns(2)
            with col1:
                search_ders = st.text_input("🔍 Ders Adı ile Ara")
            with col2:
                selected_bolum = st.multiselect("Filter: Bölüm Seçin", options=df_program["BolumAd"].unique())

            # Filtreleme Mantığı
            filtered_df = df_program.copy()
            if search_ders:
                filtered_df = filtered_df[filtered_df["DersAd"].str.contains(search_ders, case=False, na=False)]
            if selected_bolum:
                filtered_df = filtered_df[filtered_df["BolumAd"].isin(selected_bolum)]

            # Ana Tablo Görünümü
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

            # İstatistik Kartları
            st.divider()
            c1, c2 = st.columns(2)
            with c1:
                st.metric("Toplam Planlanan Sınav", len(filtered_df))
            with c2:
                total_rooms = filtered_df["Salonlar"].dropna().str.split(',').str.len().sum()
                st.metric("Toplam Derslik Kullanımı", int(total_rooms) if total_rooms else 0)

        else:
            st.warning("Sistemde henüz planlanmış bir sınav bulunmamaktadır.")

    except Exception as e:
        st.error(f"Rapor yüklenirken hata oluştu: {e}")
    finally:
        conn.close()
else:
    st.error("Veritabanı bağlantısı kurulamadı.")