 ## Healthcare Appointment No-Show Analysis ##

 03 - Day of Week Analysis

 Q2. Does the day of the week affect the no-show rate?

Select
    Extract(ISODOW From appointment_day) as day_number,

    To_char(appointment_day, 'Day') as day_of_week,

    Count(*) AS total_appointments,

    Sum(
        CASE
            When no_show = 'Yes' Then 1
            Else 0
        END
    ) as no_shows,

    Round(
        SUM(
            CASE
                When  no_show = 'Yes' Then 1
                Else 0
            END
        ) * 100.0 / Count(*),
        2
    ) as no_show_rate

From medical_appointments

Group by
    Extract(ISODOW From appointment_day),
    To_char(appointment_day, 'Day')

order by
    day_number