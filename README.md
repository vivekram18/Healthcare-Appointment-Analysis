Healthcare Appointment  Analysis
Project Overview

This project analyzes healthcare appointment data to identify patterns linked with patient no-shows.
The analysis was performed using PostgreSQL and focuses on appointment behavior, lead time, age groups, SMS reminders, neighborhood-level patterns, and previous patient appointment history.
A rule-based patient-level risk scoring approach was also developed using historical appointment behavior while avoiding data leakage.

Business Questions

The project answers the following questions:

1. What is the overall appointment no-show rate?
2. Does the day of the week affect the no-show rate?
3. Does appointment lead time affect no-shows?
4. Does age group affect the no-show rate?
5. Do SMS reminders have an association with no-show rates?
6. Which neighborhoods have higher no-show rates?
7. Can previous patient appointment behavior be used to classify no-show risk?


Dataset

Dataset: Medical Appointment  Dataset

The dataset contains information about healthcare appointments, including:

Patient ID
Appointment date
Scheduled date
Age
Gender
Neighborhood
Scholarship status
Hypertension
Diabetes
Alcoholism
Handicap
SMS reminder status
Appointment outcome

Tools & Technologies

PostgreSQL
SQL
pgAdmin
Excel
Data Cleaning
Exploratory Data Analysis

SQL Concepts Used

SELECT
WHERE
GROUP BY
HAVING
ORDER BY
CASE statements
Aggregate functions
Subqueries
CTEs
Window functions
LAG()
COUNT()
SUM()
ROUND()
Date functions
CREATE VIEW
Conditional aggregation

Analysis

1. Overall No-Show Rate

Calculated the overall percentage of appointments where patients did not attend their scheduled appointment.

2. Day-of-Week Analysis

Compared appointment  and no-show rates across different days of the week to identify differences in appointment attendance patterns.

3. Lead-Time Analysis

Grouped appointments according to the number of days between scheduling and the appointment date.
Lead-time groups included:

Same Day
1-7 Days
8-14 Days
15-30 Days
31+ Days

The no-show rate was compared across these groups.

4. Age Group Analysis

Patients were grouped into age categories and their appointment no-show rates were compared.

5. SMS Reminder Analysis

Compared  no-show rates between appointments where patients received an SMS reminder and appointments where they did not.

The analysis was also segmented by appointment lead time.

6. Neighborhood Analysis

Calculated appointment volume, total no-shows, and observed no-show rates for each neighborhood.

Neighborhoods with very small appointment volumes were excluded using a minimum appointment threshold to reduce misleading rate comparisons.

7. Patient-Level Risk Scoring

Developed a rule-based risk score using historical patient behavior.

The scoring approach considers factors such as:

Previous appointment history
Previous no-show behavior
Historical no-show rate
Appointment lead time
SMS reminder status

Patients were classified into:

New Patient
Low Risk
Medium Risk
High Risk

Historical features were calculated using only previous appointments to prevent data leakage.

Data Leakage Prevention

A key part of the project was ensuring that information from the current appointment was not used to calculate its own risk score.

For example, historical appointment metrics were calculated using:

ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING

rather than:

ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

This ensures that the current appointment's outcome is not included when calculating its risk.

Project Structure
Healthcare-Appointment-No-Show-Analysis/

── README.md

── data/
   └── KaggleV2-May-2016.csv

── sql/
   ├── 01_data_cleaning.sql
   ├── 02_overall_no_show.sql
   ├── 03_day_of_week_analysis.sql
   ├── 04_lead_time_analysis.sql
   ├── 05_age_group_analysis.sql
   ├── 06_sms_lead_time_analysis.sql
   ├── 07_neighborhood_analysis.sql
   └── 08_patient_risk_scoring.sql

── screenshots/

Key Skills Demonstrated

This project shows practical experience in:

SQL: Data cleaning, aggregation, CTEs,  joins, window functions, conditional logic, and analytical queries.

Data Analysis: Exploratory analysis, segmentation, rate calculations, behavioral analysis, and risk classification.

Data Quality: Handling dates, missing values, invalid values, and preventing data leakage.

Business Analysis: Translating healthcare appointment data into measurable business questions and actionable analytical metrics.

Disclaimer

The patient-level risk score is a rule-based analytical exercise created for portfolio purposes. It is not a clinically validated medical prediction model




