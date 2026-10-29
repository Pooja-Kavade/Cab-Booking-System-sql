# Cab Booking System - SQL Analysis Project

A complete **Cab Booking System** database project with real-world data and advanced SQL queries for business insights.

---

## 📁 Project Structure

| File                    | Description                                      |
|-------------------------|--------------------------------------------------|
| `Customers.csv`         | Customer details (Name, Phone, Email, Address)   |
| `Drivers.csv`           | Driver details with ratings                      |
| `Cabs.csv`              | Cab information (Number, Model, Type)            |
| `Bookings.csv`          | All booking records with status                  |
| `Trip_Details.csv`      | Trip distance, fare, start & end time            |
| `feedback.csv`          | Customer feedback and ratings                    |
| `Query1.sql` – `Query5.sql` | Business analysis queries                   |
| `Self_Query6.sql`       | Additional self-written queries                  |

---

## 🗃 Database Tables Overview

### 1. Customers
- `customer_id`, `Name`, `Phone`, `Email`, `address`

### 2. Drivers
- `driver_id`, `driver_name`, `Phone`, `rating`

### 3. Cabs
- `cab_id`, `Cab Number`, `Cab Model`, `Cab Type`, `Driver ID`

### 4. Bookings
- `customer_id`, `booking_id`, `cab_id`, `pickup_location`, `pickup_date`
- `driver_id`, `drop_location`, `status`, `booking_date`
- `cancelled_by`, `cancelled_reason`

### 5. Trip_Details
- `trip_id`, `cab_id`, `driver_id`, `BookingID`
- `TripStartTime`, `TripEndTime`, `DistanceKM`, `Fare`

### 6. Feedback
- `feedback_id`, `booking_id`, `customer_id`, `driver_id`
- `rating`, `feedback_date`, `comment`

---

## 🔍 SQL Queries Included

### Query 1
- Identify customers with the **most completed bookings**
- Find the **busiest day of the week** for bookings

### Query 2
- Drivers with average rating **below 3.0** (last 3 months)
- Top 3 drivers with **longest total distance**
- Drivers with **high cancellation percentage**

### Query 3
- Total revenue from completed bookings (last 6 months)
- Top 3 most frequently traveled **routes**
- Correlation between **driver ratings** and earnings

### Query 4
- Customer **churn prediction** based on last booking date

### Query 5
- Revenue comparison between **Sedan vs SUV**
- Weekend vs Weekday booking analysis

### Self Query 6
- Customers who never cancelled a booking
- Driver who earned the highest total fare
- Customers with more bookings than a specific customer
- Customers who cancelled trips with reasons

---

## 📊 Key Insights You Can Derive

- Customer booking behavior & loyalty
- Driver performance & reliability
- Peak booking days
- High-demand routes
- Revenue contribution by cab type
- Churn risk customers
- Impact of driver ratings on earnings

---

## 🛠 How to Use

1. Create a database named `cab_booking_system`
2. Import all the CSV files into corresponding tables
3. Run the SQL queries one by one
4. Analyze the results for business decisions

---

## 🧰 Tools Used

- MySQL / SQL
- CSV data files
- Business Intelligence style analysis

---

## 📌 Notes

- Status values used: `completed`, `cancelled`, `Booked`, `Ongoing`
- Cab Types: Mini, Sedan, SUV
- Feedback ratings range from 3.5 to 5.0

---

**Project Purpose:** Learning advanced SQL joins, aggregations, subqueries, and business analytics using a real-world cab booking scenario.
