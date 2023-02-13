create database Accidents
use Accidents
=========================================================================================================================
set global max_allowed_packet = 209715200

set session sql_mode = ' '

 SET SQL_SAFE_UPDATES = 0;

SET @@GLOBAL.local_infile = 1;

=================================================================================================================================

CREATE TABLE accident(
	accident_index VARCHAR(13),
    accident_severity INT
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);


CREATE TABLE vehicle_types(
	vehicle_code INT,
    vehicle_type VARCHAR(10)
);


LOAD DATA LOCAL INFILE 'C:\\Study\\INueron Data Analyst\\Mysql\\Projects\\assignment and projects completed\\iNeuron_SQL_Master_Project Completed\\Project 1\\Datasets\\Accidents_2015.csv'
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;


LOAD DATA LOCAL INFILE 'C:\\Study\\INueron Data Analyst\\Mysql\\Projects\\assignment and projects completed\\iNeuron_SQL_Master_Project Completed\\Project 1\\Datasets\\Vehicles_2015.csv'
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;


LOAD DATA LOCAL INFILE 'C:\\Study\\INueron Data Analyst\\Mysql\\Projects\\assignment and projects completed\\iNeuron_SQL_Master_Project Completed\\Project 1\\Datasets\\vehicle_types.csv'
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


Select * from Accident
Select * from vehicles
Select * from vehicle_types
=======================================================================================================================
##1.  Evaluate the median severity value of accidents caused by various Motorcycles. ( MYSQL and PYTHON )

CREATE TABLE accidents_median(
vehicle_types VARCHAR(100),
severity INT
);

select * from accidents_median


========================================================================================================================
##2. Evaluate Accident Severity and Total Accidents per Vehicle Type


select vt.Vehicle_Type as 'Vehicle Type', a.accident_severity as 'Severity', COUNT(v.vehicle_type) AS 'Number of Accidents' 
from accident a
JOIN Vehicles v ON a.accident_index = v.accident_index
JOIN Vehicle_Types vt ON v.vehicle_type = vt.vehicle_code
Group by 1
Order by 2 ;

=====================================================================================================================================
##3. Calculate the Average Severity by vehicle type.

select vt.Vehicle_Type as 'Vehicle Type', avg(a.accident_severity) as 'average severity' from accident a
JOIN Vehicles v ON a.accident_index = v.accident_index
JOIN Vehicle_Types vt ON v.vehicle_type = vt.vehicle_code
Group by 1
Order by 2 ;

========================================================================================================================================
##4. Calculate the Average Severity and Total Accidents by Motorcycle.

select vt.Vehicle_Type as 'Vehicle Type', avg(a.accident_severity) as 'average severity' from accident a
JOIN Vehicles v ON a.accident_index = v.accident_index
JOIN Vehicle_Types vt ON v.vehicle_type = vt.vehicle_code
Group by 1
HAVING vt.Vehicle_type = 'motorcycle'
Order by 2 ;

=========================================================================================================================================
=========================================================================================================================================
=========================================================================================================================================
=========================================================================================================================================
Unused

INSERT INTO accident_by_Motorcycle (Vehicle_Type, accident_severity) 
SELECT vt.vehicle_type, a.accident_severity
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
WHERE vt.vehicle_type = "Motorcycle"
ORDER BY a.accident_severity;
=======================================================================================================================================