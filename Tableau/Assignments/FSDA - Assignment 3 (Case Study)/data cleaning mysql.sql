create database amazon_marchant_casestudy
Use amazon_marchant_casestudy
==================================================================================================================================================================================================================================================================================================================================================================================================================
set global max_allowed_packet = 209715200

set session sql_mode = ' '

 SET SQL_SAFE_UPDATES = 0;

SET @@GLOBAL.local_infile = 1;  ## local hosting is diabled solution
====================================================================================================================================================================================================================================================================================================================================================================================================================

drop table Amazon_Marchant ;
=====================================================================================================================================================================================================================================================================================================================================================================================================================

create Table Amazon_Marchant (
date_Added VARCHAR(10),
category VARCHAR(10),
sellerproductcount VARCHAR(30),
sellerratings VARCHAR(100),
sellerdetails VARCHAR(1000),
seller_business_name VARCHAR(1000),
businessaddress VARCHAR(1000),
Count_of_seller_brands int,
Max_percent_of_negative_seller_ratings_last_30_days float(100,2),
Max_percent_of_negative_seller_ratings_last_90_days float(100,2),
Max_percent_of_negative_seller_ratings_last_12_month float(100,2),
Hero_Product_1_ratings int,
Hero_Product_2_ratings int)

load data local Infile  "D:\\Study\\INueron Data Analyst\\Tableau\\Assignment\\FSDA Assignment\\Assignment 3\\Dataset\\Sample_Longlist_Data.csv"
INTO TABLE Amazon_Marchant
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@Date_Added, @category,@dummy, @dummy, @dummy, @sellerproductcount, @sellerratings, @sellerdetails, @seller_business_name, @businessaddress, @Count_of_seller_brands, @Max_percent_of_negative_seller_ratings_last_30_days , @Max_percent_of_negative_seller_ratings_last_90_days, @Max_percent_of_negative_seller_ratings_last_12_month , @Hero_Product_1_ratings,	@Hero_Product_2_ratings, @dummy, @dummy)
SET Date_Added=@Date_Added, category= @category, sellerproductcount = @sellerproductcount, sellerratings = @sellerratings, sellerdetails = @sellerdetails, seller_business_name = @seller_business_name, businessaddress = @businessaddress, Count_of_seller_brands = @Count_of_seller_brands, Max_percent_of_negative_seller_ratings_last_30_days = @Max_percent_of_negative_seller_ratings_last_30_days , Max_percent_of_negative_seller_ratings_last_90_days = @Max_percent_of_negative_seller_ratings_last_90_days, Max_percent_of_negative_seller_ratings_last_12_month = @Max_percent_of_negative_seller_ratings_last_12_month , Hero_Product_1_ratings = @Hero_Product_1_ratings,	Hero_Product_2_ratings = @Hero_Product_2_ratings ;

select * from Amazon_Marchant;
select count(*) from Amazon_Marchant; ##total rows are 1839

==================================================================================================================================================================================================================================================================================================================================================================

#Checking for Blank values (( Zero in integer column in Okay we are only looking for blank columns ))

SELECT * FROM Amazon_Marchant WHERE date_Added = '' ##No blank Values
SELECT * FROM Amazon_Marchant WHERE category = '' ##No blank Values
SELECT * FROM Amazon_Marchant WHERE sellerproductcount = ''
SELECT * FROM Amazon_Marchant WHERE sellerratings = ''
SELECT * FROM Amazon_Marchant WHERE sellerdetails = ''
SELECT * FROM Amazon_Marchant WHERE seller_business_name = ''
SELECT * FROM Amazon_Marchant WHERE businessaddress = ''
SELECT * FROM Amazon_Marchant WHERE Count_of_seller_brands = '' ## Found 0 which is justified but No blank Values 
SELECT * FROM Amazon_Marchant WHERE Max_percent_of_negative_seller_ratings_last_30_days = ''  ## Found 0 which is justified but No blank Values 
SELECT * FROM Amazon_Marchant WHERE Max_percent_of_negative_seller_ratings_last_90_days = ''  ## Found 0 which is justified but No blank Values 
SELECT * FROM Amazon_Marchant WHERE Max_percent_of_negative_seller_ratings_last_12_month = ''  ## Found 0 which is justified but No blank Values 
SELECT * FROM Amazon_Marchant WHERE Hero_Product_1_ratings = ''  ## Found 0 which is justified but No blank Values 
SELECT * FROM Amazon_Marchant WHERE Hero_Product_2_ratings = ''  ## Found 0 which is justified but No blank Values 


##Counting blank columns

