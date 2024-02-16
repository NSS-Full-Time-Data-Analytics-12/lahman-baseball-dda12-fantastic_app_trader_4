--2. A. Find the name and height of the shortest player in the database. 
--B. How many games did he play in? 
--C. What is the name of the team for which he played?


SELECT MIN(height) AS shortest, namefirst, namelast
FROM people
GROUP BY namefirst, namelast
ORDER BY shortest
LIMIT 1;

--A. Eddie Gaedel ^

SELECT *
FROM people
FULL JOIN appearances USING (playerid)
ORDER BY people.height
LIMIT(1);

-----B. and C. Answer^
--one game played pitch hitting, played for SLA


--------random queries below trying to figure out the answer
SELECT teamid, namefirst, namelast
FROM people INNER JOIN appearances USING(playerid)
WHERE height = (SELECT MIN(height)
			   	FROM people)
GROUP BY teamid, namefirst, namelast;



SELECT teams.g, namefirst, namelast
FROM people INNER JOIN managershalf USING(playerid)
			INNER JOIN teams USING(teamid)
GROUP BY teams.g, namefirst, namelast
ORDER BY teams.g DESC;


---test
SELECT height, teams.g, appearances.teamid, appearances.g_all, appearances.g_ph, namefirst, namelast
FROM people LEFT JOIN managershalf USING(playerid)
			LEFT JOIN teams USING(teamid)
			LEFT JOIN appearances USING(playerid)
GROUP BY height, teams.g, appearances.teamid, appearances.g_all, appearances.g_ph, namefirst, namelast
ORDER BY height