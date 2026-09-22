
## Healthcare Appointment No-Show Analysis ##
08 - Patient-Level Risk Scoring


 How can we classify the risk of a patient's
next appointment being a no-show?

The risk score uses only information from previous
appointments to avoid data leakage.



// *** Calculate previous patient history ***//


WITH patient_history as (

    Select
        patient_id,
        appointment_day,
        no_show,
        lead_days_time,
        sms_received,
        age,

        // *** Number of appointments before the current appointment ***//

        Count(*) Over (
            Partition by  patient_id
            Order by appointment_day
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) as previous_appointments,

        // *** Number of previous no-shows ***//

        Sum(
            CASE
                When no_show = 'Yes' Then 1
                Else 0
            END
        ) Over (
            Partition by patient_id
            Order by appointment_day
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) as previous_no_shows

    FROM medical_appointments
),


// *** Calculate previous no-show rate ***//

patient_metrics as(

    Select
        *,

        Round(
            previous_no_shows * 100.0
            / NULLIF(previous_appointments, 0),
            2
        ) as previous_no_show_rate

    From patient_history
),

// *** Calculate risk score *** //

risk_score as (

    Select
        *,
        (
            // *** Previous no-show behavior ***//
            CASE
                When previous_appointments >= 2
                     And previous_no_show_rate >= 50
                    Then 3

                When previous_appointments >= 2
                     AND previous_no_show_rate >= 25
                    Then 2

                When  previous_appointments >= 1
                     AND previous_no_show_rate > 0
                    Then 1

                Else 0
            END

            +

            -- Lead time
            CASE
                When lead_days_time >= 31 Then 2
                When lead_days_time BETWEEN 15 AND 30 Then 1
                Else 0
            END

            +

            -- SMS reminder
            CASE
                When sms_received = 0 Then 1
                Else 0
            END

        ) as risk_score

    FROM patient_metrics
)


// *** Classify patients into risk levels ***//


Select
    patient_id,
    appointment_day,
    age,
    lead_days_time,
    sms_received,
    previous_appointments,
    previous_no_shows,
    previous_no_show_rate,
    risk_score,

    CASE
        When previous_appointments = 0
            Then 'New Patient'

        When risk_score >= 5
            Then 'High Risk'

        When risk_score >= 3
            Then 'Medium Risk'

        Else 'Low Risk'
    END as risk_level

From risk_score

Order by
    patient_id,
    appointment_day