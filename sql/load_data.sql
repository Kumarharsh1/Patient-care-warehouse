-- ================================================
-- load_data.sql
-- Bulk load CSV data into Patient Care Warehouse
-- ================================================
-- NOTE: Update file paths according to your system.
-- In PostgreSQL, use absolute path (e.g., 'C:/path/to/file.csv' or '/home/user/file.csv').
-- In MySQL, server must have access to the file directory.
-- ================================================

-- ================
-- POSTGRESQL VERSION
-- ================
-- Run with: \i load_data.sql (inside psql)

-- Load Patients
COPY Dim_Patient(patient_id, first_name, last_name, age, gender, location, risk_factors)
FROM 'data/patients.csv'
DELIMITER ',' CSV HEADER;

-- Load Diseases
COPY Dim_Disease(disease_id, disease_name, category)
FROM 'data/diseases.csv'
DELIMITER ',' CSV HEADER;

-- Load Doctors
COPY Dim_Doctor(doctor_id, doctor_name, specialization)
FROM 'data/doctors.csv'
DELIMITER ',' CSV HEADER;

-- Load Hospitals
COPY Dim_Hospital(hospital_id, hospital_name, city, state, capacity)
FROM 'data/hospitals.csv'
DELIMITER ',' CSV HEADER;

-- Load Date Dimension
COPY Dim_Date(date_id, day, month, quarter, year)
FROM 'data/date_dim.csv'
DELIMITER ',' CSV HEADER;

-- Load Visits (Fact Table)
COPY Fact_Visits(visit_id, patient_id, disease_id, doctor_id, hospital_id, visit_date, medication_cost, treatment_cost, outcome)
FROM 'data/visits.csv'
DELIMITER ',' CSV HEADER;


-- ================
-- MYSQL VERSION
-- ================
-- Run inside MySQL Workbench or CLI

-- Load Patients
LOAD DATA INFILE 'data/patients.csv'
INTO TABLE Dim_Patient
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(patient_id, first_name, last_name, age, gender, location, risk_factors);

-- Load Diseases
LOAD DATA INFILE 'data/diseases.csv'
INTO TABLE Dim_Disease
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(disease_id, disease_name, category);

-- Load Doctors
LOAD DATA INFILE 'data/doctors.csv'
INTO TABLE Dim_Doctor
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(doctor_id, doctor_name, specialization);

-- Load Hospitals
LOAD DATA INFILE 'data/hospitals.csv'
INTO TABLE Dim_Hospital
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hospital_id, hospital_name, city, state, capacity);

-- Load Date Dimension
LOAD DATA INFILE 'data/date_dim.csv'
INTO TABLE Dim_Date
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(date_id, day, month, quarter, year);

-- Load Visits (Fact Table)
LOAD DATA INFILE 'data/visits.csv'
INTO TABLE Fact_Visits
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(visit_id, patient_id, disease_id, doctor_id, hospital_id, visit_date, medication_cost, treatment_cost, outcome);
