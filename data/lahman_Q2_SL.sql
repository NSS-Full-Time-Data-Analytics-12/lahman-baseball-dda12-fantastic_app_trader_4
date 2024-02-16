--Q2SL. Find the name and height of the shortest player in the database.
--How many games did he play in? What is the name of the team for which he played?
SELECT namefirst, namelast, height,appearances.teamid, appearances.g_all
FROM people FULL JOIN managershalf USING(playerid)
FULL JOIN teams USING (teamid)
FULL JOIN appearances USING (playerid)
ORDER BY height ASC;

