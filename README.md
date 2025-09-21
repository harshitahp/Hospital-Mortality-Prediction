Data Set Used :- https://www.kaggle.com/datasets/mitishaagarwal/patient

**Problem**
Healthcare professionals wanted to identify the main causes of in-hospital mortality for admitted patients. A better understanding of these causes could help in designing targeted interventions and evidence-based protocols to reduce preventable deaths.

**My Approach**
To address this problem, I carried out a comprehensive data analysis using SQL.

**Data Preparation**
1. Obtained the dataset and initially worked with it in Excel for cleaning and formatting.
2. Imported the cleaned dataset into MySQL for structured querying and analysis.

**Analysis in SQL**
1. Designed and executed SQL queries to explore patient attributes such as age, gender, ethnicity, weight, BMI, heart rate, comorbidities, ICU admission source, and ICU stay length.
2. Focused on comparing outcomes between patients who survived and those who did not, to uncover key risk factors.

**Key Findings**

**Overall Mortality Rate**

1. Out of 10,000 admitted patients, 634 died, giving an in-hospital mortality rate of 6.34%.
2. This highlighted the importance of identifying predictors of death.

**Age as a Predictor**

1. Age was one of the strongest determinants of mortality.
2. Children aged 0–9 had the highest percentage mortality, while patients aged 50–89 showed a steady increase in risk.
3. Among patients aged 70–89, nearly 1 in 6 died during hospitalization.

**ICU Admission Source & Type**

1. Most patients were admitted through Accident & Emergency, which also recorded the highest number of deaths.
2. However, the “Floor” admit source had the highest mortality percentage (11.76%).
3. In terms of ICU type, Med-Surg ICU stood out as an outlier with unusually high mortality.

**Patient Characteristics**

1. Patients who died had, on average:
2. Weight: 67.6 kg
3. BMI: 23.3 (within normal range)
4. Max Heart Rate: 115.1 bpm (above the threshold for tachycardia)
5. This showed that weight/BMI were not major predictors, but heart rate abnormalities were strongly linked to mortality.

**Comorbidities**

1. Out of 8 comorbidities, the top three with the highest mortality risk were:
2. Diabetes (24.45%)
3. Immunosuppression
4. Solid Tumor
5. Diabetes stood out as the single most important comorbidity influencing outcomes.

**Length of Stay in ICU**
1. Patients staying longer than one day in ICU had significantly higher mortality.
2. This aligns with medical literature that prolonged ICU stays are linked to complications and organ system failures.

**Conclusion**

1. From this analysis, I identified four major predictors of in-hospital mortality:
2. Advanced Age – Nearly 20% of patients over 70 died.
3. Comorbidities – Diabetes was the strongest risk factor.
4. Abnormal Heart Rate – Average max heart rate of deceased patients was 115.1 bpm.
5. Prolonged ICU Stay – Longer ICU stays correlated with higher mortality.

**Recommendations & Next Steps**

1. Expand the dataset to include missing but critical factors like medications, surgeries, treatments, and other vital signs.
2. Incorporate socioeconomic and psychosocial variables, as these strongly influence access to care and patient outcomes.
3. Develop predictive models that integrate clinical, demographic, and behavioral factors to proactively identify high-risk patients upon admission.
