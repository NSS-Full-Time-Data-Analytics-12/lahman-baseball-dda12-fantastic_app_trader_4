--6. Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. 
--(A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.



SELECT namefirst, namelast, b.yearid, sb, cs, (sb + cs) total_stealing_attempt
  FROM people as p INNER JOIN batting as b 
                        USING (playerid)
 WHERE b.yearid = 2016 
   AND (sb + cs) >= 20
 --GROUP BY namefirst, namelast, b.yearid,sb
 ORDER BY total_stealing_attempt DESC;

