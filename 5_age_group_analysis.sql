
## Healthcare Appointment No-Show Analysis ##

 05 - Age Group Analysis


 Does age group affect the no-show rate?

Select
    CASE
        When age < 18 Then 'Under 18'
        When age Between 18 And 30 Then '18-30'
        When age Between 31 And 45 Then '31-45'
        When age Between 46 And 60 Then '46-60'
        When age Between 61 And 75 Then '61-75'
        Else '76+'
    END as age_group,

    Count(*) AS total_appointments,

    Sum(
        CASE
            When no_show = 'Yes' Then 1
            Else 0
        END
    ) as no_shows,

    Round(
        Sum(
            CASE
                When no_show = 'Yes' Then 1
                Else 0
            END
        ) * 100.0 / Count(*),
        2
    ) as no_show_rate

From medical_appointments

Where age >= 0

GROUP BY
    CASE
        When age < 18 Then 'Under 18'
        When age Between 18 And 30 Then '18-30'
        When age Between 31 And 45 Then '31-45'
        When age Between 46 And 60 Then '46-60'
        When age Between 61 And 75 Then '61-75'
        Else '76+'
    END

Order by
    MIN(age)