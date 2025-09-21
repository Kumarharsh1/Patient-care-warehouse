-- ================================================
-- etl.sql
-- Data cleaning, transformations, and aggregates
-- Patient-Care-Warehouse
-- ================================================

-- 1. Normalize patient names and locations
-- Capitalize first letters for consistency
UPDATE Dim_Patient
SET first_name = INITCAP(first_name),
    last_name  = INITCAP(last_name),
    location   = INITCAP(location);

-- 2. Remove duplicate patients (if any)
DELETE FROM Dim_Patient a
USING Dim_Patient b
WHERE a.patient_id < b.patient_id
  AND a.first_name = b.first_name
  AND a.last_name = b.last_name;

-- 3. Add high-risk flag for patients
-- Criteria: age > 60 OR having risk factors like Diabetes, Heart Disease, Hypertension
ALTER TABLE Dim_Patient
ADD COLUMN high_risk BOOLEAN DEFAULT FALSE;

UPDATE Dim_Patient
SET high_risk = CASE
    WHEN age > 60 OR risk_factors IN ('Diabetes','Heart Disease','Hypertension') THEN TRUE
    ELSE FALSE
END;

-- 4. Create aggregated table: total cost per hospital
DROP TABLE IF EXISTS Agg_Hospital_Cost;
CREATE TABLE Agg_Hospital_Cost AS
SELECT h.hospital_id,
       h.hospital_name,
       SUM(f.treatment_cost + f.medication_cost) AS total_cost,
       COUNT(f.visit_id) AS total_visits
FROM Fact_Visits f
JOIN Dim_Hospital h ON f.hospital_id = h.hospital_id
GROUP BY h.hospital_id, h.hospital_name;

-- 5. Create aggregated table: disease prevalence
DROP TABLE IF EXISTS Agg_Disease_Prevalence;
CREATE TABLE Agg_Disease_Prevalence AS
SELECT d.disease_id,
       d.disease_name,
       COUNT(f.patient_id) AS total_patients,
       ROUND(AVG(p.age),2) AS avg_age
FROM Fact_Visits f
JOIN Dim_Disease d ON f.disease_id = d.disease_id
JOIN Dim_Patient p ON f.patient_id = p.patient_id
GROUP BY d.disease_id, d.disease_name;

-- 6. Create aggregated table: doctor workload
DROP TABLE IF EXISTS Agg_Doctor_Workload;
CREATE TABLE Agg_Doctor_Workload AS
SELECT doc.doctor_id,
       doc.doctor_name,
       doc.specialization,
       COUNT(f.visit_id) AS visits_handled,
       SUM(f.treatment_cost + f.medication_cost) AS total_cost
FROM Fact_Visits f
JOIN Dim_Doctor doc ON f.doctor_id = doc.doctor_id
GROUP BY doc.doctor_id, doc.doctor_name, doc.specialization;

-- 7. Optional: create a view for high-risk patients and their recent visits
DROP VIEW IF EXISTS View_HighRisk_Visits;
CREATE VIEW View_HighRisk_Visits AS
SELECT p.patient_id,
       p.first_name,
       p.last_name,
       p.age,
       p.risk_factors,
       f.visit_id,
       f.visit_date,
       d.disease_name,
       f.outcome,
       (f.treatment_cost + f.medication_cost) AS total_visit_cost
FROM Fact_Visits f
JOIN Dim_Patient p ON f.patient_id = p.patient_id
JOIN Dim_Disease d ON f.disease_id = d.disease_id
WHERE p.high_risk = TRUE
ORDER BY p.patient_id, f.visit_date;

-- ================================================
-- ETL Completed
-- ================================================
