CREATE DATABASE `Travel_Directory`;

USE `Travel_Directory`;

/*1. Create two tables PASSENGER and PRICE */
CREATE TABLE PASSENGER (
    Passenger_name VARCHAR(50),
    Category VARCHAR(10),
    Gender VARCHAR(2),
    Boarding_City VARCHAR(50),
    Destination_City VARCHAR(50),
    Distance INT,
    Bus_Type VARCHAR(20)
);
 
CREATE TABLE PRICE (
    Bus_Type VARCHAR(20),
    Distance INT,
    Price INT
);
  
 /* 2. Insert the following data in the tables */
 INSERT into PASSENGER values
 ("Sejal",'AC','F',"Bengaluru","Chennai",350,"Sleeper"),
 ("Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting"),
 ("Pallavi","AC","F","Panaji","Bengaluru",600,"Sleeper"),
 ("Khusboo","AC","F","Chennai","Mumbai",1500,"Sleeper"),
 ("Udit","Non-AC","M","Trivandrum","Panaji",1000,"Sleeper"),
 ("Ankur","AC","M","Nagpur","Hyderabad",500,"Sitting"),
 ("Hemant","Non-AC","M","Panaji","Mumbai",700,"Sleeper"),
 ("Manish","Non-AC","M","Hyderabad","Bengaluru",500,"Sitting"),
 ("Piyush","AC","M","Pune","Nagpur",700,"Sitting");
  
  INSERT into PRICE values
 ("Sleeper",350,770),
 ("Sleeper",500,1100),
 ("Sleeper",600,1320),
 ("Sleeper",700,1540),
 ("Sleeper",1000,2200),
 ("Sleeper",1200,2640),
 ("Sleeper",350,434),
 ("Sitting",500,620),
 ("Sitting",500,620),
 ("Sitting",600,744),
 ("Sitting",700,868),
 ("Sitting",1000,1240),
 ("Sitting",1200,1488),
 ("Sitting",1500,1860);
 
 ----------------------------------------
/* 3. Females and male passengers travelled for minimum 600 kms */
SELECT 
    Gender, COUNT(Gender) as Count
FROM
    passenger
WHERE
    distance >= 600
GROUP BY gender;
 -------------------------------------------
 /*4. Minimum ticket price for sleeper bus */
SELECT 
    Bus_Type,MIN(Price) as 'Minimum Ticket Price'
FROM
    Price
GROUP BY Bus_type
HAVING Bus_Type = 'Sleeper';
----------------------------------------------
/* 5. Passenger names whose names starts with 'S' */
 
 SELECT 
    Passenger_name
FROM
    Passenger
WHERE
    Passenger_name LIKE 'S%';
-------------------------------------------------
 /* 6. Price charged for each passenger displaying
 passenger name, Boarding City, Destination City,
 Bus_Type, Price */
 
SELECT DISTINCTROW
    p.Passenger_name,
    p.Boarding_city,
    p.Destination_city,
    p.Bus_type,
    pr.Price
FROM
    Passenger p
        JOIN
    Price pr ON p.Bus_type = pr.Bus_type
WHERE
    p.Distance = pr.Distance;

-------------------------------------------------
/* 7. passenger name and his/her ticket price who
travelled in sitting bus for a distance of 1000 kms */

SELECT distinctrow
    p.Passenger_name, p.Bus_Type, p.Distance, pr.Price
FROM
    passenger p
        JOIN
    Price pr ON p.bus_type = pr.bus_type
        AND p.distance = pr.distance
WHERE
    p.bus_type = 'sitting'
        AND p.distance = 1000;
---------------------------------------------------------
/* 8. Sitting and sleeper coach bus charge for pallavi
from Bangalore to Panaji*/

SELECT 
    p.Passenger_name,
    p.Destination_city as "Boarding City",
    p.Boarding_city as "Destination City",
    p.Distance,
    pr.Bus_type,
    pr.Price
FROM
    Passenger p
         JOIN
    Price pr ON p.Distance = pr.Distance
WHERE
    p.Passenger_name = 'Pallavi';
-----------------------------------------------
/* 9. List the distances from the passenger table which 
are unique(non repeated distances) in descending order */
SELECT DISTINCT
    Distance as "Unique Distance"
FROM
    passenger
ORDER BY distance DESC;
----------------------------------------------------
/* 10. Display the passenger name and percentage of distance
 travelled by that passenger from the total distance travelled
 by all passengers without using user variables */
 
SELECT 
    Passenger_name,
    Distance / (SELECT 
            SUM(distance)
        FROM
            passenger) * 100 as "Percentage of distance travelled"
FROM
    passenger;
 --------------------------------------------------------   
/* 11. Display the distance, price in three categories 
in table price 
a. Expensive if the cost is more than 1000
b. Average Cost if the cost is less than 1000 
and greater than 500
c. Cheap otherwise */

SELECT distinctrow
    Distance,
    Price,
    CASE
        WHEN Price > 1000 THEN 'Expensive'
        WHEN Price > 500 AND Price < 1000 THEN 'Average Cost'
        ELSE 'Cheap'
    END AS Price_Category
FROM
    price;