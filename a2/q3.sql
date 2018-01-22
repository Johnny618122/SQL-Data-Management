-- Participate

SET SEARCH_PATH TO parlgov;
drop table if exists q3 cascade;

-- You must not change this table definition.

create table q3(
        countryName varchar(50),
        year int,
        participationRatio real
);

-- You may find it convenient to do this for each of the views
-- that define your intermediate steps.  (But give them better names!)
DROP VIEW IF EXISTS intermediate_step CASCADE;

-- Define views for your intermediate steps here.
CREATE VIEW valid_country AS
	SELECT c.id, extract(year from e_date) as year
	FROM country c, election e
	WHERE c.id = e.country_id
	GROUP BY c.id, extract(year from e_date)
	HAVING extract(year from e_date) <= 2016 and extract(year from e_date) >= 2001;

CREATE VIEW near_result AS
	SELECT v.id, v.year, cast(avg(votes_cast) as float) / cast(avg(electorate) as float) as participationRatio
	FROM valid_country v, election e
	WHERE v.id = e.country_id and v.year = extract(year from e.e_date)
	GROUP BY v.id, v.year;

-- the answer to the query 
insert into q3 
SELECT name as countryName, year, participationRatio
FROM near_result, country
WHERE near_result.id = country.id;

