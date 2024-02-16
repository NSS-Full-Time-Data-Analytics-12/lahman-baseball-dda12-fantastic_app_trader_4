--6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. 
--(A stolen base attempt results either in a stolen base or being caught stealing.) 
--Consider only players who attempted _at least_ 20 stolen bases.


SELECT batting.yearid, namefirst, namelast, batting.sb + batting.cs AS sb_attempts
FROM people INNER JOIN batting USING(playerid)
WHERE batting.yearid = '2016' AND batting.sb + batting.cs > 20
GROUP BY batting.yearid, namefirst, namelast, batting.sb, batting.cs
ORDER BY sb DESC;

--did not get precentage yet
