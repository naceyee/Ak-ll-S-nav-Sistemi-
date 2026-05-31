import streamlit as st
import pandas as pd
from db import get_connection

st.title(" Sistem Değişiklik ve Log Kayıtları")
st.markdown("---")

conn = get_connection("Admin")

if conn:
    try:
        # Hatalı sütun adlarından kaçınmak için SELECT * yapıp tabloda ne varsa çekiyoruz
        query = "SELECT * FROM Log"
        df_logs = pd.read_sql(query, conn)
        
        if not df_logs.empty:
            st.info("💡 Sistemdeki tüm hareketler ve otomatik log kayıtları aşağıda listelenmiştir.")
            
            # Kullanıcı dostu arama barı (Tabloda hangi kolon varsa ona göre arama yapar)
            search_query = st.text_input("🔍 Loglar İçinde Ara (Kullanıcı, Açıklama vb.)")
            
            filtered_df = df_logs.copy()
            if search_query:
                # Tablodaki tüm metinsel alanlarda arama yapabilmesi için esnek filtreleme
                mask = filtered_df.astype(str).apply(lambda x: x.str.contains(search_query, case=False)).any(axis=1)
                filtered_df = filtered_df[mask]
            
            # Dinamik tablo gösterimi
            st.dataframe(
                filtered_df, 
                use_container_width=True, 
                hide_index=True
            )
        else:
            st.warning("Veritabanındaki 'Log' tablosu şu an tamamen boş. Henüz bir işlem yapılmamış.")
            
    except Exception as e:
        st.error(f"⚠️ Log tablosuna erişilirken SQL Hatası alındı: {e}")
        st.info("İpucu: Veritabanındaki 'Log' tablosunun ismini veya sütunlarını kontrol edin.")
    finally:
        conn.close()
else:
    st.error("Veritabanı bağlantısı kurulamadı.")