SELECT count(*)FROM Amazon_Marchant WHERE sellerproductcount = '' ##326
SELECT count(*) FROM Amazon_Marchant WHERE sellerratings = '' ##428
SELECT count(*) FROM Amazon_Marchant WHERE sellerdetails = '' ##27
SELECT count(*) FROM Amazon_Marchant WHERE seller_business_name = '' ##56
SELECT count(*) FROM Amazon_Marchant WHERE businessaddress = '' ##75

##Checking for null values

SELECT * FROM Amazon_Marchant WHERE date_Added IS NULL   
SELECT * FROM Amazon_Marchant WHERE category IS NULL  
SELECT * FROM Amazon_Marchant WHERE sellerproductcount IS NULL 
SELECT * FROM Amazon_Marchant WHERE sellerratings IS NULL 
SELECT * FROM Amazon_Marchant WHERE sellerdetails IS NULL 
SELECT * FROM Amazon_Marchant WHERE seller_business_name IS NULL 
SELECT * FROM Amazon_Marchant WHERE businessaddress IS NULL 
SELECT * FROM Amazon_Marchant WHERE Count_of_seller_brands IS NULL  
SELECT * FROM Amazon_Marchant WHERE Max_percent_of_negative_seller_ratings_last_30_days IS NULL
SELECT * FROM Amazon_Marchant WHERE Max_percent_of_negative_seller_ratings_last_90_days IS NULL   
SELECT * FROM Amazon_Marchant WHERE Max_percent_of_negative_seller_ratings_last_12_month IS NULL   
SELECT * FROM Amazon_Marchant WHERE Hero_Product_1_ratings IS NULL  
SELECT * FROM Amazon_Marchant WHERE Hero_Product_2_ratings IS NULL   


## NOTE :- NO NULL VALUES ARE FOUND!!!
=====================================================================================================================================================================================================================
##Modifying or Droping the blank rows

delete from Amazon_Marchant WHERE sellerdetails = ''


Update Amazon_Marchant
set businessaddress = 'Uknown' where businessaddress = ''

SELECT * FROM Amazon_Marchant WHERE businessaddress = 'Uknown'


delete from Amazon_Marchant WHERE sellerproductcount = ''


delete from Amazon_Marchant WHERE seller_business_name = ''

delete from Amazon_Marchant WHERE sellerratings = '' ##Since rating is a must thing to decide top performaer and we cannot assume, make it zero or take a mean out of it, so we are droping it.

===================================================================================================================================================================================================================
select count(*) from Amazon_Marchant; ##total rows are 1176
====================================================================================================================================================================================================================
##fixing sellerproductcount


/*select substring(sellerproductcount, 13) from Amazon_Marchant ##not works correctly

select right(rtrim(Ltrim(sellerproductcount)),13) from Amazon_Marchant # not working

SELECT REGEXP_SUBSTR(sellerproductcount, '[0-9\,0-9]{1,}') FROM Amazon_Marchant #Not working

SELECT REGEXP_SUBSTR(sellerproductcount, '[^0-9]*[0-9]+[^0-9]+([0-9]+)') FROM Amazon_Marchant #Not working*/


SELECT Rtrim(Ltrim(REGEXP_SUBSTR(sellerproductcount, ' .[0-9,]+'))) FROM Amazon_Marchant ##Correct

###Update Extracted value into the table
update Amazon_Marchant
set sellerproductcount = Rtrim(Ltrim(REGEXP_SUBSTR(sellerproductcount, ' .[0-9,]+')))

update Amazon_Marchant
set sellerproductcount = replace(sellerproductcount,",",'')

##Checking the Update
select sellerproductcount  from Amazon_Marchant

##Changing Column Value datatype from Varchar to integer
ALTER TABLE Amazon_Marchant MODIFY sellerproductcount INTEGER;

update Amazon_Marchant
set sellerproductcount = cast(sellerproductcount as Unsigned)



SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'amazon_marchant_casestudy'
AND TABLE_NAME = 'Amazon_Marchant'
AND COLUMN_NAME = 'sellerproductcount'

##Checking the Update
select sellerproductcount  from Amazon_Marchant
===================================================================================================================================================================================================================
##Fixing sellerratings


##Extracting Positive Rating %

select Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '[:digit:]+'))) FROM Amazon_Marchant

Alter table Amazon_Marchant
add column Positive_Rating_percentage float(10,2) after sellerratings

update Amazon_MArchant
set Positive_Rating_percentage = Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '[:digit:]+')))


select Positive_Rating_percentage from Amazon_Marchant



##Extracting Positive Rating % and dividing that into lifetime


select Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '[:digit:]+'))) FROM Amazon_Marchant where sellerratings rlike 'lifetime'

Alter table Amazon_Marchant
add column Lifetime_Positive_Rating_percentage float(10,2) after sellerratings

update Amazon_MArchant
set Lifetime_Positive_Rating_percentage = Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '[:digit:]+'))) where sellerratings rlike 'lifetime'

