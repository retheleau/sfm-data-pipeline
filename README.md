# SFM Data Pipeline Project

One project, three lanes: Data Analyst (Excel/Power BI) -> Data Engineer
(Python ETL -> SQLite) -> SysAdmin/Cloud (cron + GCP, later).

It recreates the real monthly reporting workflow from the NYC Bureau of
Chronic Disease Prevention  using mock data
shaped exactly like the real export.

## What's in this folder

| File                     | What it is                                          |
|--------------------------|-----------------------------------------------------|
| SFM_Project_Guide.pdf    | THE GUIDE. Read Phase 0 first. Do phases in order.  |
| SFM_Practice_Data.xlsx   | 2-tab Excel file (mirrors the PEARS export) - Phase 1 |
| SFM_Practice_Data.csv    | Flat version for the pipeline + Power BI - Phases 2-4 |
| load_sfm.py              | The ETL pipeline script (CSV -> clean -> SQLite)    |
| practice_queries.sql     | 12 SQL exercises against your own database          |

## Quick start (Phase 2, on your Debian terminal)

    pip install pandas --break-system-packages   # if not installed
    python3 load_sfm.py                           # builds sfm.db
    sqlite3 sfm.db                                # query your database

Then open practice_queries.sql and type the queries by hand.

## The rule

Phases in order. One phase at a time. A finished Phase 1 beats four
started phases. The guide has the full path.
