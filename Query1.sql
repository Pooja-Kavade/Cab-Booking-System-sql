use cab_booking_system;

# Identify customers who have completed the most bookings. What insights can you draw about their behavior? 
SELECT 
    c.customer_id,
    c.name,
    c.Email,
    COUNT(b.booking_id) AS total_completed_bookings
FROM customers c
JOIN bookings b ON c.customer_id = b.customer_id
WHERE b.status = 'completed'          -- or 'finished', 'confirmed', etc. depending on your schema
GROUP BY c.customer_id, c.name, c.Email
ORDER BY total_completed_bookings DESC
LIMIT 1;

-------------------------------------------------------------------------
#Determine the busiest day of the week for bookings. How can the company optimize cab availability on peak days?
SELECT 
   DAYNAME(booking_date) AS Dayname,
    COUNT(booking_id) AS TotalBookings
FROM bookings
GROUP BY DAYNAME(booking_date)
ORDER BY TotalBookings DESC;

-----------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------
#Find the top 3 drivers who have completed the longest trips in terms of distance. What does this say about their working patterns?
select d.driver_id,d.driver_name,sum(t.DistanceKM) as Total_Distance
from drivers d
inner join trip_details t
on d.driver_id = t.driver_id
group by d.driver_id,d.driver_name
order by Total_Distance desc
limit 3;

--------------------------------------------------------------------------------
#Identify drivers with a high percentage of canceled trips. Could this indicate driver unreliability?
select d.driver_id,d.driver_name,Count(b.booking_id) as Total_Bookings,

sum(case 
when b.status= 'cancelled'
then 1
else 0
end) as Cancelled_Bookings,

sum(case 
when b.status= 'cancelled'
then 1
else 0
end)*100.0/Count(b.booking_id) as Cancellation_percentage

from drivers d
join bookings b
on d.driver_id=b.driver_id

group by d.driver_id,d.driver_name
order by Cancellation_percentage desc;
-----------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------
#Identify the top 3 most frequently traveled routes based on PickupLocation and DropoffLocation. Should the company allocate more cabs to these routes?
select pickup_location,drop_location,count(*) As Route_Count
from bookings
group by pickup_location,drop_location
order by Route_Count desc
limit 3;

----------------------------------------------------------------------------
#Determine if higher-rated drivers tend to complete more trips and earn higher fares. Is there a direct correlation between driver ratings and earnings?
select 
case
when d.rating>=4.5 then 'High Rated'
else 'low rated'
end as Driver_Category,

count(t.trip_id) AS Total_trips,
Round(sum(t.fare),2) AS Total_earnings

from drivers d
inner join trip_details t
on d.driver_id= t.driver_id


Group by
case
when d.rating>=4.5 then 'High Rated'
else 'low rated'
end;
----------------------------------------------------------------------------------------------------------------------------------------------------------

#Find out whether shorter trips (low distance) contribute significantly to revenue. Should the company encourage more short-distance rides?
SELECT 
    customer_id,
    MAX(booking_date) AS last_booking_date,
    COUNT(*) AS total_rides,
    DATEDIFF(CURRENT_DATE(), MAX(booking_date)) AS days_since_last_booking,
    
    CASE 
        WHEN DATEDIFF(CURRENT_DATE(), MAX(booking_date)) > 45 THEN 'Likely to Churn'
        WHEN DATEDIFF(CURRENT_DATE(), MAX(booking_date)) BETWEEN 30 AND 45 THEN 'At Risk'
        ELSE 'Active'
    END AS churn_prediction

FROM bookings
GROUP BY customer_id
HAVING days_since_last_booking > 25   -- Only show customers who haven't booked recently
ORDER BY days_since_last_booking DESC;

-----------------------------------------------------------------------------------------------------------------------------
#Compare the revenue generated from “Sedan” and “SUV” cabs. Should the company invest more in a particular vehicle type?
select
    c.cab_type,
    sum(t.fare) as Total_Revenue

from cabs c
inner join  trip_details t
on c.cab_id = t.cab_id
where c.cab_type IN ('Sedan','SUV')
group by c.cab_type;



---------------------------------------------------------------------------------------
#Analyze whether weekend bookings differ significantly from weekday bookings. Should the company introduce dynamic pricing based on demand?
select
    case
        when DAYNAME(booking_date) IN ('Saturday', 'Sunday') 
	    then 'weekend'
        else 'Weekday'
	    end as DayType,
count(booking_id) as Total_Bookings

from bookings
group by DayType;

----------------------------------------------------------------------------------------------------------------

#Customers who never cancelled a booking
SELECT Name
FROM Customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM Bookings
    WHERE Status = 'Cancelled'
);


------------------------------------------------------------------------------------------------------------------------------

#Identify the Driver who earned the highest total fare
SELECT driver_name
FROM Drivers
WHERE driver_id = (
    SELECT b.driver_id
    FROM Bookings b
    JOIN trip_details t ON b.booking_id = t.booking_id
    WHERE b.status = 'Completed'
    GROUP BY b.driver_id
    ORDER BY SUM(t.Fare) DESC
    LIMIT 1
);


-------------------------------------------------

#Customers who made more bookings than customer_id = 1
SELECT Name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Bookings
    GROUP BY customer_id
    HAVING COUNT(*) > (
        SELECT COUNT(*)
        FROM Bookings
        WHERE customer_id = 1
    )
);


-----------------------------------------------------------------------------------------------------------------

# Write a query to identify customers who cancelled a trip and the reason if cancelled trip.
SELECT 
    c.customer_id,
    c.Name,
    b.booking_id,
    b.cancelled_reason
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
WHERE b.status = 'Cancelled';

