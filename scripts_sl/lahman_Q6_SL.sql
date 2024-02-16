--Q6SL. Find the player who had the most success stealing bases in 2016, where __success__ is measured as 
--the percentage of stolen base attempts which are successful. (A stolen base attempt results either in 
--a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.

SELECT namefirst, namelast, batting.yearid,SUM(sb) + SUM(cs)AS total_stolen_bases  
FROM people INNER JOIN batting USING (playerid)          
WHERE batting.yearid = 2016 AND sb >= 20 
GROUP BY namefirst, namelast, batting.yearid,sb
ORDER BY sb DESC;


