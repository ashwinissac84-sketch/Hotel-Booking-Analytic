
-- ============================================================
-- HOTEL BOOKING & CANCELLATION INTELLIGENCE
-- SQL Business Analysis
-- Database: hotel_booking_analytics
-- Table: hotel_bookings
-- Total Records: 87,396
-- ============================================================


-- Q1. Overall Booking and Cancellation Analysis

SELECT
    booking_status,
    COUNT(*) AS total_bookings,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM hotel_bookings
GROUP BY booking_status
ORDER BY total_bookings DESC;


-- Q2. Cancellation Rate by Hotel

SELECT
    hotel,
    COUNT(*) AS total_bookings,
    COUNT(*) FILTER (
        WHERE booking_status = 'Canceled'
    ) AS canceled_bookings,
    ROUND(
        COUNT(*) FILTER (
            WHERE booking_status = 'Canceled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM hotel_bookings
GROUP BY hotel
ORDER BY cancellation_rate DESC;


-- Q3. Monthly Booking Analysis

SELECT
    arrival_date_month,
    COUNT(*) AS total_bookings,
    ROUND(AVG(adr), 2) AS average_daily_rate
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY total_bookings DESC;


-- Q4. Cancellation Rate by Market Segment

SELECT
    market_segment,
    COUNT(*) AS total_bookings,
    COUNT(*) FILTER (
        WHERE booking_status = 'Canceled'
    ) AS canceled_bookings,
    ROUND(
        COUNT(*) FILTER (
            WHERE booking_status = 'Canceled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM hotel_bookings
GROUP BY market_segment
ORDER BY cancellation_rate DESC;


-- Q5. Booking Lead Time vs Cancellation

SELECT
    booking_status,
    COUNT(*) AS total_bookings,
    ROUND(AVG(lead_time), 2) AS average_lead_time,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY lead_time)::NUMERIC,
        2
    ) AS median_lead_time
FROM hotel_bookings
GROUP BY booking_status
ORDER BY average_lead_time DESC;


-- Q6. Cancellation Rate by Customer Type

SELECT
    customer_type,
    COUNT(*) AS total_bookings,
    COUNT(*) FILTER (
        WHERE booking_status = 'Canceled'
    ) AS canceled_bookings,
    ROUND(
        COUNT(*) FILTER (
            WHERE booking_status = 'Canceled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM hotel_bookings
GROUP BY customer_type
ORDER BY cancellation_rate DESC;


-- Q7. Repeat Guests vs First-Time Guests

SELECT
    CASE
        WHEN is_repeated_guest = 1
        THEN 'Repeat Guest'
        ELSE 'First-time Guest'
    END AS guest_type,

    COUNT(*) AS total_bookings,

    COUNT(*) FILTER (
        WHERE booking_status = 'Canceled'
    ) AS canceled_bookings,

    ROUND(
        COUNT(*) FILTER (
            WHERE booking_status = 'Canceled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate,

    ROUND(AVG(adr), 2) AS average_adr

FROM hotel_bookings
GROUP BY is_repeated_guest
ORDER BY cancellation_rate;


-- Q8. Top 10 Countries by Booking Volume

SELECT
    country,
    COUNT(*) AS total_bookings,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS booking_percentage
FROM hotel_bookings
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;


-- Q9. Estimated Revenue Analysis by Hotel

SELECT
    hotel,
    COUNT(*) AS total_bookings,
    ROUND(SUM(estimated_revenue), 2) AS total_revenue,
    ROUND(AVG(adr), 2) AS average_adr,
    ROUND(
        SUM(estimated_revenue) * 100.0 /
        SUM(SUM(estimated_revenue)) OVER (),
        2
    ) AS revenue_percentage
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_revenue DESC;


-- Q10. Average Length of Stay by Hotel

SELECT
    hotel,
    COUNT(*) AS total_bookings,
    ROUND(AVG(total_nights), 2) AS average_stay_nights,
    ROUND(AVG(stays_in_weekend_nights), 2)
        AS average_weekend_nights,
    ROUND(AVG(stays_in_week_nights), 2)
        AS average_weekday_nights
FROM hotel_bookings
GROUP BY hotel
ORDER BY average_stay_nights DESC;


-- Q11. Deposit Type vs Cancellation Rate

SELECT
    deposit_type,
    COUNT(*) AS total_bookings,

    COUNT(*) FILTER (
        WHERE booking_status = 'Canceled'
    ) AS canceled_bookings,

    ROUND(
        COUNT(*) FILTER (
            WHERE booking_status = 'Canceled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate

FROM hotel_bookings
GROUP BY deposit_type
ORDER BY cancellation_rate DESC;


-- Q12. Special Requests Analysis

SELECT
    total_of_special_requests,
    COUNT(*) AS total_bookings,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS booking_percentage,
    ROUND(AVG(adr), 2) AS average_adr
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY total_of_special_requests;


-- ============================================================
-- END OF SQL BUSINESS ANALYSIS
-- ============================================================
