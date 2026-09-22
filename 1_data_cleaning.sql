
/// Healthcare Appointment No-Show Analysis ///

 01 - Data Cleaning

##1. Inspect the imported table

SELECT *
FROM medical_appointments


 Check the date columns
SELECT
    scheduled_day,
    appointment_day
FROM medical_appointments

##2. Rename columns for better readability


 Example:
 ALTER TABLE medical_appointments
     CHANGE COLUMN Hipertension hypertension INT,
     CHANGE COLUMN Handcap handicap INT,
     CHANGE COLUMN No-show no_show VARCHAR(3)

## 3. Check disability/handicap values


 SELECT     disability_count,
    COUNT(*)
 FROM medical_appointments
 GROUP BY disability_count


## 4. Clean date columns


 The original date values contain 'T' and 'Z'.
 PostgreSQL can convert these ISO-formatted values
 directly to TIMESTAMPTZ.

 Create temporary/clean columns

ALTER TABLE medical_appointments
ADD COLUMN scheduled_day_clean TIMESTAMPTZ,
ADD COLUMN appointment_day_clean TIMESTAMPTZ

##TIMESTAMPTZ in PostgreSQL means Timestamp With Time Zone. ##

 Convert scheduled_day

UPDATE medical_appointments
SET scheduled_day_clean = scheduled_day::TIMESTAMPTZ


Convert appointment_day

UPDATE medical_appointments
SET appointment_day_clean = appointment_day::TIMESTAMPTZ


 Check the converted values

SELECT
    scheduled_day,
    scheduled_day_clean,
    appointment_day,
    appointment_day_clean
FROM medical_appointments
LIMIT 10


## 5. Replace the original date columns

 After validating the cleaned columns:

ALTER TABLE medical_appointments
DROP COLUMN scheduled_day,
DROP COLUMN appointment_day


 Rename the cleaned columns

ALTER TABLE medical_appointments
RENAME COLUMN scheduled_day_clean TO scheduled_day

ALTER TABLE medical_appointments
RENAME COLUMN appointment_day_clean TO appointment_day



## 6. Check for invalid age values


SELECT
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age
FROM medical_appointments


 The original analysis identified age = -1 as an invalid value.

 // DELETE FROM medical_appointments
 // WHERE age = -1


## 7. Create appointment lead-time field


 Lead time = number of days between
 appointment booking and appointment date.

 ALTER TABLE medical_appointments
 ADD COLUMN lead_days_time INT


** Calculate lead time:

 UPDATE medical_appointments
SET lead_days_time =
    appointment_day::date - scheduled_day::date
     


 Check the minimum and maximum lead time:

 SELECT
     MIN(lead_days_time) AS minimum_lead_time,
     MAX(lead_days_time) AS maximum_lead_time
 FROM medical_appointments;


** Check for negative lead times:

 SELECT *
 FROM medical_appointments
 WHERE lead_days_time < 0


 Remove invalid negative lead-time records if required:

// DELETE FROM medical_appointments
// WHERE lead_days_time < 0