import pyodbc
import streamlit as st

def get_connection(role="Viewer"):

    credentials = {
        "Admin": {
            "uid": "App_Admin",
            "pwd": "AdminSifre123"
        },

        "Viewer": {
            "uid": "App_Viewer",
            "pwd": "ViewerSifre123"
        }
    }

    user = credentials[role]["uid"]
    password = credentials[role]["pwd"]

    try:
        conn = pyodbc.connect(
            "DRIVER={ODBC Driver 17 for SQL Server};"
            r"SERVER=EXCALIBUR-PC\SQLEXPRESS;"
            "DATABASE=AkilliSinavDB;"
            f"UID={user};"
            f"PWD={password};"
        )

        return conn

    except Exception as e:
        st.error(f"Veritabanı Bağlantı Hatası ({role}): {e}")
        return None