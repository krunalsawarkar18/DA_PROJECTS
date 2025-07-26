CREATE TABLE Booking (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(50) PRIMARY KEY,
    Booking_Status VARCHAR(30),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(30),
    Pickup_Location TEXT,
    Drop_Location TEXT,
    V_TAT INTEGER,  -- Vehicle Turnaround Time
    C_TAT INTEGER,  -- Customer Turnaround Time
    Canceled_Rides_by_Customer VARCHAR,
    Canceled_Rides_by_Driver VARCHAR,
    Incomplete_Rides VARCHAR,
    Incomplete_Rides_Reason VARCHAR,
    Booking_Value NUMERIC(10,2),
    Payment_Method VARCHAR(30),
    Ride_Distance NUMERIC(6,2),
    Driver_Ratings NUMERIC(2,1),
    Customer_Rating NUMERIC(2,1),
    Vehicle_Images TEXT  -- Assuming this is a URL or file path
);



COPY Booking FROM 'D:\Excel_sql_powerBi_Project\Bookings-100000-Rows.csv'
DELIMITER ',' 
CSV HEADER 
NULL 'null';


SELECT * FROM Booking;

#1.Retrive all successful booking:

SELECT * FROM Booking;

create view Successful_Booking As
select * from booking
where booking_status = 'Success'

select * from Successful_Booking;

#2.Find the average ride distance for each vehicle type:

SELECT * FROM Booking;

create view ride_distance_for_each_vehicle As
select Vehicle_Type , avg(Ride_Distance) as avg_distance from booking
group by Vehicle_Type;

select * from ride_distance_for_each_vehicle;

#3.Get the total number of canceled rides by customer:


SELECT * FROM Booking;

create view canceled_rides_by_customer As
select count(*) from booking
where Booking_Status = 'Canceled by Customer';

select * from canceled_rides_by_customer;

#4.List the top 5 customers who booked the highest number of rides:

SELECT * FROM Booking;

create view top_5_customers as
select Customer_ID, count(Booking_id) as total_rides
from Booking
group by customer_id
order by total_rides Desc Limit 5;

select * from top_5_customers;

#5.Get the number of rides canceled by drivers due to persoal and car-related issues:

SELECT * FROM Booking;

create view Rides_Canceled_by_Drivers_P_C_Issues As
select count(*) from booking
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

select * from Rides_Canceled_by_Drivers_P_C_Issues;

#6.Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT * FROM Booking;

create view Max_Min_Driver_Rating as
select max (Driver_Ratings) as max_rating,
min(Driver_Ratings) as min_rating
from booking where Vehicle_Type = 'Prime Sedan';

select * from Max_Min_Driver_Rating;


#7.Retrieve all rides where payment was made using UPI:

SELECT * FROM Booking;

create view UPI_Payment AS
select * from Booking
where Payment_Method = 'UPI';

select * from UPI_Payment;

#8.Find the average customer rating per vehicle type:

SELECT * FROM Booking;

create view avg_cust_rating as
select Vehicle_Type, avg(Customer_Rating) as avg_customer_rating
from booking
group by Vehicle_Type;

select * from avg_cust_rating;

#9.Calculate the total booking value of rides completed Successfully:

SELECT * FROM Booking;

create view total_successful_ride_value as
select sum(Booking_Value) as total_successful_ride_value
from booking
where Booking_Status = 'Success';

select * from total_successful_ride_value;

#10.List all incomplet rides along with the reason:

SELECT * FROM Booking;

create view Incomplet_Rides_Reason as
select Booking_ID, Incomplete_Rides_Reason
from Booking
where Incomplete_Rides = 'Yes';

select * from Incomplet_Rides_Reason;