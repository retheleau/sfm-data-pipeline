"""
SFM Pipeline — Step 1: Load the CSV into a real database.
This is a tiny ETL pipeline: Extract (read CSV) -> Transform (fix types) -> Load (into SQLite).
Run it:  python load_sfm.py
"""

import sqlite3          # built into Python — no install needed
import pandas as pd     # the data workhorse

# ---------- EXTRACT ----------
# Read the CSV into a DataFrame (a table in memory)
df = pd.read_csv("SFM_Practice_Data.csv")
print(f"Extracted {len(df)} rows, {len(df.columns)} columns")

# ---------- TRANSFORM ----------
# 1. Fix the date column: it's text like "07/05/2024" — convert to real dates
df["start_date"] = pd.to_datetime(df["start_date"], format="%m/%d/%Y")

# 2. Add a 'month' column so SQL grouping by month is easy later
df["month"] = df["start_date"].dt.strftime("%Y-%m")

# 3. Clean the ebt_wic_usage column: empty strings become None (SQL NULL)
df["ebt_wic_usage"] = df["ebt_wic_usage"].replace("", None)

print("Transformed: dates fixed, month column added, blanks -> NULL")

# ---------- LOAD ----------
# Connect to a SQLite database file (creates it if it doesn't exist)
conn = sqlite3.connect("sfm.db")

# Write the DataFrame into a table called 'sessions'
# if_exists="replace" means rerunning the script rebuilds the table fresh
df.to_sql("sessions", conn, if_exists="replace", index=False)

# Quick proof it worked: run a SQL query against the new table
check = pd.read_sql("SELECT COUNT(*) AS rows_loaded FROM sessions", conn)
print(f"Loaded into sfm.db: {check['rows_loaded'][0]} rows in table 'sessions'")

conn.close()
print("Pipeline complete.")
