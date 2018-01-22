-- Winners

SET SEARCH_PATH TO parlgov;
drop table if exists q2 cascade;

-- You must not change this table definition.

create table q2(
countryName VARCHaR(100),
partyName VARCHaR(100),
partyFamily VARCHaR(100),
wonElections INT,
mostRecentlyWonElectionId INT,
mostRecentlyWonElectionYear INT
);


-- You may find it convenient to do this for each of the views
-- that define your intermediate steps.  (But give them better names!)
DROP VIEW IF EXISTS intermediate_step CASCADE;

-- Define views for your intermediate steps here.
CREATE VIEW average AS
SELECT country_id, cast(total_elections as float) / cast(total_parties as float) average
FROM
	(SELECT country_id, count(*) as total_elections
	FROM election 
	GROUP BY country_id) te NATURAL JOIN
	(SELECT country_id, count(*) as total_parties
	from party 
group by country_id) tp;

CREATE VIEW winners AS
SELECT er.election_id, er.party_id, e_date
FROM (SELECT election_id, MAX(votes) as votes
	  FROM election_result
	  GROUP BY election_id) temp, election_result er, election
WHERE temp.election_id = er.election_id = election_id and temp.votes = er.votes;

CREATE VIEW winners3 AS
SELECT party_id, count(*), MAX(e_date)
FROM winners, average, party
WHERE winners.party_id = party.id and party.country_id = average.country_id
GROUP BY party_id
HAVING count(*) >= 3 * avg(average);

SELECT er.party_id, er.election_id, date
FROM (SELECT winners3.party_id, max(e_date) as date
	FROM election, winners3, election_result
	WHERE election.id = election_result.election_id and winners3.party_id = election_result.party_id
	GROUP BY winners3.party_id) temp, election_result er, election e
WHERE temp.party_id = er.party_id and er.election_id = e.id and date = e_date;

-- the answer to the query 
insert into q2 


