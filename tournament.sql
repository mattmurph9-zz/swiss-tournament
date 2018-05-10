-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament;

\c tournament

CREATE TABLE players(
	pid integer PRIMARY KEY,
	name text
	);

CREATE TABLE matches(
	winner integer references players(pid),
	loser integer references players(pid),
	);

CREATE VIEW rankings AS
SELECT pid, name, SUM(CASE WHEN pid = winner THEN 1 ELSE 0 END) AS wins, SUM(CASE WHEN pid = winner OR pid = loser THEN 1 ELSE 0 END) AS games
FROM players LEFT JOIN matches ON players.pid = matches.winner or players.pid = matches.loser
GROUP BY pid
ORDER BY wins DESC;
