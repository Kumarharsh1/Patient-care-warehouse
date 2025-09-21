-- ================================
-- Patient Care Warehouse Schema
-- ================================

-- Drop tables if they exist (for re-runs)
DROP TABLE IF EXISTS Fact_Visits;
DROP TABLE IF EXISTS Dim_Patient;
DROP TABLE IF EXISTS Dim_Disease;
DROP TABLE IF EXISTS Dim_Doctor;
DROP TABLE IF EXISTS Dim_Hospital;
DROP TABLE IF EXISTS Dim_Date;

-- ================================
-- Dimension Tables
-- ================================

CREATE TABLE Dim_Patient (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    location VARCHAR(100),
    risk_factors VARCHAR(255)
);

CREATE TABLE Dim_Disease (
    disease_id INT PRIMARY KEY,
    disease_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE Dim_Doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Dim_Hospital (
    hospital_id INT PRIMARY KEY,
    hospital_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    capacity INT
);

CREATE TABLE Dim_Date (
    date_id DATE PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT
);

-- ================================
-- Fact Table
-- ================================

CREATE TABLE Fact_Visits (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    disease_id INT,
    doctor_id INT,
    hospital_id INT,
    visit_date DATE,
    medication_cost DECIMAL(10,2),
    treatment_cost DECIMAL(10,2),
    outcome VARCHAR(50),

    FOREIGN KEY (patient_id) REFERENCES Dim_Patient(patient_id),
    FOREIGN KEY (disease_id) REFERENCES Dim_Disease(disease_id),
    FOREIGN KEY (doctor_id) REFERENCES Dim_Doctor(doctor_id),
    FOREIGN KEY (hospital_id) REFERENCES Dim_Hospital(hospital_id),
    FOREIGN KEY (visit_date) REFERENCES Dim_Date(date_id)
);
