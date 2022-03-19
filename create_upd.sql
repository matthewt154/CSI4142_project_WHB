
------------------------- Create 'Months' Table
DROP TABLE IF EXISTS Months CASCADE;

CREATE TABLE IF NOT EXISTS Months
(
    Name text NOT NULL,
    Quarter bigint NOT NULL,
    Year integer NOT NULL
);

COPY Months(name, Quarter, Year)
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\Month.csv' -- Edit local path
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
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\HNP_StatsCountry.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

ALTER TABLE country ADD COLUMN countrykey serial PRIMARY KEY;

-- Delete entries of countries we aren't including
DELETE from country WHERE country.countryname NOT IN ('Canada', 'United States', 
						  'Brazil', 'Mexico', 'Niger',
						  'Syrian Arab Republic', 'South Africa', 'Thailand', 'Venezuela');
						  

------- Education Dimension -------
DROP TABLE IF EXISTS education_dim;
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
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\raw_data_educationDimension.csv' --modify path 
DELIMITER ','
CSV HEADER;

ALTER TABLE education_dim ADD COLUMN educationkey serial PRIMARY KEY;
-----------Population Dimension ----------
DROP TABLE IF EXISTS population_dim CASCADE;
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
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\raw_data_populationDimension.csv' --modify path 
DELIMITER ','
CSV HEADER;
ALTER TABLE population_dim ADD COLUMN populationkey serial PRIMARY KEY;
/*
-----------Health Dimension ----------
DROP TABLE IF EXISTS health_dim;
CREATE TABLE health_dim
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

COPY health_dim
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\raw_data_healthDimension.csv' --modify path 
DELIMITER ','
CSV HEADER;

ALTER TABLE health_dim ADD COLUMN healthkey serial PRIMARY KEY;

-----------Quality of Life Dimension ----------
DROP TABLE IF EXISTS quality_dim;
CREATE TABLE quality_dim 
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

COPY quality_dim 
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\raw_data_qualityDimension.csv' --modify path 
DELIMITER ','
CSV HEADER;

ALTER TABLE quality_dim ADD COLUMN qualitykey serial PRIMARY KEY;*/
------------------------- Create Fact Table
DROP TABLE IF EXISTS fact;

SELECT m.monthkey, c.countrycode, p.populationkey--, e.educationkey
INTO fact
from months m, Country c, population_dim p;--, education_dim e;

ALTER TABLE fact
	ADD CONSTRAINT fk_countrycode FOREIGN KEY (countrycode) REFERENCES country(countrycode),
	ADD CONSTRAINT fk_monthkey FOREIGN KEY (monthkey) REFERENCES months(monthkey),
	ADD CONSTRAINT fk_populationkey FOREIGN KEY (populationkey) REFERENCES population_dim(populationkey),
	ADD CONSTRAINT UNIQUE (countrycode, populationkey);
/*	
ALTER TABLE fact
	ADD CONSTRAINT fk_monthkey FOREIGN KEY (monthkey) REFERENCES months(monthkey);

ALTER TABLE fact
    ADD CONSTRAINT fk_educationkey FOREIGN KEY (educationkey) REFERENCES education_dim(educationkey);

ALTER TABLE fact
    ADD CONSTRAINT fk_populationkey FOREIGN KEY (populationkey) REFERENCES population_dim(populationkey);

ALTER TABLE fact
    ADD CONSTRAINT fk_healthkey FOREIGN KEY (healthkey) REFERENCES health_dim(healthkey);

ALTER TABLE fact
    ADD CONSTRAINT fk_qualitykey FOREIGN KEY (qualitykey) REFERENCES quality_dim(qualitykey);
	*/
------------------------- Load Development index data into a temporary table.
drop table if exists index_dev;

create table index_dev (
	countryName text NOT NULL,
	countrycode text NOT NULL,yr_2005 decimal,
 	yr_2006 decimal,yr_2007 decimal,yr_2008 decimal,yr_2009 decimal,yr_2010 decimal,yr_2011 decimal,yr_2012 decimal,yr_2013 decimal,yr_2014 decimal,yr_2015 decimal,yr_2016 decimal,yr_2017 decimal,yr_2018 decimal,yr_2019 decimal,yr_2020 decimal
);

COPY index_dev
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\development_index.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

-- Create a numeric column to store the developmentIndex data. 
alter table fact drop if exists developmentindex;
alter table fact add developmentindex numeric;
-- Update the fact table.
update fact as f
	set developmentindex = (CASE
		WHEN m.year = 2005 THEN i.yr_2005
		WHEN m.year = 2006 THEN i.yr_2006
		WHEN m.year = 2007 THEN i.yr_2007
		WHEN m.year = 2008 THEN i.yr_2008
		WHEN m.year = 2009 THEN i.yr_2009
		WHEN m.year = 2010 THEN i.yr_2010
		WHEN m.year = 2011 THEN i.yr_2011
		WHEN m.year = 2012 THEN i.yr_2012
		WHEN m.year = 2013 THEN i.yr_2013
		WHEN m.year = 2014 THEN i.yr_2014
		WHEN m.year = 2015 THEN i.yr_2015
		WHEN m.year = 2016 THEN i.yr_2016
		WHEN m.year = 2017 THEN i.yr_2017
		WHEN m.year = 2018 THEN i.yr_2018
		WHEN m.year = 2019 THEN i.yr_2019
		WHEN m.year = 2020 THEN i.yr_2020
	END)
	FROM months m, index_dev i
	WHERE i.countrycode = f.countrycode AND m.monthkey = f.monthkey;

DROP TABLE index_dev;

ALTER TABLE fact ADD COLUMN factkey serial PRIMARY KEY;
--ALTER TABLE fact ADD PRIMARY KEY (monthkey, countrycode, populationkey)
