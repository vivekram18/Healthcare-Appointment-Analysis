
## Healthcare Appointment No-Show Analysis ##
 06 - SMS Reminder vs Lead Time Analysis
 

Select
    CASE
        When lead_days_time = 0 Then 'Same Day'
        When lead_days_time Between 1 And 7 Then '1-7 Days'
        When lead_days_time Between 8 And 14 Then '8-14 Days'
        When lead_days_time Between 15 And 30 Then '15-30 Days'
        Else '31+ Days'
    END as lead_time_group,

    sms_received,

    Count(*) as total_appointments,

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

Group by
   CASE
        When lead_days_time = 0 Then 'Same Day'
        When lead_days_time Between 1 And 7 Then '1-7 Days'
        When lead_days_time Between 8 And 14 Then '8-14 Days'
        When lead_days_time Between 15 And 30 Then '15-30 Days'
        Else '31+ Days'
    END,
    sms_received

Order by
    MIN(lead_days_time),
    sms_received