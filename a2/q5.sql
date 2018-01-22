-- Committed

SET SEARCH_PATH TO parlgov;
drop table if exists q5 cascade;

-- You must not change this table definition.

CREATE TABLE q5(
        countryName VARCHAR(50),
        partyName VARCHAR(100),
        partyFamily VARCHAR(50),
        stateMarket REAL
);

-- You may find it convenient to do this for each of the views
-- that define your intermediate steps.  (But give them better names!)
DROP VIEW IF EXISTS intermediate_step CASCADE;

-- Define views for your intermediate steps here.
CREATE VIEW all_cb AS
	SELECT  p.id as party_id, cb.id as cabinet_id
	FROM cabinet cb, party p
	WHERE p.country_id = cb.country_id and extract (year from start_date) >= 1996
	ORDER BY p.id, cb.id;

CREATE VIEW we_have AS
	SELECT party_id, cabinet_id
	FROM cabinet cb, cabinet_party cp
	WHERE cb.id = cp.cabinet_id and extract (year from start_date) >= 1996
	ORDER BY country_id, party_id, cabinet_id;

CREATE VIEW commited_party AS
	SELECT  party_id
	FROM ((SELECT * FROM we_have) EXCEPT (SELECT * FROM all_cb)) temp;

CREATE VIEW partyName_and_countryName AS
	SELECT party_id, p.name as partyName, c.name as countryName
	FROM  commited_party cp, party p, country c
	WHERE cp.party_id = p.id and p.country_id = c.id;

CREATE VIEW near_result AS
	SELECT pc.party_id, countryName, partyName, family as partyFamily
	FROM partyName_and_countryName pc LEFT JOIN party_family p ON pc.party_id = p.party_id;

-- the answer to the query 
insert into q5 
	SELECT countryName, partyName, partyFamily, state_market
	FROM near_result n LEFT JOIN party_position p ON n.party_id = p.party_id;
