# import streamlit as st
# import pandas as pd
# from db import get_connection

# st.title("📊 Dashboard")

# conn = get_connection()

# if conn:

#     total_exam = pd.read_sql(
#         "SELECT COUNT(*) as total FROM Sinavlar",
#         conn
#     )

#     total_room = pd.read_sql(
#         "SELECT COUNT(*) as total FROM Derslikler",
#         conn
#     )

#     total_staff = pd.read_sql(
#         "SELECT COUNT(*) as total FROM Personel",
#         conn
#     )

#     c1, c2, c3 = st.columns(3)

#     c1.metric("Toplam Sınav", total_exam.iloc[0]["total"])
#     c2.metric("Toplam Derslik", total_room.iloc[0]["total"])
#     c3.metric("Toplam Personel", total_staff.iloc[0]["total"])

#     st.divider()

#     st.subheader("Aktif Derslikler")

#     df = pd.read_sql("""
#         SELECT DerslikAd, Kapasite, Kat
#         FROM Derslikler
#         WHERE Aktif = 1
#     """, conn)

#     st.dataframe(df, use_container_width=True)

#     conn.close()