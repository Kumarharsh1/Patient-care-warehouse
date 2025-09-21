# Patient Care Data Warehouse

## Overview
This project is a **Chronic Disease Management Data Warehouse** for analyzing patients, treatments, and hospital visits.  
It uses a **star schema** with Fact_Visits and dimension tables for Patients, Diseases, Doctors, Hospitals, and Dates.  

## Features
- Track chronic diseases (Diabetes, Hypertension, Heart Disease, etc.)
- Identify high-risk patients
- Calculate hospital costs and doctor workloads
- Pre-built analytics queries and ETL scripts
- Power BI dashboards for interactive reporting

## Folder Structure
<pre>
patient-care-warehouse/
│
├── data/ # CSVs: patients, doctors, diseases, hospitals, visits
├── sql/
│ ├── schema.sql
│ ├── inserts.sql
│ ├── load_data.sql
│ ├── etl.sql
│ └── queries.sql
├── erd/ # ER diagram images
├── powerbi/ # PBIX dashboards
├── docs/ # Documentation
├── README.md
├── requirements.txt # Python dependencies (if ETL done in Python)
└── .gitignore </pre>

## How to Run
1. Load schema: `sql/schema.sql`  
2. Load data: `sql/inserts.sql` or `sql/load_data.sql`  
3. Run ETL: `sql/etl.sql`  
4. Run analytics queries: `sql/queries.sql`  
5. Open `powerbi/dashboard.pbix` to visualize results

## Authors
- Your Name  
- Sample Team: 25 fake patients, doctors, hospitals

