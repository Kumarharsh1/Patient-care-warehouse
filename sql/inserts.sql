-- ==============================================
-- Inserts for Patient-Care-Warehouse Data
-- ==============================================

-- Insert Patients
INSERT INTO Dim_Patient (patient_id, first_name, last_name, age, gender, location, risk_factors) VALUES
(1,'Arjun','Sharma',45,'M','Delhi','Smoker'),
(2,'Priya','Verma',52,'F','Mumbai','Hypertension'),
(3,'Ravi','Patel',60,'M','Bangalore','Diabetes'),
(4,'Neha','Gupta',38,'F','Chennai','Obesity'),
(5,'Amit','Kumar',55,'M','Kolkata','High Cholesterol'),
(6,'Sunita','Mehra',49,'F','Hyderabad','Hypertension'),
(7,'Vikram','Rao',42,'M','Pune','Smoker'),
(8,'Anjali','Desai',36,'F','Ahmedabad','None'),
(9,'Deepak','Yadav',58,'M','Jaipur','Diabetes'),
(10,'Sneha','Nair',47,'F','Thiruvananthapuram','Hypertension'),
(11,'Manish','Chopra',53,'M','Lucknow','Obesity'),
(12,'Kavita','Singh',41,'F','Bhopal','High Cholesterol'),
(13,'Suresh','Iyer',65,'M','Delhi','Diabetes'),
(14,'Meena','Kaur',39,'F','Mumbai','None'),
(15,'Rajesh','Jain',50,'M','Indore','Smoker'),
(16,'Shalini','Reddy',44,'F','Hyderabad','Hypertension'),
(17,'Nitin','Bhatt',59,'M','Chandigarh','Diabetes'),
(18,'Radha','Pillai',37,'F','Chennai','None'),
(19,'Ajay','Malhotra',46,'M','Kolkata','High Cholesterol'),
(20,'Lakshmi','Menon',48,'F','Thiruvananthapuram','Obesity'),
(21,'Rohan','Shukla',40,'M','Delhi','Smoker'),
(22,'Geeta','Joshi',51,'F','Pune','Hypertension'),
(23,'Sanjay','Agarwal',56,'M','Jaipur','Diabetes'),
(24,'Pooja','Chawla',35,'F','Bangalore','None'),
(25,'Harish','Goyal',62,'M','Ahmedabad','Heart Disease');

-- Insert Diseases
INSERT INTO Dim_Disease (disease_id, disease_name, category) VALUES
(1,'Diabetes','Chronic'),
(2,'Hypertension','Chronic'),
(3,'Asthma','Chronic'),
(4,'Heart Disease','Chronic'),
(5,'Arthritis','Chronic');

-- Insert Doctors
INSERT INTO Dim_Doctor (doctor_id, doctor_name, specialization) VALUES
(1,'Dr. Ramesh Kulkarni','Cardiologist'),
(2,'Dr. Anitha Menon','Endocrinologist'),
(3,'Dr. Vivek Agarwal','General Physician'),
(4,'Dr. Kavya Reddy','Pulmonologist'),
(5,'Dr. Sanjay Deshmukh','Orthopedic');

-- Insert Hospitals
INSERT INTO Dim_Hospital (hospital_id, hospital_name, city, state, capacity) VALUES
(1,'Apollo Hospital','Delhi','Delhi',500),
(2,'Fortis Healthcare','Mumbai','Maharashtra',400),
(3,'Manipal Hospital','Bangalore','Karnataka',350),
(4,'Global Hospital','Chennai','Tamil Nadu',300),
(5,'Medanta Hospital','Gurgaon','Haryana',450);

-- Insert Dates
INSERT INTO Dim_Date (date_id, date, day, month, quarter, year) VALUES
(1,'2023-01-12',12,1,'Q1',2023),
(2,'2023-02-18',18,2,'Q1',2023),
(3,'2023-03-05',5,3,'Q1',2023),
(4,'2023-03-22',22,3,'Q1',2023),
(5,'2023-04-10',10,4,'Q2',2023),
(6,'2023-04-25',25,4,'Q2',2023),
(7,'2023-05-11',11,5,'Q2',2023),
(8,'2023-05-27',27,5,'Q2',2023),
(9,'2023-06-02',2,6,'Q2',2023),
(10,'2023-06-19',19,6,'Q2',2023),
(11,'2023-07-03',3,7,'Q3',2023),
(12,'2023-07-20',20,7,'Q3',2023),
(13,'2023-08-08',8,8,'Q3',2023),
(14,'2023-08-21',21,8,'Q3',2023),
(15,'2023-09-05',5,9,'Q3',2023),
(16,'2023-09-18',18,9,'Q3',2023),
(17,'2023-10-07',7,10,'Q4',2023),
(18,'2023-10-23',23,10,'Q4',2023),
(19,'2023-11-11',11,11,'Q4',2023),
(20,'2023-11-28',28,11,'Q4',2023),
(21,'2023-12-09',9,12,'Q4',2023),
(22,'2023-12-22',22,12,'Q4',2023),
(23,'2024-01-05',5,1,'Q1',2024),
(24,'2024-01-19',19,1,'Q1',2024),
(25,'2024-02-02',2,2,'Q1',2024);

-- Insert Visits (Fact Table)
INSERT INTO Fact_Visits (visit_id, patient_id, disease_id, doctor_id, hospital_id, visit_date, medication_cost, treatment_cost, outcome) VALUES
(1,1,2,3,1,'2023-01-12',1200,3000,'Stable'),
(2,2,2,1,2,'2023-02-18',1500,3500,'Improved'),
(3,3,1,2,3,'2023-03-05',2000,4000,'Stable'),
(4,4,3,4,4,'2023-03-22',900,2500,'Improved'),
(5,5,4,1,5,'2023-04-10',2500,5000,'Deteriorated'),
(6,6,2,3,2,'2023-04-25',1400,3000,'Stable'),
(7,7,4,1,1,'2023-05-11',2200,4500,'Improved'),
(8,8,3,4,3,'2023-05-27',1100,2800,'Stable'),
(9,9,1,2,2,'2023-06-02',2100,4200,'Deteriorated'),
(10,10,2,3,4,'2023-06-19',1300,3100,'Stable'),
(11,11,5,5,5,'2023-07-03',1800,3800,'Improved'),
(12,12,2,3,1,'2023-07-20',1600,3400,'Stable'),
(13,13,1,2,2,'2023-08-08',2300,4600,'Deteriorated'),
(14,14,3,4,4,'2023-08-21',1000,2900,'Improved'),
(15,15,4,1,5,'2023-09-05',2600,5200,'Stable'),
(16,16,2,3,3,'2023-09-18',1500,3200,'Improved'),
(17,17,1,2,1,'2023-10-07',2400,4800,'Deteriorated'),
(18,18,3,4,2,'2023-10-23',950,2700,'Stable'),
(19,19,4,1,5,'2023-11-11',2700,5300,'Improved'),
(20,20,5,5,4,'2023-11-28',1900,3900,'Stable'),
(21,21,2,3,2,'2023-12-09',1450,3050,'Stable'),
(22,22,1,2,3,'2023-12-22',2200,4600,'Improved'),
(23,23,4,1,1,'2024-01-05',2800,5400,'Deteriorated'),
(24,24,3,4,2,'2024-01-19',1050,2950,'Stable'),
(25,25,4,1,5,'2024-02-02',3000,5600,'Improved');
