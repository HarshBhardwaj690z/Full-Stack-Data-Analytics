Create database CIA_World_Factbook ;
use CIA_World_Factbook ;
===========================================================================================================
set session sql_mode = ' '

SET SQL_SAFE_UPDATES = 0;

SET @@GLOBAL.local_infile = 1;
============================================================================================================
drop table World_Population;

create table World_Population (
Country	Varchar(30),
Area decimal(38,2),
Birth_Rate decimal(38,2),
Death_Rate decimal(38,2),	
Migration_Rate decimal(38,2),
population int ,
population_growth_rate decimal(38,2)
);

LOAD DATA LOCAL INFILE 'C:\\Study\\INueron Data Analyst\\Mysql\\Projects\\assignment and projects completed\\iNeuron_SQL_Master_Project Completed\\Project 2\\Datasets\\cia_factbook.csv'
INTO TABLE World_Population
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @col2, @col3, @col4, @dummy, @dummy, @dummy, @dummy, @col5,@col6, @col7)
SET Country=@col1, Area=@col2, Birth_Rate=@col3, Death_Rate=@col4, Migration_Rate=@col5,population=@col6, population_growth_rate=@col7;

select * from World_Population;

============================================================================================================================================

##1. Which country has the highest population?

select country , population from World_Population
order by population desc
limit 1;

OR

SELECT country, population FROM World_Population WHERE population = (SELECT MAX(population) FROM World_Population) 

============================================================================================================================================
##2. Which country has the least number of people?

SELECT country, population FROM World_Population WHERE population = (SELECT MIN(population) FROM World_Population) 


============================================================================================================================================

##3. Which country is witnessing the highest population growth?

select country , population_growth_rate from World_Population
order by population_growth_rate desc
limit 1;

OR

SELECT country, population_growth_rate FROM World_Population WHERE population_growth_rate = (SELECT MAX(population_growth_rate) FROM World_Population) 
============================================================================================================================================

##4. Which country has an extraordinary number for the population?
 
 ?

============================================================================================================================================
##5. Which is the most densely populated country in the world?

select country, area, population, (population/area) as 'population density' from World_Population
order by (population/area) desc
limit 1;

========================================================================================================================================
========================================================================================================================================













