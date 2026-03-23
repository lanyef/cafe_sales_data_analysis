--creating table for cafe_sales table in the dvdrental database
CREATE TABLE cafe(
	id SERIAL PRIMARY KEY,
	transaction_ID TEXT,
	item TEXT,
	quantity TEXT,
	price_per_unit TEXT,
	total_spent TEXT,
	payment_method TEXT,
	location TEXT,
	transaction_date TEXT	
);
select * from cafe_sales;

--populating the table with data from the .csv file
COPY cafe (transaction_id, item, quantity,price_per_unit, total_spent,payment_method, location, transaction_date)
	FROM 'C:\Program Files\PostgreSQL\dirty_cafe_sales.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM cafe_copy;
--creating a copy of the table
CREATE TABLE cafe_sales AS


--cleaning the dataset.
--standadizing the data since there were no duplicate values.
--Changing the data types of the fields

--changing all unknown and error inputs to null
ALTER TABLE cafe_sales
ALTER COLUMN quantity TYPE INT  
USING (
  CASE 
    WHEN quantity IN ('UNKNOWN', 'ERROR', '') THEN NULL 
    ELSE quantity::INT 
  END
);

--changing all unknown, error and '' inputs to null and changing the datatype of to money
ALTER TABLE cafe_sales
ALTER COLUMN price_per_unit TYPE MONEY
USING (
	CASE 
		WHEN price_per-unit IN ('UNKNOWN', 'ERROR', '') THEN NULL
		ELSE price-per_unit:: MONEY
	END
);

--changing all unknown, error and '' inputs to null and changing the datatype of to money in the total_spent column
ALTER TABLE cafe_sales
ALTER COLUMN total_spent TYPE MONEY
USING (
	CASE 
		WHEN total_spent IN ('UNKNOWN', 'ERROR', '') THEN NULL
		ELSE total_spent:: MONEY
	END
);

--deleting leading and trailing white spaces and also changing all error and unknown values to null in the payment_method table
ALTER TABLE payment_method
ALTER COLUMN payment_method TYPE TEXT
USING NULLIF(TRIM(NULLIF(payment_method, 'UNKNOWN')),'ERROR');


ALTER TABLE cafe_sales
ALTER COLUMN location TYPE TEXT
USING(
	CASE
		WHEN location ='ERROR' THEN NULL
		WHEN location = 'UNKNOWN' THEN 'Unknown'
		ELSE location
	END
);
ALTER TABLE cafe_sales
ALTER COLUMN payment_method TYPE TEXT
USING(
	CASE
		WHEN payment_method ='ERROR' THEN NULL
		WHEN payment_method = 'UNKNOWN' THEN 'Unknown'
		ELSE payment_method
	END
);

ALTER TABLE cafe_sales
ALTER COLUMN item TYPE TEXT
USING(
	CASE
		WHEN item ='ERROR' THEN NULL
		WHEN item = 'UNKNOWN' THEN 'Unknown'
		ELSE item
	END
);


--deleting rows where price_per_uit and total_spent are null
DELETE FROM cafe_sales
WHERE price_per_unit IS NULL AND total_spent IS NULL;

--deleting rows where quantity and total_spent are null
DELETE FROM cafe_sales
WHERE quantity IS NULL AND total_spent IS NULL;

--deleting rows where price_per_uit and quantity are null
DELETE FROM cafe_sales
WHERE price_per_unit IS NULL AND quantity IS NULL;


--calculated value for quantity using total-spent and price_per_unit
UPDATE cafe_sales
SET quantity = total_spent / price_per_unit
WHERE quantity IS NULL;

--calculated value for price-per_unit using total-spent and quantity
UPDATE cafe_sales
SET price-per_unit = total_spent / quantity
WHERE price-per_unit IS NULL;

--calculated value for total-spent using price-per_unit and quantity
UPDATE cafe_sales
SET total_spent = price-per_unit * quantity
WHERE total_spent IS NULL;

--replacing all unknown and null values in the item since they actually contribute to total sales
UPDATE cafe_sales
SET item = 'Uncategorized Sale'
WHERE item IS NULL OR item = 'Unknown';


SELECT * FROM cafe_sales WHERE item IS NULL;
SELECT * FROM cafe ;
