
----Part 2. Explorative operation
--a) Iceberg queries
--For instance i) Find the five years with the highest population growths.

SELECT t.year, t.AvgChange, RANK () OVER (ORDER BY t.avgchange DESC) ranking
	FROM
	(SELECT UNNEST(array['2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019']) AS "year",
		UNNEST(array[AVG(g.growth_05_06), AVG(g.growth_06_07), AVG(g.growth_07_08), AVG(g.growth_08_09), 
					 AVG(g.growth_09_10), AVG(g.growth_10_11), AVG(g.growth_11_12), AVG(g.growth_12_13), 
					 AVG(g.growth_13_14), AVG(g.growth_14_15), AVG(g.growth_15_16), AVG(g.growth_16_17),
					 AVG(g.growth_17_18), AVG(g.growth_18_19), AVG(g.growth_19_20)]) AS "avgchange"
		FROM 
			(SELECT c.countryname, 
				c.yr_2006 - c.yr_2005 as growth_05_06,
				c.yr_2007 - c.yr_2006 as growth_06_07,
				c.yr_2008 - c.yr_2007 as growth_07_08,
				c.yr_2009 - c.yr_2008 as growth_08_09,
				c.yr_2010 - c.yr_2009 as growth_09_10,
				c.yr_2011 - c.yr_2010 as growth_10_11,
				c.yr_2012 - c.yr_2011 as growth_11_12,
				c.yr_2013 - c.yr_2012 as growth_12_13,
				c.yr_2014 - c.yr_2013 as growth_13_14,
				c.yr_2015 - c.yr_2014 as growth_14_15,
				c.yr_2016 - c.yr_2015 as growth_15_16,
				c.yr_2017 - c.yr_2016 as growth_16_17,
				c.yr_2018 - c.yr_2017 as growth_17_18,
				c.yr_2019 - c.yr_2018 as growth_18_19,
				c.yr_2020 - c.yr_2019 as growth_19_20
			FROM country c
			where series_name='Population, total') g) t
	LIMIT 5;


--b)
SELECT a.country_name, a.avglit, 
	rank() OVER (ORDER BY avglit DESC) FROM
	(SELECT e.country_name, AVG(CAST (e.yr_2015 AS decimal) + CAST (e.yr_2016 AS decimal)+ CAST (e.yr_2016 AS decimal) + CAST (e.yr_2017 AS decimal) + CAST (e.yr_2018 AS decimal) + CAST (e.yr_2019 AS decimal)
		+ CAST (e.yr_2020 AS decimal))/5 AS avglit from education_dim e
	where e.series_name LIKE '%' || 'Adult literacy rate' || '%' || 'male' || '%'
	GROUP BY e.country_name) a