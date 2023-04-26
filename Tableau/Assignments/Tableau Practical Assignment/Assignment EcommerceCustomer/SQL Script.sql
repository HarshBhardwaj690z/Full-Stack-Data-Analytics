create database ECommerce_Customer
use ECommerce_Customer

==================================================================================================================================================================================================================================================================================================================================================================================================================
set global max_allowed_packet = 209715200

set session sql_mode = ' '

 SET SQL_SAFE_UPDATES = 0;

SET @@GLOBAL.local_infile = 1;  ## local hosting is diabled solution
 

====================================================================================================================================================================================================================================================================================================================================================================================================================

drop table Customer ;
=====================================================================================================================================================================================================================================================================================================================================================================================================================

create table Customer (
Email Varchar(30),
Address Varchar(100),
Avatar Varchar(30),
`Avg. Session Length` Float (10,6),
`Time on App` Float (10,6),
`Time on Website` Float (10,6),
`Length of Membership` Float (10,6),
`Yearly Amount Spent` Float (10,6))

Load data local infile "D:\\Study\\INueron Data Analyst\\Tableau\\Assignment\\Tableau project\\Asiignment 4\\Ecommerce Customers.csv"
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 LINES

select * from Customer;
=======================================================================================================================================================================================================================================================================

SELECT Email, COUNT(Email)  
FROM customer  
GROUP BY Email 
HAVING COUNT(Email) > 1;    ##No duplicates

Select LTRIM(RTRIM(REGEXP_SUBSTR(Address, '. [A-Z]{2} .'))) FROM customer;

alter table customer
add column State_Code Varchar (5) after Address;

update customer
set State_Code = LTRIM(RTRIM(REGEXP_SUBSTR(Address, '. [A-Z]{2} .')))

Select LTRIM(RTRIM(REGEXP_SUBSTR(state_Code, '[A-Z]{2}'))) FROM customer;

update customer
set State_Code = LTRIM(RTRIM(REGEXP_SUBSTR(state_Code, '[A-Z]{2}')))

select state_code from customer

========================================================================================================================================================================================================================

alter table customer
drop column Address

=========================================================================================================================================================================================================================

select * from customer

=========================================================================================================================================================================================================================
select * from customer
INTO OUTFILE "D:\\Study\\INueron Data Analyst\\Tableau\\Assignment\\Tableau project\\Asiignment 4\\Ecommerce Customers1.csv"
FIELDS ENCLOSED BY '"'   
TERMINATED BY ','   
ESCAPED BY '"'   
LINES TERMINATED BY '\r\n';