update Amazon_Marchant
set Lifetime_Positive_Rating_percentage = 0 where Lifetime_Positive_Rating_percentage IS NULL

select Lifetime_Positive_Rating_percentage from Amazon_Marchant



##Extracting Positive Rating % and dividing that into lifetime


select Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '[:digit:]+'))) FROM Amazon_Marchant where sellerratings rlike 'months'

Alter table Amazon_Marchant
add column Past_12Months_Positive_Rating_percentage float(10,2) after sellerratings

update Amazon_Marchant
set Past_12Months_Positive_Rating_percentage = Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '[:digit:]+'))) where sellerratings rlike 'months'

update Amazon_Marchant
set Past_12Months_Positive_Rating_percentage = 0 where Past_12Months_Positive_Rating_percentage IS NULL

select Past_12Months_Positive_Rating_percentage from Amazon_Marchant



#extracting Numerical Rating and replacing it in sellrating column


select Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '.\\([:digit:]+'))) FROM Amazon_Marchant

update Amazon_Marchant
set  Sellerratings = Rtrim(Ltrim(REGEXP_SUBSTR(sellerratings, '.\\([:digit:]+')))

update Amazon_Marchant
set Sellerratings = replace(Sellerratings,"(",'')

##Changing Column Value datatype from Varchar to integer

ALTER TABLE Amazon_Marchant MODIFY Sellerratings INTEGER;

update Amazon_Marchant
set Sellerratings = cast(Sellerratings as Unsigned)

select Sellerratings from Amazon_Marchant

========================================================================================================================================================================================================================
##Extracting country code from address

select right(businessaddress, 2) from Amazon_Marchant

alter table Amazon_Marchant
add column Country_Code Varchar(3) after businessaddress

update Amazon_Marchant
set Country_Code = right(businessaddress, 2)

select distinct(Country_Code) from Amazon_Marchant

/*
US- United States
DE - Germany
CN - China
IE - Ireland
PL- Poland
wn - West Indies
GB- Great Britain
IT - Italy
FR - France
SE - sweden
ES - Spain
AT - Austria
HK - Honk Kong
NL - Netherlands
TH - Thailand
AU - Australia 
BE - Belgium
JP - Japan
CZ - Czechia
IN - India
CH - switzerland
*/

Alter Table Amazon_Marchant
Add Country Varchar(15) after businessaddress 

update Amazon_Marchant
set country = 'United States' where country_code = 'US'

update Amazon_Marchant
set country = 'Germany' where country_code = 'DE'

update Amazon_Marchant
set country = 'China' where country_code = 'CN'

update Amazon_Marchant
set country = 'Ireland' where country_code = 'IE'

update Amazon_Marchant
set country = 'Poland' where country_code = 'PL'

update Amazon_Marchant
set country = 'West Indies' where country_code = 'WN'

update Amazon_Marchant
set country = 'Great Britain' where country_code = 'GB'

update Amazon_Marchant
set country = 'Italy' where country_code = 'IT'

update Amazon_Marchant
set country = 'France' where country_code = 'FR'

update Amazon_Marchant
set country = 'Spain' where country_code = 'ES'

update Amazon_Marchant
set country = 'Sweden' where country_code = 'SE'

update Amazon_Marchant
set country = 'Austria' where country_code = 'AT'

update Amazon_Marchant
set country = 'Hong Kong' where country_code = 'HK'

update Amazon_Marchant
set country = 'Thailand' where country_code = 'TH'

update Amazon_Marchant
set country = 'India' where country_code = 'IN'

update Amazon_Marchant
set country = 'Netherland' where country_code = 'NL'

update Amazon_Marchant
set country = 'Australia' where country_code = 'AU'

update Amazon_Marchant
set country = 'Belgium' where country_code = 'BE'

update Amazon_Marchant
set country = 'Czechia' where country_code = 'CZ'

update Amazon_Marchant
set country = 'Switzerland' where country_code = 'CH'

update Amazon_Marchant
set country = 'Japan' where country_code = 'JP'



select country from Amazon_Marchant


#Dropping column Businessaddress

alter table Amazon_Marchant
Drop businessaddress
========================================================================================================================================================================================================================
## Checking Business name column

/* checking if we got any other thing apart from business name */
select seller_Business_Name from Amazon_Marchant where seller_Business_Name not regexp 'Business Name:'
/* we got VAT number */


update Amazon_Marchant
set Seller_Business_Name = replace(seller_Business_Name, 'Business Name:', '')

select Seller_Business_Name from Amazon_Marchant



/* it doesn't make any sense to pull out 'VAT number' fromt this column because we can always refer a business as 'VAT Number' instead of 'Business Name' either */

=========================================================================================================================================================================================================================
select * from Amazon_Marchant