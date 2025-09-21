-- ================================================
-- queries.sql
-- Common analytics queries for Patient Care Warehouse
-- ================================================

-- 1. Count of patients per disease
SELECT d.disease_name, COUNT(f.patient_id) AS patient_count
FROM Fact_Visits f
JOIN Dim_Disease d ON f.disease_id = d.disease_id
GROUP BY d.disease_name
ORDER BY patient_count DESC;

-- 2. Disease prevalence by age group
SELECT 
    CASE 
        WHEN p.age BETWEEN 0 AND 18 THEN '0-18'
        WHEN p.age BETWEEN 19 AND 35 THEN '19-35'
        WHEN p.age BETWEEN 36 AND 50 THEN '36-50'
        WHEN p.age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END AS age_group,
    d.disease_name,
    COUNT(*) AS total_patients
FROM Fact_Visits f
JOIN Dim_Patient p ON f.patient_id = p.patient_id
JOIN Dim_Disease d ON f.disease_id = d.disease_id
GROUP BY age_group, d.disease_name
ORDER BY age_group, total_patients DESC;

-- 3. Average treatment & medication cost per hospital
SELECT h.hospital_name,
       ROUND(AVG(f.treatment_cost),2) AS avg_treatment_cost,
       ROUND(AVG(f.medication_cost),2) AS avg_medication_cost
FROM Fact_Visits f
JOIN Dim_Hospital h ON f.hospital_id = h.hospital_id
GROUP BY h.hospital_name
ORDER BY avg_treatment_cost DESC;

-- 4. Most common outcome per disease
SELECT d.disease_name, f.outcome, COUNT(*) AS count_outcome
FROM Fact_Visits f
JOIN Dim_Disease d ON f.disease_id = d.disease_id
GROUP BY d.disease_name, f.outcome
ORDER BY d.disease_name, count_outcome DESC;

-- 5. Readmission rate (patients with more than 1 visit)
SELECT p.patient_id, p.first_name, p.last_name, COUNT(f.visit_id) AS total_visits
FROM Fact_Visits f
JOIN Dim_Patient p ON f.patient_id = p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(f.visit_id) > 1
ORDER BY total_visits DESC;

-- 6. Total healthcare cost per year
SELECT d.year, SUM(f.treatment_cost + f.medication_cost) AS total_cost
FROM Fact_Visits f
JOIN Dim_Date d ON f.visit_date = d.date_id
GROUP BY d.year
ORDER BY d.year;

-- 7. Doctor workload (visits handled per doctor)
SELECT doc.doctor_name, doc.specialization, COUNT(f.visit_id) AS visits_handled
FROM Fact_Visits f
JOIN Dim_Doctor doc ON f.doctor_id = doc.doctor_id
GROUP BY doc.doctor_name, doc.specialization
ORDER BY visits_handled DESC;

-- 8. Hospital patient distribution
SELECT h.hospital_name, COUNT(DISTINCT f.patient_id) AS unique_patients
FROM Fact_Visits f
JOIN Dim_Hospital h ON f.hospital_id = h.hospital_id
GROUP BY h.hospital_name
ORDER BY unique_patients DESC;

-- 9. Cost comparison by disease
SELECT d.disease_name,
       ROUND(AVG(f.treatment_cost + f.medication_cost),2) AS avg_total_cost
FROM Fact_Visits f
JOIN Dim_Disease d ON f.disease_id = d.disease_id
GROUP BY d.disease_name
ORDER BY avg_total_cost DESC;

-- 10. Patients at high risk (costly treatments + multiple visits)
SELECT p.patient_id, p.first_name, p.last_name,
       SUM(f.treatment_cost + f.medication_cost) AS total_spent,
       COUNT(f.visit_id) AS total_visits
FROM Fact_Visits f
JOIN Dim_Patient p ON f.patient_id = p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(f.visit_id) > 2 OR SUM(f.treatment_cost + f.medication_cost) > 5000
ORDER BY total_spent DESC;
