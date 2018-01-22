-- Left-right

SET SEARCH_PATH TO parlgov;
drop table if exists q4 cascade;

-- You must not change this table definition.


CREATE TABLE q4(
        countryName VARCHAR(50),
        r0_2 INT,
        r2_4 INT,
        r4_6 INT,
        r6_8 INT,
        r8_10 INT
);

-- You may find it convenient to do this for each of the views
-- that define your intermediate steps.  (But give them better names!)
DROP VIEW IF EXISTS intermediate_step CASCADE;

-- Define views for your intermediate steps here.
CREATE VIEW party_lr AS
SELECT party.id, country_id, left_right
FROM party, party_position
WHERE party.id = party_position.party_id;

CREATE VIEW lr_0to2 AS
SELECT country_id, count(*) as r0_2 
FROM party_lr
WHERE left_right >= 0 and left_right <2
GROUP BY country_id;

CREATE VIEW all_lr_0to2 AS
SELECT country.name as countryName, coalesce(r0_2, 0) as r0_2
FROM lr_0to2 right join country on country_id = country.id;

CREATE VIEW lr_2to4 AS
SELECT country_id, count(*) as r2_4
FROM party_lr
WHERE left_right >= 2 and left_right <4
GROUP BY country_id;

CREATE VIEW all_lr_2to4 AS
SELECT country.name as countryName, coalesce(r2_4, 0) as r2_4
FROM lr_2to4 right join country on country_id = country.id;

CREATE VIEW lr_4to6 AS
SELECT country_id, count(*) as r4_6
FROM party_lr
WHERE left_right >= 4 and left_right <6
GROUP BY country_id;

CREATE VIEW all_lr_4to6 AS
SELECT country.name as countryName, coalesce(r4_6, 0) as r4_6
FROM lr_4to6 right join country on country_id = country.id;

CREATE VIEW lr_6to8 AS
SELECT country_id, count(*) as r6_8
FROM party_lr
WHERE left_right >= 6 and left_right <8
GROUP BY country_id;

CREATE VIEW all_lr_6to8 AS
SELECT country.name as countryName, coalesce(r6_8, 0) as r6_8
FROM lr_6to8 right join country on country_id = country.id;

CREATE VIEW lr_8to10 AS
SELECT country_id, count(*) as r8_10
FROM party_lr
WHERE left_right >= 8 and left_right <10
GROUP BY country_id;

CREATE VIEW all_lr_8to10 AS
SELECT country.name as countryName, coalesce(r8_10, 0) as r8_10
FROM lr_8to10 right join country on country_id = country.id;

-- the answer to the query 
INSERT INTO q4
SELECT all_lr_0to2.countryName as countryName, r0_2, r2_4, r4_6, r6_8, r8_10
FROM all_lr_0to2 NATURAL JOIN all_lr_2to4 NATURAL JOIN all_lr_4to6 NATURAL JOIN all_lr_6to8 NATURAL JOIN all_lr_8to10;