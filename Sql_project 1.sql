--  PROJECT 1 --
-- 1. Management wants to find guests who have made multiple bookings. What information would you need to identify them?
--  Here in this query we need to check both guest and bookings table, these tables ate connected with column guest_id we can group bookings with guest_id so,we can find them.
-- 2. The Operations team wants to identify stays that were checked in but later marked as no-show or cancelled. Where would you find the information needed to investigate this?
--  Here in this we query the queey the stays table in stays table check check_in and stay_status ,and aslo use bookings table with it so it will show actual booking data of that room
-- 3. The Guest Experience team wants to compare Individual and Corporate guests based on their booking activity. Which tables and columns would you need?
-- Here in this we query both guest and bookings table which are connected with guest_id we need columns guest_id,guest_type,booking_id,nights_booked,total_amount, and room_type_requested.
-- 4. The Operations team wants to compare different booking channels based on how many nights guests stay and how much they spend. Which tables would you need to connect?
-- Here we use bookings and stays table with booking_id connected to both and we check booking_id,nights_booked,booking_channel,total_amount,stay_duration.
-- 5.The team wants to identify which staff members have handled stays and examine their recorded ratings. What information would you need?
-- Here we use stays and staff table both are connected with staff_id, we use staff_id,servie_requests and rating to know the staff ratings also we can use department to know which dept that saff belongs to.
-- 6. Operations wants to understand whether different room types are being booked for different stay durations. Which tables and columns would you need?
-- Here we use rooms and stays table connected with room_id we use columns room_id,room_type,stay_duration.
-- 7. Management wants to compare booking performance across different hotels. What information would you need from the database?
-- Here we use bookings and hotels table connected with hotel_id we use columns booking_id,hotel_name,star_rating,nights_booked,room_type_requested.
-- 8. The Operations team wants to investigate whether larger room capacities are associated with higher service requests during a stay. Which information would you need, and where would you find it?
-- Here we use rooms adn stays table connected with room_id we use columns room_id,max_occupancy,count(service_requests) group by stay duration.
-- 9.. Management wants to understand whether stay outcomes differ across booking channels. What tables and information would you bring together?
-- Here we use bookings and stays table coonect with booking_id we use columns booking_id,stay_duration,status group by booking_channel.
-- 10.The Operations team wants to understand which guests have made bookings and how their stays are being handled. What information would you need to connect a guest with their bookings and stays?
-- Here we use three tables bookings and guest with connected guest_id and bookings and stays with booking_id we use columns booking_id,guest_id,guest_type,stay_duration,serive_requests.
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------  -------------------------------------------
CREATE DATABASE hotel_analytics;
USE hotel_analytics;

-- SPRINT 2 ------
-- Parent tables--
-- 1.hotels
CREATE TABLE hotels (
    hotel_id VARCHAR(20) PRIMARY KEY,
    hotel_name VARCHAR(100),
    city VARCHAR(50),
    star_rating INT,
    total_rooms INT,
    opened_date VARCHAR(50)  
);
-- 2.guests
CREATE TABLE guests (
    guest_id VARCHAR(20) PRIMARY KEY,
    guest_name VARCHAR(100),
    city VARCHAR(50),
    guest_type VARCHAR(20),
    preferred_room_type VARCHAR(20),
    loyalty_tier VARCHAR(20),
    account_since VARCHAR(50) 
);
-- 3.
CREATE TABLE staff (
    staff_id VARCHAR(20) PRIMARY KEY,
    staff_name VARCHAR(100),
    hire_date VARCHAR(50),    
    rating DECIMAL(3,2),
    department VARCHAR(30),
    is_active VARCHAR(3)
);

-- Child tables
-- 4.
CREATE TABLE rooms (
    room_id VARCHAR(20) PRIMARY KEY,
    hotel_id VARCHAR(20),
    room_type VARCHAR(20),
    floor_number INT,
    max_occupancy INT,
    price_per_night DECIMAL(10,2),
    is_active VARCHAR(3),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);
