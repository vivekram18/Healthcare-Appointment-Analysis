
## Healthcare Appointment No-Show Analysis ##
07 - Neighborhood Analysis

 Which neighborhoods have the highest observed no-show rate?
 Only neighborhoods with at least 100 appointments are included
 to focus on neighborhoods with a meaningful number of observations.

Select
    neighbourhood,

    Count(*) as total_appointments,

    Sun(
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

Group by
    neighbourhood

Having
    Count(*) >= 100

Order by
    no_show_rate DESC