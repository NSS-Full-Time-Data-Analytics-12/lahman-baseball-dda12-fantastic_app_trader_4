--8. Using the attendance figures from the homegames table, 
--find the teams and parks which had the top 5 average attendance per game in 2016 
--(where average attendance is defined as total attendance divided by number of games). 
--Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

SELECT team, park_name, attendance/SUM(games) AS avg_attend
FROM homegames INNER JOIN parks USING(park)
WHERE year = '2016'
GROUP BY team, park_name, attendance
ORDER BY avg_attend DESC;


SELECT team, park_name, attendance/SUM(games) AS avg_attend
FROM homegames INNER JOIN parks USING(park)
WHERE year = '2016' AND games > 10
GROUP BY team, park_name, attendance
ORDER BY avg_attend DESC
LIMIT 5;


SELECT team, park_name, attendance/SUM(games) AS avg_attend
FROM homegames INNER JOIN parks USING(park)
WHERE year = '2016' AND games > 10
GROUP BY team, park_name, attendance
ORDER BY avg_attend ASC
LIMIT 5;




