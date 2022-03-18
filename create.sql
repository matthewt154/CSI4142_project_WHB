------------------------- Create 'Months' Table
DROP TABLE IF EXISTS Months CASCADE;

CREATE TABLE IF NOT EXISTS Months
(
    Name text NOT NULL,
    Quarter bigint NOT NULL,
    Year integer NOT NULL
);

COPY Months(name, Quarter, Year)
FROM 'D:\University\5thYear\4142_bulkdata\Month.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

ALTER TABLE Months ADD COLUMN monthkey serial PRIMARY KEY;

------------------------- Create 'Country' Table
DROP TABLE IF EXISTS country CASCADE;

CREATE TABLE IF NOT EXISTS country
(
    countrycode text NOT NULL UNIQUE,
    countryname text ,
    capital text ,
    currency text ,
    region text ,
    continent text ,
    incomegroup text,
    population bigint,
    birthrate bigint,
    deathrate bigint
);

COPY country(countrycode, countryname, currency, region, incomegroup)
FROM 'D:\University\5thYear\4142_bulkdata\HNP_StatsCountry.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

ALTER TABLE country ADD COLUMN countrykey serial PRIMARY KEY;

-- Delete entries of countries we aren't including
DELETE from country WHERE country.countryname NOT IN ('Canada', 'United States', 
						  'Brazil', 'Mexico', 'Niger',
						  'Syrian Arab Republic', 'South Africa', 'Thailand');
						  

------- Education Dimension -------
DROP TABLE IF EXISTS education_dim
CREATE TABLE education_dim
(
country_name varchar, 
country_code varchar,
series_name varchar,
series_code varchar,
yr_2005 varchar,
 yr_2006 varchar,
 yr_2007 varchar,
 yr_2008 varchar,
 yr_2009 varchar,
 yr_2010 varchar,
 yr_2011 varchar,
 yr_2012 varchar,
 yr_2013 varchar,
 yr_2014 varchar,
 yr_2015 varchar,
 yr_2016 varchar,
 yr_2017 varchar,
 yr_2018 varchar,
 yr_2019 varchar,
 yr_2020 varchar
);

COPY education_dim
FROM 'C:\Users\Dell\Desktop\CSI4142\CSI4142_project_WHB\spreadsheets\raw_data_educationDimension.csv' --modify path 
DELIMITER ','
CSV HEADER;

-----------Population Dimension ----------
DROP TABLE IF EXISTS population_dim 
CREATE TABLE population_dim
(
series_name varchar,
series_code varchar,
country_name varchar, 
country_code varchar,
yr_2005 varchar,
 yr_2006 varchar,
 yr_2007 varchar,
 yr_2008 varchar,
 yr_2009 varchar,
 yr_2010 varchar,
 yr_2011 varchar,
 yr_2012 varchar,
 yr_2013 varchar,
 yr_2014 varchar,
 yr_2015 varchar,
 yr_2016 varchar,
 yr_2017 varchar,
 yr_2018 varchar,
 yr_2019 varchar,
 yr_2020 varchar
);

COPY population_dim
FROM 'C:\Users\Dell\Desktop\CSI4142\CSI4142_project_WHB\spreadsheets\raw_data_populationDimension.csv' --modify path 
DELIMITER ','
CSV HEADER;

------------------------- Create Fact Table
DROP TABLE IF EXISTS fact;

SELECT m.monthkey, c.countrycode
INTO fact
from months m, Country c;

ALTER TABLE fact ADD COLUMN factkey serial PRIMARY KEY;

ALTER TABLE fact
	ADD CONSTRAINT fk_countrycode FOREIGN KEY (countrycode) REFERENCES country(countrycode);
	
ALTER TABLE fact
	ADD CONSTRAINT fk_monthkey FOREIGN KEY (monthkey) REFERENCES months(monthkey);

------------------------- Load Development index data & create table
drop table if exists index_dev;

create table index_dev (
	countryName text NOT NULL,
	countrycode text NOT NULL,
	Year integer NOT NULL,
	DevelopmentIndex decimal
);

COPY index_dev(countryName, countrycode, Year, DevelopmentIndex) 
FROM 'D:\University\5thYear\4142_bulkdata\development_index_v2.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

-------------------------  Create temp table to migrate development index data
drop table if exists tmp;

create table if not exists tmp (
	factkey serial PRIMARY KEY,
	developmentindex decimal);
	
------------------------- Populate temp table	
insert into tmp
	SELECT factkey, index_dev.developmentindex from fact
	INNER JOIN index_dev 
		ON index_dev.countrycode = fact.countrycode
	INNER JOIN Months m ON m.monthkey = fact.monthkey
		WHERE m.Year = index_dev.Year;
-----------------------------------------------
alter table fact drop if exists developmentindex;
alter table fact add developmentindex numeric;

------------------------- Populate fact table with the 'DevelopmentIndex' attribute
update fact as f
set developmentindex = t.developmentindex
from tmp as t
where t.factkey = f.factkey;


select * from fact order by monthkey;