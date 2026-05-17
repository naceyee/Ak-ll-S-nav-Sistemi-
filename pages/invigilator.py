import streamlit as st
import pandas as pd
from db import get_connection

st.set_page_config(page_title="Gözetmen Atama", layout="wide")
st.title("👨‍🏫 Modül 3: Gözetmen Atama ve Havuz Sistemi")
st.markdown("---")

conn = get_connection("Admin")

if conn:
    # 1. Atama bekleyen sınavları listele
    query_atamasiz = """
        SELECT s.SinavID, d.DersAd, s.Tarih, o.OturumAd 
        FROM Sinavlar s 
        JOIN Dersler d ON s.DersID = d.DersID 
        JOIN Oturumlar o ON s.OturumID = o.OturumID
        WHERE s.SinavID NOT IN (SELECT DISTINCT SinavID FROM GozetmenAtamalari)
    """
    df_atamasiz = pd.read_sql(query_atamasiz, conn)

    if not df_atamasiz.empty:
        selected_sinav_id = st.selectbox(
            "Gözetmen Atanacak Sınavı Seçin", 
            df_atamasiz["SinavID"],
            format_func=lambda x: f"ID: {x} - {df_atamasiz[df_atamasiz['SinavID']==x]['DersAd'].values[0]}"
        )

        if st.button("🚀 Otomatik Gözetmen Ata", type="primary"):
            cursor = conn.cursor()
            try:
                # sp_GozetmenAta prosedürünü çağır
                cursor.execute("EXEC sp_GozetmenAta ?", (selected_sinav_id,))
                
                rows = cursor.fetchall()
                if rows:
                    columns = [column[0] for column in cursor.description]
                    df_atama_sonuc = pd.DataFrame.from_records(rows, columns=columns)
                    
                    conn.commit()
                    st.success("✅ Gözetmenler atandı!")
                    st.dataframe(df_atama_sonuc, use_container_width=True)
                
            except Exception as e:
                conn.rollback()
                st.error(f"❌ Atama Hatası: {e}")
    else:
        st.info("Atama bekleyen sınav bulunmamaktadır.")

    st.divider()
    
    # 2. Adil Dağıtım Kontrolü
    st.subheader("📊 Gözetmen Görev Yükü (Adil Dağıtım)")
    # Not: Buradaki sorgu senin yazdığın v_GozetmenGorevDagilimi View'ını kullanır
    df_yuk = pd.read_sql("SELECT * FROM v_GozetmenGorevDagilimi", conn)
    
    if not df_yuk.empty:
        st.bar_chart(df_yuk.set_index("PersonelAdSoyad")["ToplamGorevSayisi"])

    conn.close()