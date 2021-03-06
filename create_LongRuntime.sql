
------------------------- Create 'Months' Table
DROP TABLE IF EXISTS Months CASCADE;

CREATE TABLE IF NOT EXISTS Months
(
    Name text NOT NULL,
    Quarter smallint NOT NULL,
    Year smallint NOT NULL
);

COPY Months(name, Quarter, Year)
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\Month.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

ALTER TABLE Months ADD COLUMN monthkey smallserial PRIMARY KEY;

------------------------- Create 'Country' Table
DROP TABLE IF EXISTS country CASCADE;

CREATE TABLE IF NOT EXISTS country
(
    countrycode text NOT NULL,
    countryname text ,
    capital text ,
    currency text ,
    region text ,
    continent text ,
    incomegroup text,
    series_name text,
	series_code text,
	yr_2005 decimal,
    yr_2006 decimal,
    yr_2007 decimal,
	yr_2008 decimal,
	yr_2009 decimal,
	yr_2010 decimal,
	yr_2011 decimal,
	yr_2012 decimal,
	yr_2013 decimal,
	yr_2014 decimal,
	yr_2015 decimal,
	yr_2016 decimal,
	yr_2017 decimal,
	yr_2018 decimal,
	yr_2019 decimal,
	yr_2020 decimal
);

COPY country(countrycode, countryname, capital, region, continent, incomegroup, currency, 
	series_name, series_code, yr_2005,yr_2006,yr_2007,yr_2008,yr_2009,yr_2010,
	yr_2011, yr_2012, yr_2013, yr_2014, yr_2015, yr_2016, yr_2017, yr_2018,
	yr_2019, yr_2020)
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\total_population.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

DELETE from country WHERE country.countryname NOT IN ('Canada', 'United States', 
						  'Brazil', 'Mexico', 'Congo, Dem. Rep.',
						  'Niger', 'South Africa', 'Thailand', 'Syrian Arab Republic');
				  
UPDATE country
SET continent = 'South America' where countryname = 'Brazil';
UPDATE country
SET continent = 'North America' where countryname = 'Canada' 
	or countryname = 'United States'
	or countryname = 'Mexico';
UPDATE country
SET continent = 'Africa' where countryname='Congo, Dem. Rep.'
	or countryname='Niger' 
	or countryname='South Africa';
UPDATE country
SET continent = 'Asia' where countryname = 'Thailand'
	or countryname='Syrian Arab Republic';
	
UPDATE country
SET capital = 'Brasilia' where countryname = 'Brazil';
UPDATE country
SET capital = 'Ottawa' where countryname = 'Canada';
UPDATE country
SET capital = 'Kinshasa' where countryname = 'Congo, Dem. Rep.';
UPDATE country
SET capital = 'Mexico City' where countryname = 'Mexico';
UPDATE country
SET capital = 'Niamey' where countryname = 'Niger';
UPDATE country
SET capital = 'Damascus' where countryname = 'Syrian Arab Republic';
UPDATE country
SET capital = 'Bangkok' where countryname = 'Thailand';
UPDATE country
SET capital = 'Washington' where countryname = 'United States';
UPDATE country
SET capital = 'Cape Town' where countryname = 'South Africa';

ALTER TABLE country ADD COLUMN countrykey smallserial PRIMARY KEY;


------- Education Dimension -------
DROP TABLE IF EXISTS education_dim CASCADE;
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
DELETE FROM education_dim WHERE country_code IS NULL;
ALTER TABLE education_dim ADD COLUMN educationkey smallserial PRIMARY KEY;
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
DELETE FROM population_dim WHERE country_code IS NULL;
ALTER TABLE population_dim ADD COLUMN populationkey smallserial PRIMARY KEY;

-----------Health Dimension ----------
DROP TABLE IF EXISTS health_dim CASCADE;
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
DELETE FROM health_dim WHERE country_code IS NULL;
ALTER TABLE health_dim ADD COLUMN healthkey smallserial PRIMARY KEY;

-----------Quality of Life Dimension ----------
DROP TABLE IF EXISTS quality_dim CASCADE;
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
DELETE FROM quality_dim WHERE country_code IS NULL;
ALTER TABLE quality_dim ADD COLUMN qualitykey smallserial PRIMARY KEY;
------------------------- Create Fact Table
DROP TABLE IF EXISTS fact;
/*
SELECT m.monthkey, c.countrycode, p.populationkey, e.educationkey, h.healthkey
INTO fact
from months m, Country c, population_dim p, education_dim e, health_dim h/*, 
	(SELECT e.educationkey FROM Country c LEFT OUTER JOIN education_dim e ON e.country_code = c.countrycode) x*/
where p.country_code=c.countrycode and e.country_code=c.countrycode and h.country_code = c.countrycode;*/

SELECT m.monthkey, x.countrykey, x.educationkey, x.populationkey, x.healthkey, x.qualitykey  
INTO fact
FROM
months m, (SELECT e.educationkey, c.countrykey, p.populationkey, h.healthkey, q.qualitykey
 	FROM Country c 
 	INNER JOIN education_dim e 
 		ON e.country_code = c.countrycode
	INNER JOIN population_dim p
		ON p.country_code = c.countrycode
	INNER JOIN health_dim h
		ON h.country_code = c.countrycode
	INNER JOIN quality_dim q
		ON q.country_code = c.countrycode) x;

