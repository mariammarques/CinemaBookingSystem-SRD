-- STORING & RETRIEVING DATA - GROUP 20 (imCINEMA BOOKING SYSTEM)
-- ---------------------- QUERIES -------------------------------

USE  `S&RD__PROJECT`;

/* 1. List all the customer’s names, dates, and products or services booked by these customers in a range of two dates. */
-- EXPLAIN
(SELECT A.Booking_ID, A.Customer_Name, A.Purchase_date, A.Tickets_Bought, GROUP_CONCAT(B.Snacks_Bought) AS Snacks_Bought
FROM (SELECT CONCAT(c.Cust_FirstName, " ",c.Cust_LastName) AS Customer_Name, p.Payment_Date AS Purchase_Date, 
      CONCAT(b.Booking_NrTickets, " ", tt.TT_Name, " tickets") AS Tickets_Bought, b.Booking_ID AS Booking_ID
	  FROM Payment AS p, Customer AS c, Booking AS b, Ticket_Type AS tt
	  WHERE p.Payment_ID = b.Payment_ID AND b.Cust_ID = c.Cust_ID AND b.TT_ID = tt.TT_ID) AS A
LEFT JOIN (SELECT CONCAT(sb.SnackBooking_Quantity, " ", s.Snack_Name) AS Snacks_Bought, CONCAT(c.Cust_FirstName, " ",c.Cust_LastName) AS Customer_Name, b.Booking_ID AS Booking_ID
		   FROM Snack AS s, Snack_Booking AS sb, Booking AS b, Customer AS c
           WHERE b.Booking_ID = sb.Booking_ID AND sb.Snack_ID = s.Snack_ID AND b.Cust_ID = c.Cust_ID) AS B
ON A.Booking_ID = B.Booking_ID
WHERE A.Purchase_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY A.Booking_ID
ORDER BY Purchase_Date DESC
);

/*
COMMENT:
Query 1's first part is efficient due to the type of access being 'eq_ref' or 'ref' in almost all SELECT parts, meaning that it will return at most a single value, as the 'rows' column shows.
Optimization can be done by having less 'possible_keys' on the 2nd SELECT part, and avoid using temporary tables. This query is fast since only one SELECT part accesses more than one record.
*/

/* 2. List the best three customers: */
-- EXPLAIN
SELECT CONCAT(c.CUST_FIRSTNAME, " ", c.CUST_LASTNAME) AS Customer_Name, 
SUM(p.PAYMENT_VALUE) AS Total_Spent_€
FROM CUSTOMER AS c, BOOKING AS b, PAYMENT AS p
WHERE p.PAYMENT_ID = b.PAYMENT_ID AND b.CUST_ID = c.CUST_ID
GROUP BY b.CUST_ID
ORDER BY Total_Spent_€ DESC
LIMIT 3;

/*
COMMENT: 
Query 2's first part is inefficient since it uses a temporary table, and it is sorted by a column that is not the index. Optimization can be done by having less 'possible_keys'.
However, the remaining two parts are efficient due to the type of access being 'eq_ref', meaning that it will return at most a single value, as the 'rows' column shows.
*/

/* 3. Get the average amount of sales for a period that involves 2 or more years. This query only returns one record. */
/* PeriodOfSales | TotalSales (€) | YearlyAverage (of the given period) | MonthlyAverage (of the given period) */
-- EXPLAIN
SELECT CONCAT('2020-01-01' , " - ", '2022-01-01') AS PeriodOfSales, SUM(p.PAYMENT_VALUE) AS TotalSales_€,
ROUND(SUM(p.PAYMENT_VALUE) / (ABS(TIMESTAMPDIFF(year, '2020-01-01', '2022-01-01'))), 2) AS YearlyAverage_OfTheGivenPeriod_€,
ROUND(SUM(p.PAYMENT_VALUE) / (ABS(TIMESTAMPDIFF(month, '2020-01-01', '2022-01-01'))), 2)  AS MonthlyAverage_OfTheGivenPeriod_€
FROM PAYMENT AS p, BOOKING AS b
WHERE p.PAYMENT_ID = b.PAYMENT_ID AND p.PAYMENT_DATE BETWEEN '2020-01-01' AND '2022-01-01';

/*
COMMENT: 
Query 3 is efficient since it has a low number of keys evaluated (each SELECT part only has 1 possible_key). Also, this query is fast, because having 2 SELECT parts, it only
needs one row to find the wanted record. Finally, we can optimize it since the EXPLAIN output presents a NULL on the 'key' column.
*/

/* 4. Get the total sales/bookings by geographical location (city). */
-- EXPLAIN
SELECT c.CITY_NAME AS Geo_Location, SUM(bd1.PAYMENT_VALUE) AS Total_Sales
FROM (SELECT b.BOOKING_ID, p.PAYMENT_VALUE, bs1.EXHIBITION_ID
	  FROM BOOKING AS b
	  INNER JOIN PAYMENT AS p
	  ON b.PAYMENT_ID = p.PAYMENT_ID 
	  LEFT JOIN (SELECT DISTINCT BOOKING_ID, EXHIBITION_ID 
				 FROM BOOKING_SEAT) AS bs1
	  ON b.BOOKING_ID = bs1.BOOKING_ID) AS bd1 
	  LEFT JOIN (SELECT e.EXHIBITION_ID, cn.CINEMA_ID, cn.CITY_ID
				 FROM EXHIBITION AS e, CINEMA AS cn
				 WHERE cn.CINEMA_ID = e.CINEMA_ID) AS bd2
	  ON bd1.EXHIBITION_ID = bd2.EXHIBITION_ID
	  LEFT JOIN CITY AS c
	  ON bd2.CITY_ID= C.CITY_ID
GROUP BY Geo_Location;

/*
COMMENT: 
Query 4's first part is inefficient since it is performing an index scan. Optimization can be done by having less 'possible_keys' on the 3rd SELECT, and avoid using temporary tables.
However, the remaining parts are efficient due to the type of access being 'eq_ref' or 'ref', meaning that it will return at most a single value in one or more rows, as the 'rows' column shows.
*/

/* 5. List all the locations where products/services were sold, and the product has customer’s ratings.*/
-- EXPLAIN
SELECT c.CITY_NAME AS Location, cin.CINEMA_NAME as Cinema, ROUND(AVG(b.BOOKING_RATING), 1) AS Average_Rating
FROM BOOKING AS b, CITY AS c, CINEMA AS cin, SEAT AS s, BOOKING_SEAT as bs
WHERE c.CITY_ID = cin.CITY_ID AND cin.CINEMA_ID = s.CINEMA_ID AND s.SEAT_ID = bs.SEAT_ID
AND bs.BOOKING_ID = b.BOOKING_ID AND b.BOOKING_RATING IS NOT NULL  
GROUP BY Cinema
ORDER BY Average_Rating;

/*
COMMENT:
Query 5's first part is inefficient since it goes through all the table searching for NULL values, uses a temporary table and it is sorted by a column that is not the index.
However, the remaining four parts are efficient due to the type of access being 'eq_ref', meaning that it will return at most a single value, as the 'rows' column shows.
*/
