--3. Find all players in the database who played at Vanderbilt University. 
--A. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
--B. Sort this list in descending order by the total salary earned. 
--C. Which Vanderbilt player earned the most money in the majors?

--A.
SELECT schoolname, *
FROM people INNER JOIN collegeplaying USING(playerid)
			INNER JOIN schools USING(schoolid)
WHERE schoolname ILIKE '%Vanderbilt University%'
ORDER BY schoolname;

--B.
SELECT namefirst, namelast, schoolname, SUM(salary)AS total_salary_earned
FROM people LEFT JOIN collegeplaying USING (playerid)
            LEFT JOIN schools USING (schoolid)
			LEFT JOIN salaries USING (playerid)
WHERE schoolname = 'Vanderbilt University'AND salary IS NOT NULL
GROUP BY namefirst, namelast, schoolname
ORDER BY total_salary_earned DESC;

--C.
SELECT namefirst, namelast, schoolname, SUM(salary)AS total_salary_earned
FROM people LEFT JOIN collegeplaying USING (playerid)
            LEFT JOIN schools USING (schoolid)
			LEFT JOIN salaries USING (playerid)
WHERE schoolname = 'Vanderbilt University'AND salary IS NOT NULL
GROUP BY namefirst, namelast, schoolname
ORDER BY total_salary_earned DESC
LIMIT 1;