# SFM Data Pipeline — Community Nutrition Program

An end-to-end data pipeline that recreates the monthly reporting workflow I ran at the **NYC Department of Health, Bureau of Chronic Disease Prevention** for a SNAP-Ed community nutrition program (Stellar Farmers Markets / PEARS).

It takes raw session data, cleans and loads it into a SQL database, analyzes participation across NYC boroughs, and surfaces the results in a live dashboard — the same reporting I did by hand at the Bureau, rebuilt as an automated pipeline.

**[▶ View the live dashboard](https://randy-sfm-dashboard.streamlit.app)**

---

## What it does

The pipeline moves data through three stages:

1. **Extract & clean (Python ETL)** — `load_sfm.py` reads the raw CSV, fixes date formatting, adds a month column, and converts blanks to NULL, then loads it into a SQLite database (`sfm.db`).
2. **Analyze (SQL)** — 12 SQL queries in `practice_queries.sql` answer program questions: participation by site, reach by month, in-person vs. virtual, language breakdowns, and EBT/WIC usage.
3. **Visualize (Streamlit)** — a live dashboard reads directly from the database and displays key metrics and charts for a non-technical audience.

The dataset mirrors a real program season: 13 sites, 132 sessions, and 1,572 participants across July–September.

---

## What's in this repo

| File | What it is |
|------|-----------|
| `load_sfm.py` | The ETL pipeline — reads the CSV, cleans it, loads it into SQLite |
| `app.py` | The Streamlit dashboard that reads from the database |
| `practice_queries.sql` | 12 SQL analysis queries against the database |
| `sfm.db` | The SQLite database the pipeline builds |
| `requirements.txt` | Python dependencies |
| `SFM_Practice_Data.csv` | Source data (shaped like the real program export) |

---

## Tech used

**Python** (pandas) · **SQL** (SQLite) · **Streamlit** · **Git**

---

## Run it locally

```bash
pip install -r requirements.txt
python3 load_sfm.py      # builds sfm.db from the CSV
streamlit run app.py     # launches the dashboard
```

Or query the database directly:

```bash
sqlite3 sfm.db
```

---

## Why I built it

This recreates real public-health reporting work as a portfolio piece: cleaning messy program data, joining and aggregating it in SQL, and presenting it clearly for decision-makers. It combines my background in public-health data operations with a data-analytics workflow — Python, SQL, and dashboarding — end to end.



Built with Streamlit, reading live from sfm.db.

