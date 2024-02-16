--9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
--Give their full name and the teams that they were managing when they won the award. 
--namefirst, namelast, teamid, awardid, lgid,
--AND managers.lgid = ('NL', 'AL')

SELECT namefirst, namelast, teamid, managers.yearid, awardid, managers.lgid
FROM people INNER JOIN awardsmanagers USING(playerid)
			INNER JOIN salaries USING(playerid)
			INNER JOIN managers USING(teamid)
WHERE awardsmanagers.awardid ILIKE 'TSN%' AND managers.lgid IN ('NL', 'AL')
ORDER BY people.namefirst;

----------------------------------------------------------------------------------				
SELECT p.namefirst, p.namelast
FROM people AS p
JOIN
	(SELECT m.yearid, m.lgid, m.teamid
	FROM managers AS m
	WHERE m.lgid IN ('NL', 'AL')
	GROUP BY m.yearid, m.lgid, m.teamid) AS dual_winner ON p.playerid = am.playerid
JOIN
	(SELECT am.awardid, am.playerid
	FROM awardsmanagers AS am
	WHERE am.awardid ILIKE 'TSN%'
	GROUP BY am.awardid) AS tsn_award ON aw.yearid = m.yearid
ORDER BY m.yearid
---------------------------------------------------------------------------------


select namefirst, namelast, a.yearid, m.teamid, a.lgid
					 from managers as m join awardsmanagers as a
					 using(yearid)join people as p
					  on a.playerid = p.playerid
					 where a.lgid in ('NL','AL')
					 and awardid = 'TSN Manager of the Year'


