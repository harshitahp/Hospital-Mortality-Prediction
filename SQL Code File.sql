SET SQL_SAFE_UPDATES = 0;

UPDATE hospital.dataset
SET ethnicity = CASE
    WHEN ethnicity = '' THEN 'Mixed'
    ELSE ethnicity
END;

-- How many total deaths occured in the hospital and what was the percentage of the mortality rate?
SELECT COUNT(CASE WHEN hospital_death = 1 THEN 1 END) AS total_hospital_deaths, 
ROUND(COUNT(CASE WHEN hospital_death = 1 THEN 1 END)*100/COUNT(*),2) AS mortality_rate
FROM hospital.dataset

-- What was the death count of each ethnicity? 
SELECT ethnicity, COUNT(hospital_death) AS total_hospital_deaths
FROM hospital.dataset
WHERE hospital_death = 1
GROUP BY ethnicity;

-- What was the death count of each gender? 
SELECT gender, COUNT(hospital_death) as total_hospital_deaths
FROM hospital.dataset
WHERE hospital_death = '1'
GROUP BY gender 
 
 -- Comparing the average and max ages of patients who died and patients who survived
SELECT ROUND(AVG(age),2) as avg_age,
MAX(age) as max_age, 
hospital_death
FROM hospital.dataset
WHERE hospital_death = '1'
GROUP BY hospital_death
UNION
SELECT ROUND(AVG(age),2) as avg_age,
MAX(age) as max_age, 
hospital_death
FROM hospital.dataset
WHERE hospital_death = '0'
GROUP BY hospital_death

SELECT age,
	COUNT(CASE WHEN hospital_death = '1' THEN 1 END) as amount_that_died,
	COUNT(CASE WHEN hospital_death = '0' THEN 1 END) as amount_that_survived
FROM hospital.dataset
GROUP BY age
ORDER BY age ASC;

-- Age distribution of patients in 10-year intervals 
SELECT
    CONCAT(FLOOR(age/10)*10, '-', FLOOR(age/10)*10+9) AS age_interval,
    COUNT(*) AS patient_count
FROM hospital.dataset
GROUP BY age_interval
ORDER BY age_interval;

-- Amount of patients above 65 who died vs Amount of patients between 50-65 who died
SELECT COUNT(CASE WHEN age > 65 AND hospital_death = '0' THEN 1 END) as survived_over_65,
       COUNT(CASE WHEN age BETWEEN 50 AND 65 AND hospital_death = '0' THEN 1 END) as survived_between_50_and_65,
       COUNT(CASE WHEN age > 65 AND hospital_death = '1' THEN 1 END) as died_over_65,
       COUNT(CASE WHEN age BETWEEN 50 AND 65 AND hospital_death = '1' THEN 1 END) as died_between_50_and_65
FROM hospital.dataset;

-- Calculating the average probability of hospital death for patients of different age groups
SELECT
    CASE
        WHEN age < 40 THEN 'Under 40'
        WHEN age >= 40 AND age < 60 THEN '40-59'
        WHEN age >= 60 AND age < 80 THEN '60-79'
        ELSE '80 and above'
    END AS age_group,
    ROUND(AVG(apache_4a_hospital_death_prob),3) AS average_death_prob
FROM hospital.dataset
GROUP BY age_group;

-- Which admit source of the ICU did most patients die in and get admitted to?
SELECT DISTINCT icu_admit_source,
COUNT(CASE WHEN hospital_death = '1' THEN 1 END) as amount_that_died,
COUNT(CASE WHEN hospital_death = '0' THEN 1 END) as amount_that_survived
FROM hospital.dataset
GROUP BY icu_admit_source;

-- Average weight, bmi, and max heartrate of people who died
SELECT ROUND(AVG(weight),2) as avg_weight,
	ROUND(AVG(bmi),2) as avg_bmi, 
    ROUND(AVG(d1_heartrate_max),2) as avg_max_heartrate
FROM hospital.dataset
WHERE hospital_death = '1'

-- What was the percentage of patients with each comorbidity among those who died? 
SELECT
    ROUND(SUM(CASE WHEN aids = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS aids_percentage,
    ROUND(SUM(CASE WHEN cirrhosis = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS cirrhosis_percentage,
    ROUND(SUM(CASE WHEN diabetes_mellitus = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS diabetes_percentage,
    ROUND(SUM(CASE WHEN hepatic_failure = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS hepatic_failure_percentage,
    ROUND(SUM(CASE WHEN immunosuppression = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS immunosuppression_percentage,
    ROUND(SUM(CASE WHEN leukemia = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS leukemia_percentage,
    ROUND(SUM(CASE WHEN lymphoma = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS lymphoma_percentage,
    ROUND(SUM(CASE WHEN solid_tumor_with_metastasis = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*),2) AS solid_tumor_percentage
FROM hospital.dataset
WHERE hospital_death = 1;

SELECT
    COUNT(CASE WHEN hospital_death = 1 THEN 1 END)*100/COUNT(*) AS mortality_rate
FROM hospital.dataset;

-- What was the average length of stay at each ICU for patients who survived and those who didn't? 
SELECT
    icu_type,
    ROUND(AVG(CASE WHEN hospital_death = 1 THEN pre_icu_los_days END), 2) AS avg_icu_stay_death,
    ROUND(AVG(CASE WHEN hospital_death = 0 THEN pre_icu_los_days END), 2) AS avg_icu_stay_survived
FROM hospital.dataset
GROUP BY icu_type
ORDER BY icu_type;

-- What was the average BMI for patients that died based on ethnicity? (excluding missing or null values)
SELECT
    ethnicity,
    ROUND(AVG(bmi),2) AS average_bmi
FROM hospital.daatset
WHERE bmi IS NOT NULL
AND hospital_death = '1'
GROUP BY ethnicity;

-- Hospital death probabilities where the ICU type is 'SICU' and BMI is above 30
SELECT
    patient_id,
    apache_4a_hospital_death_prob as hospital_death_prob
FROM hospital.dataset
WHERE icu_type = 'SICU' AND bmi > 30
ORDER BY hospital_death_prob DESC;

