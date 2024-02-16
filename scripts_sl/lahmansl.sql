--Q1SL. What range of years for baseball games played does the provided database cover? 
SELECT MIN(year),MAX(year)
FROM homegames;
--Q2SL. Find the name and height of the shortest player in the database.
--How many games did he play in? What is the name of the team for which he played?
SELECT namefirst, namelast, height,appearances.teamid, appearances.g_all
FROM people FULL JOIN managershalf USING(playerid)
FULL JOIN teams USING (teamid)
FULL JOIN appearances USING (playerid)
ORDER BY height ASC;

--Q3SL. Find all players in the database who played at Vanderbilt University. 
--Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
--Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
SELECT namefirst, namelast, schoolname, SUM(salary)AS total_salary_earned
FROM people LEFT JOIN collegeplaying USING (playerid)
            LEFT JOIN schools USING (schoolid)
			LEFT JOIN salaries USING (playerid)
WHERE schoolname = 'Vanderbilt University'AND salary IS NOT NULL
GROUP BY namefirst, namelast, schoolname
ORDER BY total_salary_earned DESC; 

--Q4SL. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", 
--those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery".
--Determine the number of putouts made by each of these three groups in 2016.
SELECT namefirst, namelast,yearid,SUM(po)AS num_putouts,CASE WHEN pos = 'OF' THEN 'Outfield'
              WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
			  WHEN pos IN ('P','C') THEN 'Battery'END AS full_position 
FROM fielding INNER JOIN people USING(playerid)
WHERE yearid = 2016
GROUP BY namefirst, namelast,yearid,pos,po, full_position;

--Q5SL. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places.
--Do the same for home runs per game. Do you see any trends?

SELECT teamid,g,yearid/10*10 AS decades,ROUND(AVG(so)/g,2)AS avg_strikouts_per_game
FROM teams
WHERE yearid BETWEEN 1920 AND 2023
GROUP BY teamid,g,yearid
ORDER BY yearid ASC;

SELECT teamid,g,yearid/10*10 AS decades,ROUND(AVG(hr)/g,2)AS avg_homeruns_per_game
FROM teams 
WHERE yearid BETWEEN 1920 AND 2023
GROUP BY teamid, g,yearid
ORDER BY yearid ASC;

--Q6SL. Find the player who had the most success stealing bases in 2016, where __success__ is measured as 
--the percentage of stolen base attempts which are successful. (A stolen base attempt results either in 
--a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.

SELECT namefirst, namelast, batting.yearid,SUM(sb) + SUM(cs)AS total_stolen_bases  
FROM people INNER JOIN batting USING (playerid)          
WHERE batting.yearid = 2016 AND sb >= 20 
GROUP BY namefirst, namelast, batting.yearid,sb
ORDER BY sb DESC;


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

--Q8SL. Using the attendance figures from the homegames table, find the teams and parks which had the top 
--5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by 
--number of games). Only consider parks where there were at least 10 games played. Report the park name, 
--team name, and average attendance. Repeat for the lowest 5 average attendance.

SELECT park_name ,team, ROUND(AVG(attendance)/games,2)AS avg_attendance_per_game
FROM homegames INNER JOIN parks USING (park)
WHERE year = 2016 AND games >= 10
GROUP BY park_name ,team, games
ORDER BY avg_attendance_per_game DESC
LIMIT 5;

SELECT park_name ,team, ROUND(AVG(attendance)/games,2)AS avg_attendance_per_game
FROM homegames INNER JOIN parks USING (park)
WHERE year = 2016 AND games >= 10
GROUP BY park_name ,team, games
ORDER BY avg_attendance_per_game ASC
LIMIT 5;

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

--Q.11
select m.teamid, m.yearid , sum(salary)as salary, sum(w) as win_games, sum(g) total_played, round((sum(w)*100)/sum(g),2) win_percentage
from managers as m join salaries as s
                 using (playerid)
where m.yearid >= 2000
group by m.teamid, m.yearid
order by m.teamid, m.yearid;


--Q12SL. In this question, you will explore the connection between number of wins and attendance.
    --<ol type="a">
     -- <li>Does there appear to be any correlation between attendance at home games and number of wins? </li>
     -- <li>Do teams that win the world series see a boost in attendance the following year? What about teams
	 --that made the playoffs? Making the playoffs means either being a division winner or a wild card winner.</li>
   -- </ol>
SELECT CORR(homegames.attendance,w)AS corr_attend
FROM teams INNER JOIN homegames ON teamid = team AND yearid =year
WHERE homegames IS NOT NULL;

SELECT teams.w,h.year, h.team,ROUND(AVG( h.attendance),2)AS avg_attendance, h2.year, h2.team,ROUND(AVG( h2.attendance),2)AS next_year_avg_attendance
FROM teams INNER JOIN homegames AS h ON teams.yearid = h.year AND teams.teamid = h.team	
           INNER JOIN homegames AS h2 ON teams.yearid + 1  = h2.year AND teams.teamid = h2.team
WHERE wswin = 'Y' AND h.attendance <> 0			
GROUP BY h.year, h.team, teams.w , teams.yearid,h2.year, h2.team
ORDER BY h.year;
	  	  
SELECT teams.w,h.year, h.team,ROUND(AVG(h.attendance),2)AS avg_attendance, h2.year, h2.team,ROUND(AVG( h2.attendance),2)AS next_year_avg_attendance                            
FROM teams INNER JOIN homegames AS h ON teams.yearid = h.year AND teams.teamid = h.team
           INNER JOIN homegames AS h2 ON teams.yearid + 1  = h2.year AND teams.teamid = h2.team
WHERE divwin = 'Y' OR wcwin = 'Y' AND h.attendance <> 0		
GROUP BY h.year, h.team, teams.w, teams.yearid,h2.year, h2.team
ORDER BY h.team;

				   


					
              













