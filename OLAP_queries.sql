--Standard OLAP queries 

--a1. Drill down query to find population value of country during specific year
--Example, total life expectancy at birth of Brazil vs Canada in 2015 
SELECT 
	country_name,
	series_name,
	yr_2015
FROM 
	population_dim 
--INNER JOIN country USING (countrycode) 
WHERE 
	(country_code='BRA' OR country_code='CAN') AND 
	series_name='Life expectancy at birth, total (years)'
GROUP BY
	country_name, series_name, yr_2015;

--TO_DO needs some work 
--a2. Roll up example find total average data on education in the continent of Africa in 2015
SELECT 
	series_name,
	AVG (yr_2015)
FROM 
	country INNER JOIN qol_index ON country.countrycode=qol_index.countrycode
WHERE 
	continent='Africa'
GROUP BY
	ROLLUP (series_name);


--b).slice query example, contrasting the domestic health spending and life expectancy in 2010 for all countries
SELECT 
	population_dim.country_name,
	population_dim.yr_2010 AS life_expectancy,
	health_dim.yr_2010 AS Domestic_health_expenditure_percent
FROM 
	population_dim INNER JOIN health_dim 
	ON population_dim.country_code=health_dim.country_code
WHERE 
	population_dim.series_name='Life expectancy at birth, total (years)' AND 
	health_dim.series_name='Domestic general government health expenditure (% of current health expenditure)'

	
GROUP BY
	population_dim.country_name,
	population_dim.yr_2010,
	health_dim.yr_2010;

-- c1) Dice contrasting the domestic health spending and life expectancy in 2010 for Mexico vs Canada
SELECT 
	population_dim.country_name,
	population_dim.yr_2010 AS life_expectancy,
	health_dim.yr_2010 AS Domestic_health_expenditure_percent
FROM 
	population_dim INNER JOIN health_dim 
	ON population_dim.country_code=health_dim.country_code
WHERE 
	(population_dim.country_code = 'CAN' OR population_dim.country_code='MEX') AND
	population_dim.series_name='Life expectancy at birth, total (years)' AND 
	health_dim.series_name='Domestic general government health expenditure (% of current health expenditure)'

	
GROUP BY
	population_dim.country_name,
	population_dim.yr_2010,
	health_dim.yr_2010;

-- c2) Dice contrasting the literacy rate and development index in 2013 for Mexico vs Thailand
SELECT 
	education_dim.country_name,
	education_dim.yr_2013 AS literacy_rate,
	index_dev.yr_2013 AS Development_index
FROM 
	education_dim INNER JOIN index_dev 
	ON education_dim.country_code=index_dev.countrycode
WHERE 
	(education_dim.country_code = 'MEX' OR education_dim.country_code='THA') AND
	education_dim.series_name='Adult literacy rate, population 15+ years, both sexes (%)' 
	
GROUP BY
	education_dim.country_name,
	education_dim.yr_2013,
	index_dev.yr_2013;

--d Combining OLAP operations (4 queries)
-- For instance, we may explore the data characteristics 
--i) during different time periods, 
SELECT 
	country_name,
	series_name,
	yr_2013, yr_2014, yr_2015,yr_2016,yr_2017,yr_2018
FROM 
	population_dim 
--INNER JOIN country USING (countrycode) 
WHERE 

	series_name='Life expectancy at birth, total (years)'
GROUP BY
	country_name, series_name,
	yr_2013, yr_2014, yr_2015,yr_2016,yr_2017,yr_2018;


--iii) for different countries and regions/continents, 
SELECT 
	country.continent,
	series_name,
	AVG (yr_2015)
FROM 
	country INNER JOIN qol_index ON country.countrycode=qol_index.countrycode

GROUP BY
	continent,
	ROLLUP(series_name)
	
ORDER BY
	continent;

