CREATE DATABASE SOFT;
USE SOFT;

CREATE TABLE CUSTOMERS (
    CUSTOMER_ID INT PRIMARY KEY,
    CUSTOMER_NAME VARCHAR(100),
    CITY VARCHAR(100),
    COUNTRY VARCHAR(100)
);

CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    ORDER_DATE DATE,
    TOTAL_AMOUNT DECIMAL(10, 2),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID)
);

CREATE TABLE ORDER_ITEMS (
    ORDER_ITEM_ID INT PRIMARY KEY,
    ORDER_ID INT,
    PRODUCT_ID INT,
    QUANTITY INT,
    PRICE DECIMAL(10, 2),
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);

CREATE TABLE PRODUCTS (
    PRODUCT_ID INT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(100),
    CATEGORY VARCHAR(100)
);

INSERT INTO CUSTOMERS (CUSTOMER_ID, CUSTOMER_NAME, CITY, COUNTRY) VALUES
(1, 'ALICE', 'CITY1', 'USA'),
(2, 'BOB', 'CITY2', 'USA'),
(3, 'CHARLIE', 'CITY3', 'CANADA'),
(4, 'DAVID', 'CITY4', 'CANADA'),
(5, 'EVA', 'CITY5', 'UK'),
(6, 'FRANK', 'CITY6', 'UK');

INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, TOTAL_AMOUNT) VALUES
(1001, 1, '2023-01-15', 150.50),
(1002, 2, '2023-01-20', 200.75),
(1003, 1, '2023-02-10', 300.00),
(1004, 3, '2023-02-25', 450.25),
(1005, 4, '2023-03-10', 500.00),
(1006, 5, '2023-03-15', 250.00);

INSERT INTO ORDER_ITEMS (ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES
(1, 1001, 101, 2, 50.25),
(2, 1001, 102, 1, 50.00),
(3, 1002, 103, 3, 60.25),
(4, 1003, 104, 5, 60.00),
(5, 1004, 105, 4, 75.00),
(6, 1005, 106, 2, 125.00);

INSERT INTO PRODUCTS (PRODUCT_ID, PRODUCT_NAME, CATEGORY) VALUES
(101, 'PRODUCT1', 'ELECTRONICS'),
(102, 'PRODUCT2', 'BOOKS'),
(103, 'PRODUCT3', 'ELECTRONICS'),
(104, 'PRODUCT4', 'FURNITURE'),
(105, 'PRODUCT5', 'FURNITURE'),
(106, 'PRODUCT6', 'TOYS');

SELECT 
    C.CUSTOMER_NAME, 
    C.COUNTRY, 
    SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT
FROM 
    CUSTOMERS AS C
JOIN 
    ORDERS AS O 
ON 
    C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY 
    C.CUSTOMER_NAME, C.COUNTRY;

SELECT 
    C.CUSTOMER_NAME, 
    C.COUNTRY, 
    SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT
FROM 
    CUSTOMERS AS C
JOIN 
    ORDERS AS O 
ON 
    C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY 
    C.CUSTOMER_NAME, C.COUNTRY
ORDER BY 
    TOTAL_SPENT DESC
LIMIT 5;

SELECT 
    P.CATEGORY, 
    SUM(OI.QUANTITY) AS TOTAL_QUANTITY_SOLD
FROM 
    ORDER_ITEMS AS OI
JOIN 
    PRODUCTS AS P 
ON 
    OI.PRODUCT_ID = P.PRODUCT_ID
GROUP BY 
    P.CATEGORY;

SELECT 
    P.PRODUCT_NAME, 
    SUM(OI.QUANTITY) AS TOTAL_QUANTITY_SOLD
FROM 
    ORDER_ITEMS AS OI
JOIN 
    PRODUCTS AS P 
ON 
    OI.PRODUCT_ID = P.PRODUCT_ID
GROUP BY 
    P.PRODUCT_NAME
HAVING 
    TOTAL_QUANTITY_SOLD > 50;

SELECT 
    C.COUNTRY, 
    DATE_FORMAT(O.ORDER_DATE, '%Y-%m') AS MONTH, 
    SUM(O.TOTAL_AMOUNT) AS TOTAL_MONTHLY_SALES
FROM 
    ORDERS AS O
JOIN 
    CUSTOMERS AS C 
ON 
    O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY 
    C.COUNTRY, MONTH;

SELECT 
    C.COUNTRY, 
    AVG(O.TOTAL_AMOUNT) AS AVERAGE_ORDER_VALUE
FROM 
    ORDERS AS O
JOIN 
    CUSTOMERS AS C 
ON 
    O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY 
    C.COUNTRY;

SELECT 
    COUNTRY, 
    COUNT(CUSTOMER_ID) AS CUSTOMER_COUNT
FROM 
    CUSTOMERS
GROUP BY 
    COUNTRY
HAVING 
    CUSTOMER_COUNT < 5;
