CREATE TABLE customers_dim (
    customer_id bpchar NOT NULL,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    region character varying(15),
    terms character varying(24)
);

CREATE TABLE employees_dim (
    employee_id smallint NOT NULL,
    last_name character varying(20) NOT NULL,
    first_name character varying(10) NOT NULL,
    region character varying(15)
);

CREATE TABLE orders_dim (
    order_id smallint NOT NULL,
    customer_id bpchar,
    employee_id smallint,
    order_date date,
    required_date date,
    shipped_date date,
    ship_via smallint,
    freight real,
    ship_name character varying(40),
    ship_address character varying(60),
    ship_city character varying(15),
    ship_region character varying(15),
    ship_postal_code character varying(10),
    ship_country character varying(15)
);

CREATE TABLE order_details_dim (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL
);

CREATE TABLE date_time(
    Date_id Date NOT NULL,
    period_id smallint NOT NULL,
    year_id smallint NOT NULL
);

CREATE TABLE Invoice_dim(
    invoice_id smallint NOT NULL,
    order_id smallint NOT NULL
);

INSERT INTO customers_dim(customer_id,
    company_name,
	contact_name,
	contact_title,
	region)
SELECT customer_id, 
    company_name, 
    contact_name, 
    contact_title,
    region
FROM customers;

UPDATE customers_dim
    set terms = '2%10N30';

INSERT INTO employees_dim(
    employee_id,
    last_name,
    first_name,
    region)
select employee_id,
    last_name,
    first_name,
	region
from employees;

INSERT INTO orders_dim(
    order_id,
    customer_id,
    employee_id,
    order_date,
    required_date,
    shipped_date,
    ship_via,
    freight,
    ship_name,
    ship_address,
    ship_city,
    ship_region,
    ship_postal_code,
    ship_country)
select * from orders;

INSERT INTO order_details_dim(
    order_id,
    product_id,
    unit_price,
    quantity,
    discount)
SELECT * FROM order_details;

INSERT INTO date_time VALUES('1996-07-01', 1, 2020);
INSERT INTO date_time VALUES('1996-07-02', 1, 2020);
INSERT INTO date_time VALUES('1996-07-03', 1, 2020);
INSERT INTO date_time VALUES('1996-07-04', 1, 2020);
INSERT INTO date_time VALUES('1996-07-05', 1, 2020);
INSERT INTO date_time VALUES('1996-07-06', 1, 2020);
INSERT INTO date_time VALUES('1996-07-07', 1, 2020);
INSERT INTO date_time VALUES('1996-07-08', 1, 2020);
INSERT INTO date_time VALUES('1996-07-09', 1, 2020);
INSERT INTO date_time VALUES('1996-07-10', 1, 2020);
INSERT INTO date_time VALUES('1996-07-11', 1, 2020);
INSERT INTO date_time VALUES('1996-07-12', 1, 2020);
INSERT INTO date_time VALUES('1996-07-13', 1, 2020);
INSERT INTO date_time VALUES('1996-07-14', 1, 2020);

INSERT INTO Invoice_dim VALUES(1, 11077);
INSERT INTO Invoice_dim VALUES(1, 11076);
INSERT INTO Invoice_dim VALUES(1, 11075);
INSERT INTO Invoice_dim VALUES(1, 11074);
INSERT INTO Invoice_dim VALUES(1, 11073);
INSERT INTO Invoice_dim VALUES(1, 11072);
INSERT INTO Invoice_dim VALUES(1, 11071);