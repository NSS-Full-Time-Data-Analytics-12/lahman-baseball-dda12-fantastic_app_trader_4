--10. Find all players who hit their career highest number of home runs in 2016. Consider only players 
--who have played in the league for at least 10 years, and who hit at least one home run in 2016. 
--Report the players' first and last names and the number of home runs they hit in 2016.

WITH player_names AS (SELECT playerid, namefirst AS first_name, namelast AS last_name, debut, MAX(hr)
					  FROM people
					  INNER JOIN batting
                      USING (playerid)
					  WHERE debut <= '2006-01-01'
					  GROUP BY playerid, first_name, last_name)
SELECT first_name, last_name, hr AS homerun, yearid
FROM batting
INNER JOIN player_names
USING (playerid)
WHERE batting.yearid = 2016 AND hr >=1 AND hr = MAX
ORDER BY homerun DESC;
