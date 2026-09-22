
## Healthcare Appointment No-Show Analysis ##

 02 - Overall No-Show Rate

 Q1. What's our overall no-show rate?

Select
    Count(*) FILTER (WHERE no_show = 'Yes') as no_shows,
    Count(*) as total,
    ROUND(
        Count(*) FILTER (WHERE no_show = 'Yes') * 100.0
        / Count(*),
        2
    ) as no_show_rate
From medical_appointments