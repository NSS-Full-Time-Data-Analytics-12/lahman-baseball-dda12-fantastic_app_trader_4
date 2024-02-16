--Q9SL. Which managers have won the TSN Manager of the Year award in both the National League (NL)
--and the American League (AL)? Give their full name and the teams that they were managing when they won the award.

WITH nameawards AS(SELECT people.namefirst, people.namelast, managers.teamid, awardsmanagers.yearid, awardsmanagers.awardid,managers.lgid 
FROM awardsmanagers INNER JOIN people USING (playerid)
                    INNER JOIN managers USING (playerid)
WHERE awardsmanagers.awardid = 'TSN Manager of the Year')

SELECT a.namefirst, a.namelast, a.teamid, a.yearid, a.awardid, a.lgid, b.lgid
FROM nameawards AS a INNER JOIN nameawards AS b USING (namefirst)
WHERE a.lgid IN('AL','NL')AND b.lgid IN ('AL','NL')AND a.lgid <> b.lgid
GROUP BY a.namefirst, a.namelast, a.teamid, a.yearid,a.awardid, a.lgid, b.lgid
ORDER BY a.yearid

--THIS IS WHAT THE ANSWER SHOULD BE --La Russa, Piniella, Showalter, Jim Leyland, Bob Melvin, Davey Johnson, and Joe Maddon
