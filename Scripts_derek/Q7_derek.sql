--7. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?

--What is the smallest number of wins for a team that did win the world series?

--Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. 

--Then redo your query, excluding the problem year. 
--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
--What percentage of the time?


--2001 Seattle Mariners 166 Wins w/o WS
SELECT yearid, name, W, L, WSWin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND WSWin = 'N'
ORDER BY W DESC;


--1981 Los Angeles Dodgers 63 Wins w/ WS
SELECT yearid, name, W, L, WSWin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND WSWin = 'Y'
ORDER BY W ASC;
--The 1981 Baseball Players Strike caused a strike-shortened season. Teams played between 102 to 110 games
--since games were canceled from June 12th to August 10th and not made up to even out the schedule.

--The number of teams who had the most wins and won the World Series
SELECT t.yearid, t.name, t.W, t.L, t.WSWin
FROM teams AS t
JOIN
    (SELECT yearid, MAX(W) AS MaxWins
     FROM teams
     WHERE yearid BETWEEN 1970 AND 2016
     GROUP BY yearid) AS max_wins ON t.yearid = max_wins.yearid AND t.W = max_wins.MaxWins
JOIN
    (SELECT yearid, teamid
     FROM teams
     WHERE yearid BETWEEN 1970 AND 2016 AND WSWin = 'Y') AS ws_winners ON t.yearid = ws_winners.yearid AND t.teamid = ws_winners.teamid
ORDER BY t.yearid;
--12 Teams

----------------------------------
WITH MaxWinsAndWSWinners AS (SELECT t.yearid, t.teamid, t.name, t.W, t.L, t.WSWin
    						 FROM teams t
JOIN (SELECT yearid, MAX(W) AS MaxWins
      FROM teams
      WHERE yearid BETWEEN 1970 AND 2016
      GROUP BY yearid) max_wins ON t.yearid = max_wins.yearid AND t.W = max_wins.MaxWins
    JOIN (SELECT yearid, teamid
          FROM teams
          WHERE yearid BETWEEN 1970 AND 2016 AND WSWin = 'Y') ws_winners ON t.yearid = ws_winners.yearid AND t.teamid = ws_winners.teamid)
SELECT 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM MaxWinsAndWSWinners) AS Percentage
FROM MaxWinsAndWSWinners;
---------100%?





















