import streamlit as st
import pandas as pd
import sqlite3

conn = sqlite3.connect("sfm.db")

st.title("Community Nutrition Program — Program Dashboard")

df = pd.read_sql_query("SELECT * FROM sessions", conn)

# --- Top-line metrics ---
col1, col2, col3 = st.columns(3)
col1.metric("Total Sessions", len(df))
col2.metric("Total Participants", int(df["num_participants"].sum()))
col3.metric("Total Surveys", int(df["num_surveys"].sum()))

# --- Participants by borough ---
st.subheader("Participants by Borough")
by_borough = df.groupby("borough")["num_participants"].sum()
st.bar_chart(by_borough)

# --- Sessions by month ---
st.subheader("Sessions by Month")
by_month = df.groupby("month").size()
st.bar_chart(by_month)

# --- In-person vs virtual ---
st.subheader("In-Person vs Virtual")
df["format"] = df["is_virtual"].map({0: "In-Person", 1: "Virtual"})
st.bar_chart(df["format"].value_counts())

# --- Survey language breakdown ---
st.subheader("Surveys by Language")
st.bar_chart(df["survey_language"].value_counts())

# --- Raw data ---
st.subheader("Session Records")
st.dataframe(df)

conn.close()
