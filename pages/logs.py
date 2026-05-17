# import streamlit as st
# import pandas as pd
# from db import get_connection

# st.title("📜 Sistem Logları")

# conn = get_connection()

# if conn:

#     logs = pd.read_sql("""
#         SELECT *
#         FROM Log
#         ORDER BY Tarih DESC
#     """, conn)

#     st.dataframe(logs, use_container_width=True)

#     conn.close()