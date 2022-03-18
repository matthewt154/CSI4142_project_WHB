DROP TABLE IF EXISTS pop_dim, countries;

/*table holding country codes */
CREATE TEMPORARY TABLE countries (country varchar); 
INSERT INTO countries (country)
SELECT DISTINCT country_code FROM population_raw WHERE country_code IS NOT NULL;


SELECT e.series_name AS population_attribute, e.yr_2013 AS value
INTO population_dim
FROM population_raw e
WHERE country_code = 'CAN'; 

INSERT INTO population_dim VALUES ('Country', 'Canada');
INSERT INTO population_dim VALUES ('Year', 2013);

/*ALTER TABLE population_dim ADD COLUMN population_key serial PRIMARY KEY; */

SELECT * FROM population_dim
