CREATE TABLE health_raw
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

COPY health_raw
FROM 'C:\Users\ofbac\OneDrive\Desktop\CSI4142_project_WHB-main\spreadsheets\raw_data_healthDimension.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM health_raw;