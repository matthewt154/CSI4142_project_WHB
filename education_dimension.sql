DROP TABLE IF EXISTS education_dim, countries;

/*table holding country codes */
CREATE TEMPORARY TABLE countries (country varchar); 
INSERT INTO countries (country)
SELECT DISTINCT country_code FROM education_raw WHERE country_code IS NOT NULL;


SELECT e.series_name AS education_attribute, e.yr_2013 AS value
INTO education_dim
FROM education_raw e
WHERE country_code = 'CAN'; 

INSERT INTO education_dim VALUES ('Country', 'Canada');
INSERT INTO education_dim VALUES ('Year', 2013);

/*ALTER TABLE education_dim ADD COLUMN education_key serial PRIMARY KEY; */

SELECT * FROM education_dim