------------------------- Prep & load the development & quality-of-life index measures.
drop table if exists index_dev;
drop table if exists qol_index;

create table index_dev (
	countryName text NOT NULL,
	countrycode text NOT NULL,yr_2005 decimal,
 	yr_2006 decimal,yr_2007 decimal,yr_2008 decimal,yr_2009 decimal,yr_2010 decimal,yr_2011 decimal,yr_2012 decimal,yr_2013 decimal,yr_2014 decimal,yr_2015 decimal,yr_2016 decimal,yr_2017 decimal,yr_2018 decimal,yr_2019 decimal,yr_2020 decimal
);

COPY index_dev
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\development_index.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

create table qol_index (
	countryName text NOT NULL,
	countrycode text NOT NULL, yr_2013_rank decimal,
 	yr_2014_h1_rank decimal,yr_2014_h2_rank decimal,yr_2015_h1_rank decimal,yr_2015_h2_rank decimal,yr_2016_h1_rank decimal,yr_2016_h2_rank decimal,yr_2017_h1_rank decimal,yr_2017_h2_rank decimal,yr_2018_h1_rank decimal,yr_2018_h2_rank decimal,yr_2019_h1_rank decimal,yr_2019_h2_rank decimal,yr_2020_h1_rank decimal,yr_2020_h2_rank decimal);

COPY qol_index
FROM 'D:\University\5thYear\Winter 2022\CSI 4142 - Fundamentals of Data Science\Project\Deliverable03\CSI4142_project_WHB\spreadsheets\qol_idx.csv' -- Edit local path
DELIMITER ',' CSV HEADER;

----------------------------------------- Update the fact table.
alter table fact add developmentindex numeric;
alter table fact add qol numeric;
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
	END),
	qol = (CASE
		WHEN m.year = 2013 THEN q.yr_2013_rank
		WHEN m.year = 2014 AND m.quarter <= 2 THEN q.yr_2014_h1_rank
		WHEN m.year = 2014 AND m.quarter > 2  THEN q.yr_2014_h2_rank
		WHEN m.year = 2015 AND m.quarter <= 2 THEN q.yr_2015_h1_rank
		WHEN m.year = 2015 AND m.quarter > 2  THEN q.yr_2015_h2_rank
		WHEN m.year = 2016 AND m.quarter <= 2 THEN q.yr_2016_h1_rank
		WHEN m.year = 2016 AND m.quarter > 2  THEN q.yr_2016_h2_rank
		WHEN m.year = 2017 AND m.quarter <= 2 THEN q.yr_2017_h1_rank
		WHEN m.year = 2017 AND m.quarter > 2  THEN q.yr_2017_h2_rank
		WHEN m.year = 2018 AND m.quarter <= 2 THEN q.yr_2018_h1_rank
		WHEN m.year = 2018 AND m.quarter > 2  THEN q.yr_2018_h2_rank
		WHEN m.year = 2019 AND m.quarter <= 2 THEN q.yr_2019_h1_rank
		WHEN m.year = 2019 AND m.quarter > 2  THEN q.yr_2019_h2_rank
		WHEN m.year = 2020 AND m.quarter <= 2 THEN q.yr_2020_h1_rank
		WHEN m.year = 2020 AND m.quarter > 2  THEN q.yr_2020_h2_rank
		ELSE q.yr_2013_rank
	END)
	FROM months m, index_dev i, qol_index q, country c
	WHERE (i.countrycode = c.countrycode
		OR q.countrycode = c.countrycode) 
		AND f.countrykey = c.countrykey
		AND f.monthkey = m.monthkey;

------------------------- Add PK to the Fact Table.
ALTER TABLE fact DROP COLUMN IF EXISTS factkey;
ALTER TABLE fact ADD COLUMN factkey serial PRIMARY KEY;
------------------------- Set 'NOT NULL' constraints to the new measures
ALTER TABLE fact
	ALTER COLUMN developmentindex SET NOT NULL,
	ALTER COLUMN qol SET NOT NULL; 
------------------------- Add FK references to the fact table
ALTER TABLE fact
	ADD CONSTRAINT fk_countrykey FOREIGN KEY (countrykey) REFERENCES country(countrykey),
	ADD CONSTRAINT fk_monthkey FOREIGN KEY (monthkey) REFERENCES months(monthkey),
	ADD CONSTRAINT fk_populationkey FOREIGN KEY (populationkey) REFERENCES population_dim(populationkey),
	ADD CONSTRAINT fk_educationkey FOREIGN KEY (educationkey) REFERENCES education_dim(educationkey),
	ADD CONSTRAINT fk_healthkey FOREIGN KEY (healthkey) REFERENCES health_dim(healthkey),
	ADD CONSTRAINT fk_qualitykey FOREIGN KEY (qualitykey) REFERENCES quality_dim(qualitykey);
	

------------------------- Return the size of the fact table.
SELECT reltuples AS estimate FROM pg_class where relname = 'fact';