-- 5.
CREATE TABLE bookings (
    booking_id VARCHAR(20) PRIMARY KEY,
    guest_id VARCHAR(20),
    hotel_id VARCHAR(20),
    booking_date VARCHAR(50), 
    room_type_requested VARCHAR(20),
    booking_channel VARCHAR(30),
    nights_booked INT,
    total_amount DECIMAL(12,2),
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);
-- 6.
CREATE TABLE stays (
    stay_id VARCHAR(20) PRIMARY KEY,
    booking_id VARCHAR(20),
    room_id VARCHAR(20),
    staff_id VARCHAR(20),
    check_in_date VARCHAR(50),  
    check_out_date VARCHAR(50), 
    status VARCHAR(20),
    nights_stayed INT,
    service_requests INT,
    stay_duration_hrs INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
select * from hotels;
select * from guests;
select * from staff;
select * from bookings;
select * from rooms;
select * from stays;
-- SPRINT 3--
-- 1.
select count(guest_id) as total_guests from guests;
-- 2.
select count(booking_id) as total_bookings from bookings;
-- 3.
select count(stay_id) as total_stays from stays;
-- 4.
select room_type as diff_rooms from rooms group by room_type;
-- 5.
select count(staff_id) from staff where is_active = 'Yes';
-- 6.
select booking_channel as type_booking_channel from bookings group by booking_channel;
-- 7.
select sum(total_amount) as bookings_total_amount from bookings;
-- 8.
select avg(nights_booked) as avg_nights_booked from bookings;
-- SPRINT 4--
-- 4.1---
-- 1. Which hotel has the highest bookings and generates the highest income?
select h.hotel_id,
       h.hotel_name,
	   sum(b.total_amount) as total_revenue,
	   count(b.booking_id) as total_bookings 
       from bookings b 
       join hotels h 
       on b.hotel_id=h.hotel_id 
       group by hotel_id 
       order by total_revenue desc,total_bookings desc;
-- 2. Through which booking channels high bookings and high income is being generated
select b.booking_channel,sum(b.total_amount) as total_revenue,count(b.booking_id) as total_bookings from bookings b group by booking_channel
order by total_revenue desc,total_bookings desc;
-- 3. which room type are frequently being booked  and generating high income?
SELECT 
    room_type_requested,
    COUNT(booking_id) AS total_bookings,
    SUM(total_amount) AS total_revenue
FROM bookings
GROUP BY room_type_requested
ORDER BY total_bookings DESC;
-- 4. what type of  guests are generating high  bookings?
select guest_type,
       sum(b.total_amount) as total_revenue ,
       count(b.booking_id) as total_bookings
       from bookings b
       join guests g
       on b.guest_id=g.guest_id 
       group by guest_type 
       order by total_revenue desc,total_bookings desc;
-- 5. What is the distribution of booking amounts (average, minimum, and maximum spend)?
SELECT 
    COUNT(booking_id) AS total_bookings,
    ROUND(AVG(total_amount), 2) AS average_booking_amount,
    MIN(total_amount) AS minimum_booking_amount,
    MAX(total_amount) AS maximum_booking_amount,
    SUM(total_amount) AS overall_total_revenue
FROM bookings;
-- SPRINT 4.2--
-- Understanding Guest Booking Behaviour
-- 1.Which guest types making high number of bookings
select  g.guest_type,
count(b.booking_id) as total_bookings
 from bookings b
 join guests g 
 on b.guest_id=g.guest_id
 group by g.guest_type
 order by total_bookings desc;
 -- 2.Who are the top 5 highest-spending guests based on their cumulative total spend?
 select g.guest_id,
        g.guest_name,
        g.guest_type,
        sum(b.total_amount) as total_amount_spent
        from guests g
        join bookings b
        on b.guest_id=g.guest_id
        group by g.guest_id,g.guest_name,g.guest_type
        order by total_amount_spent desc
        limit 5;
-- 3.Which hotels attract the highest number of unique guests?
SELECT 
    h.hotel_id,
    h.hotel_name,
    COUNT(DISTINCT b.guest_id) AS unique_guests_count
FROM bookings b
JOIN hotels h 
    ON b.hotel_id = h.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY unique_guests_count DESC;
-- 4.What is the average booking value and average stay duration for Corporate versus Individual guests?
SELECT 
    g.guest_type,
    ROUND(AVG(b.total_amount), 2) AS avg_booking_amount,
    ROUND(AVG(b.nights_booked), 1) AS avg_nights_booked
FROM bookings b
JOIN guests g 
    ON b.guest_id = g.guest_id
GROUP BY g.guest_type;
-- 5.How many bookings are made each month based on booking dates?
 SELECT 
    SUBSTRING(booking_date, 1, 7) AS booking_month,
    COUNT(booking_id) AS total_bookings,
    SUM(total_amount) AS monthly_revenue
FROM bookings
GROUP BY booking_month
ORDER BY booking_month;
-- SPRINT 4.3--
-- Evaluate Stay Performance
-- 1.What is the distribution of stay statuses across different hotels?
SELECT 
    h.hotel_name,
    s.status,
    COUNT(s.stay_id) AS total_stays
FROM stays s
JOIN bookings b 
    ON s.booking_id = b.booking_id
JOIN hotels h 
    ON b.hotel_id = h.hotel_id
GROUP BY h.hotel_name, s.status
ORDER BY h.hotel_name, total_stays DESC;
-- 2.What is the average stay duration and actual nights stayed across each hotel?
SELECT 
    h.hotel_name,
    ROUND(AVG(s.nights_stayed), 1) AS avg_nights_stayed,
    ROUND(AVG(s.stay_duration_hrs), 1) AS avg_duration_hrs
FROM stays s
JOIN bookings b 
    ON s.booking_id = b.booking_id
JOIN hotels h 
    ON b.hotel_id = h.hotel_id
GROUP BY h.hotel_name
ORDER BY avg_nights_stayed DESC;
-- 3.Which hotels have the highest percentage of problematic stay outcomes (Cancellations and No-Shows)?
SELECT 
    h.hotel_name,
    SUM(CASE WHEN s.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) AS problematic_stays,
    COUNT(s.stay_id) AS total_stays,
    ROUND(SUM(CASE WHEN s.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) * 100.0 / COUNT(s.stay_id), 2) AS issue_percentage
FROM stays s
JOIN bookings b 
    ON s.booking_id = b.booking_id
JOIN hotels h 
    ON b.hotel_id = h.hotel_id
GROUP BY h.hotel_name
ORDER BY issue_percentage DESC;
-- 4.How do service requests vary across different stay outcomes?
SELECT 
    s.status,
    COUNT(s.stay_id) AS total_stays,
    ROUND(AVG(s.service_requests), 2) AS avg_service_requests
FROM stays s
GROUP BY s.status
ORDER BY avg_service_requests DESC;
-- 5.How have stay performance outcomes changed month over month?
SELECT 
    SUBSTRING(s.check_in_date, 1, 7) AS check_in_month,
    s.status,
    COUNT(s.stay_id) AS status_count
FROM stays s
GROUP BY check_in_month, s.status
ORDER BY check_in_month, s.status;
-- SPRINT 4.4--
-- Understand Staff and Room Performance
-- 1.How many total stays and what average staff rating do staff members handle?
SELECT 
    st.staff_id,
    st.staff_name,
    st.department,
    st.rating AS staff_rating,
    COUNT(s.stay_id) AS total_stays_handled
FROM staff st
LEFT JOIN stays s 
    ON st.staff_id = s.staff_id
GROUP BY st.staff_id, st.staff_name, st.department, st.rating
ORDER BY total_stays_handled DESC;
-- 2.What is the average stay duration handled by each staff member?
SELECT 
    st.staff_id,
    st.staff_name,
    COUNT(s.stay_id) AS total_stays,
    ROUND(AVG(s.nights_stayed), 1) AS avg_nights_handled,
    ROUND(AVG(s.stay_duration_hrs), 1) AS avg_duration_hrs_handled
FROM staff st
JOIN stays s 
    ON st.staff_id = s.staff_id
GROUP BY st.staff_id, st.staff_name
ORDER BY avg_nights_handled DESC;
-- 3.How do stay outcomes (Checked-out vs. Cancelled/No-show) distribute across staff members?
SELECT 
    st.staff_name,
    s.status,
    COUNT(s.stay_id) AS status_count
FROM staff st
JOIN stays s 
    ON st.staff_id = s.staff_id
GROUP BY st.staff_name, s.status
ORDER BY st.staff_name, status_count DESC; 
-- 4.Which room types experience the highest utilization and total stay volume?
SELECT 
    r.room_type,
    COUNT(s.stay_id) AS total_stays_completed,
    ROUND(AVG(r.price_per_night), 2) AS avg_price_per_night
FROM rooms r
JOIN stays s 
    ON r.room_id = s.room_id
GROUP BY r.room_type
ORDER BY total_stays_completed DESC;
-- 5.Which specific rooms experience the highest number of service requests during stays?
SELECT 
    r.room_id,
    r.room_type,
    h.hotel_name,
    COUNT(s.stay_id) AS total_stays,
    SUM(s.service_requests) AS total_service_requests
FROM
    rooms r
        JOIN
    hotels h ON r.hotel_id = h.hotel_id
        JOIN
    stays s ON r.room_id = s.room_id
GROUP BY r.room_id , r.room_type , h.hotel_name
ORDER BY total_service_requests DESC
LIMIT 10;
-- SPRINT 4.5--
-- Identify Booking and Stay Problems
-- 1.Which booking channels account for the highest volume of cancellations or no-shows?
SELECT 
    b.booking_channel,
    COUNT(b.booking_id) AS total_bookings,
    SUM(CASE WHEN s.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) AS problem_stays,
    ROUND(SUM(CASE WHEN s.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) * 100.0 / COUNT(b.booking_id), 2) AS problem_rate_percentage
FROM bookings b
JOIN stays s 
    ON b.booking_id = s.booking_id
GROUP BY b.booking_channel
ORDER BY problem_rate_percentage DESC;
-- 2.Is there a correlation between high service request counts and problematic stay outcomes?
SELECT 
    s.status,
    COUNT(s.stay_id) AS total_stays,
    ROUND(AVG(s.service_requests), 2) AS avg_service_requests,
    MAX(s.service_requests) AS max_service_requests
FROM stays s
GROUP BY s.status
ORDER BY avg_service_requests DESC;
-- 3.Which hotels experience the highest frequency of booking and stay anomalies?
SELECT 
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(CASE WHEN s.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) AS unfulfilled_bookings,
    ROUND(SUM(CASE WHEN s.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) * 100.0 / COUNT(b.booking_id), 2) AS failure_rate_percentage
FROM bookings b
JOIN hotels h 
    ON b.hotel_id = h.hotel_id
LEFT JOIN stays s 
    ON b.booking_id = s.booking_id
GROUP BY h.hotel_name
ORDER BY failure_rate_percentage DESC;
-- 4.What are the financial impacts of cancelled and no-show bookings?
SELECT 
    s.status,
    COUNT(b.booking_id) AS total_affected_bookings,
    SUM(b.total_amount) AS total_value_at_risk
FROM bookings b
JOIN stays s 
    ON b.booking_id = s.booking_id
WHERE s.status IN ('Cancelled', 'No-show')
GROUP BY s.status
ORDER BY total_value_at_risk DESC;
-- 5.Do longer-booked stays suffer from a higher rate of cancellation or failure?
SELECT 
    CASE 
        WHEN b.nights_booked <= 2 THEN 'Short Stay (1-2 nights)'
        WHEN b.nights_booked BETWEEN 3 AND 5 THEN 'Medium Stay (3-5 nights)'
        ELSE 'Long Stay (6+ nights)'
    END AS stay_length_category,
    s.status,
    COUNT(b.booking_id) AS booking_count
FROM bookings b
JOIN stays s 
    ON b.booking_id = s.booking_id
GROUP BY stay_length_category, s.status
ORDER BY booking_count DESC;
