*** Healthcare Appointment  Analysis ***

 Project Overview

This project analyzes healthcare appointment data to identify patterns associated with patient no-shows.

The analysis was performed using PostgreSQL and SQL, covering:

 Overall no-show rate
 Day-of-week patterns
 Appointment lead time
 Age-group behavior
 SMS reminder patterns
 Neighborhood-level no-show rates
 Patient-level historical risk scoring

A rule-based patient risk scoring approach was also developed using historical appointment behavior while avoiding data leakage.



 Business Objective

Healthcare providers need to understand why patients miss scheduled appointments because no-shows can affect appointment utilization and operational planning.

This project uses appointment-level data to identify behavioral patterns associated with no-shows and demonstrate how SQL can be used to transform raw healthcare data into analytical insights.



 Business Questions

The analysis addresses the following questions:

1. What is the overall appointment no-show rate?
2. Does the day of the week affect the no-show rate?
3. Does appointment lead time affect no-shows?
4. Does age group affect the no-show rate?
5. Does the relationship between SMS reminders and no-shows differ by appointment lead time?
6. Which neighborhoods have higher observed no-show rates?
7. Can previous patient appointment behavior be used to classify no-show risk?



 Dataset

Dataset -> Medical Appointment No-Show Dataset

The dataset contains information related to healthcare appointments, including:

 Patient ID
 Scheduled date
 Appointment date
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



Data Cleaning

The data-cleaning process included:

 Inspecting the imported dataset
 Renaming columns for clarity
 Checking categorical values
 Cleaning date formats
 Converting appointment dates into appropriate date/time formats
 Identifying invalid age values
 Creating appointment lead-time features
 Checking for negative lead-time values

Appointment Lead Time

Lead time was calculated as the number of days between:

 Appointment Date - Scheduled Date

Appointments were then grouped into:

 Same Day
 1–7 Days
 8–14 Days
 15–30 Days
 31+ Days



SQL Analysis

1. Overall No-Show Rate

Calculated the overall percentage of appointments where patients did not attend their scheduled appointment.

2. Day-of-Week Analysis

Compared appointment volume and no-show rates across different days of the week.

3. Lead-Time Analysis

Analyzed whether the amount of time between scheduling and the appointment was associated with different no-show rates.

4. Age-Group Analysis

Patients were segmented into age groups and their no-show rates were compared.

5. SMS Reminder Analysis

Compared no-show rates between appointments where patients received an SMS reminder and appointments where they did not.

The analysis was further segmented by appointment lead time.

6. Neighborhood Analysis

Calculated:

 Appointment volume
 Number of no-shows
 Observed no-show rate

Neighborhoods with fewer than 100 appointments were excluded from the comparison to reduce the impact of very small sample sizes.

 7. Patient-Level Risk Scoring

Developed a rule-based risk score using historical patient behavior.

The scoring approach considers:

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



 Data Leakage Prevention

A key part of the project was ensuring that information from the current appointment was not used to calculate its own risk score.

Historical features were calculated using only previous appointments:

//***sql***//
ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING