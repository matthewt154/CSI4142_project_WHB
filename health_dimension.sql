DROP TABLE IF EXISTS health_dim, countries;

/*table holding country codes */
CREATE TEMPORARY TABLE countries (country varchar); 
INSERT INTO countries (country)
SELECT DISTINCT country_code FROM health_raw WHERE country_code IS NOT NULL;


SELECT e.series_name AS health_attribute, e.yr_2013 AS value
INTO health_dim
FROM health_raw e
WHERE country_code = 'CAN'; 

INSERT INTO health_dim VALUES ('Country', 'Canada');
INSERT INTO health_dim VALUES ('Year', 2013);

/*ALTER TABLE health_dim ADD COLUMN health_key serial PRIMARY KEY; */

SELECT * FROM health_dim
