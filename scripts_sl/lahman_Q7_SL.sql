--Q7SL.  From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
--What is the smallest number of wins for a team that did win the world series? 
--Doing this will probably result in an unusually small number of wins for a world series 
--champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 
--1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

SELECT yearid,teamid,w,wswin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND wswin = 'N'
ORDER BY w DESC;

SELECT yearid,teamid,w,wswin
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND wswin = 'Y' AND yearid <> 1981
ORDER BY w ASC;

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

