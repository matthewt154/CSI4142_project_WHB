DROP TABLE IF EXISTS quality_dim, countries;

/*table holding country codes */
CREATE TEMPORARY TABLE countries (country varchar); 
INSERT INTO countries (country)
SELECT DISTINCT country_code FROM quality_raw WHERE country_code IS NOT NULL;


SELECT e.series_name AS quality_attribute, e.yr_2013 AS value
INTO quality_dim
FROM health_dim_raw e
WHERE country_code = 'CAN'; 

INSERT INTO quality_dim VALUES ('Country', 'Canada');
INSERT INTO quality_dim VALUES ('Year', 2013);

/*ALTER TABLE quality_dim ADD COLUMN quality_key serial PRIMARY KEY; */

SELECT * FROM quality_dim
