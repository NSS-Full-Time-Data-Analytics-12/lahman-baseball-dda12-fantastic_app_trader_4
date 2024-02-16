-- What range of years for baseball games played does the provided database cover? Answer: This database covers from year 1871 to year 2016.

SELECT MIN(year) AS min_year, MAX(year) AS max_year
FROM homegames;

-- Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?

SELECT *
FROM people 
FULL JOIN appearances USING (playerid)
ORDER BY people.height
LIMIT(1);

--Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?

SELECT schoolname, namefirst,namelast, SUM(salary) AS sum_salary
FROM people
FULL JOIN collegeplaying USING (playerid)
FULL JOIN schools USING (schoolid)
FULL JOIN salaries USING (playerid)
WHERE schoolname = 'Vanderbilt University' AND salary IS NOT NULL
GROUP BY schoolname,namefirst,namelast
ORDER BY sum_salary DESC; 

-- Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.

SELECT namefirst,namelast,po,
CASE WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
	 WHEN pos IN ('OF') THEN 'Outfield'
	 ELSE 'Battery' END AS position
FROM fielding
FULL JOIN people USING (playerid)
WHERE yearid = '2016' AND pos IS NOT NULL
GROUP BY position, namefirst,namelast,po
ORDER BY position NULLS FIRST;

--Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?

SELECT ROUND(AVG(so),2)/SUM(g) as avg_strikeout_per_game, ROUND(AVG(HR),2)/SUM(g) AS home_runs, (yearid/10)*10 AS decade
FROM batting
WHERE yearid >= 1920
GROUP BY yearid
HAVING yearid = (yearid/10)*10
ORDER BY yearid;

--Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
WITH table_a AS (SELECT playerid, (SUM(sb)+SUM(cs)) AS base_steal_attempts,sb
FROM batting
WHERE yearid = '2016'
GROUP BY playerid,sb
HAVING (SUM(sb)+SUM(cs)) >= 20
ORDER BY base_steal_attempts DESC)

SELECT playerid, base_steal_attempts, (SUM(sb))/(base_steal_attempts)*100 AS percent_success_sb
FROM table_a
GROUP BY playerid,base_steal_attempts,
ORDER BY base_steal_attempts DESC;

-- From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case (Due to player strike). Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

SELECT w, teamid, yearid,wswin
FROM teams
WHERE wswin = 'N' AND yearid BETWEEN '1970' AND '2016'
ORDER BY w DESC;

SELECT w, teamid, yearid,wswin
FROM teams
WHERE wswin = 'Y' AND yearid BETWEEN '1970' AND '2016' AND yearid <> 1981
ORDER BY w;

SELECT  t.yearid, MAX(t.W), r.teamid,r.wswin
FROM teams AS t
INNER JOIN teams AS r USING(teamid)
WHERE t.yearid BETWEEN '1970' AND '2016'
GROUP BY t.yearid
ORDER BY t.yearid



--Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

SELECT SUM(attendance)/SUM(games) as avg_attendance, park,games,team
FROM homegames
WHERE year = 2016
GROUP by park,team,games
HAVING games >= 10
ORDER BY avg_attendance DESC
LIMIT(5);

SELECT SUM(attendance)/SUM(games) as avg_attendance, park,games,team
FROM homegames
WHERE year = 2016
GROUP by park,team,games
HAVING games >= 10
ORDER BY avg_attendance 
LIMIT(5);

--Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.

SELECT a.playerid,a.awardid,a.yearid,a.lgid,b.lgid,namefirst,namelast,teamid
FROM awardsmanagers AS a
INNER JOIN awardsmanagers AS b USING (playerid)
LEFT JOIN people USING (playerid)
FULL JOIN managershalf USING (playerid)
WHERE a.awardid = 'TSN Manager of the Year' AND a.lgid IN ('AL','NL') AND b.lgid IN ('NL','AL') AND a.lgid <> b.lgid
GROUP BY a.playerid,a.awardid,a.yearid,a.lgid,b.lgid,namefirst,namelast,teamid;

--It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. Investigate this claim and present evidence to either support or dispute this claim. First, determine just how rare left-handed pitchers are compared with right-handed pitchers. Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?

SELECT COUNT(*) AS lefty_count
FROM pitching
FULL JOIN people USING (playerid)
WHERE throws = 'L';

SELECT COUNT(*) AS righty_count
FROM pitching
FULL JOIN people USING (playerid)
WHERE throws = 'R';

--The count for left handed pitchers is 13,677 and 39999 for right handed pitchers. Therefore, the percent of left handed pitchers in the data set is 13,677/(39999+13,677)*100 = 25.48%


WITH a AS(SELECT DISTINCT (playerid), bfp, yearid,throws
FROM (SELECT playerid
			  FROM people
			  WHERE throws = 'L')
INNER JOIN pitching USING (playerid)
INNER JOIN people USING (playerid)
WHERE bfp IS NOT NULL
GROUP BY  (playerid), bfp, yearid,throws),

	b AS (SELECT DISTINCT (playerid),bfp, yearid,throws
FROM (SELECT playerid
			  FROM people
			  WHERE throws = 'R')
INNER JOIN pitching USING (playerid)
INNER JOIN people USING (playerid)
WHERE bfp IS NOT NULL
GROUP BY  (playerid), bfp, yearid,throws)

SELECT *
FROM a
INNER JOIN b USING(playerid);

----It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. Investigate this claim and present evidence to either support or dispute this claim. First, determine just how rare left-handed pitchers are compared with right-handed pitchers. Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?

WITH a AS (SELECT playerid, bfp, throws
FROM pitching
INNER JOIN people USING(playerid)),

b AS(SELECT playerid, bfp, throws
FROM pitching
INNER JOIN people USING(playerid)
WHERE throws = 'L'),

c AS (SELECT playerid, bfp, throws
FROM pitching
INNER JOIN people USING(playerid)
WHERE throws = 'R')

SELECT *
FROM pitching
INNER JOIN b USING (playerid)
INNER JOIN c USING (playerid)


