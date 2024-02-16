--5. Find the average number of strikeouts per game by decade since 1920. 
--Round the numbers you report to 2 decimal places. 
--Do the same for home runs per game. 
--Do you see any trends?


SELECT teamid, g ,yearid/10*10 AS decades, ROUND(AVG(so)/g,2) AS avg_strikeouts_per_game
FROM teams
WHERE yearid BETWEEN 1920 AND 2023
GROUP BY teamid, g, yearid
ORDER BY yearid ASC;


SELECT teamid, g ,yearid/10*10 AS decades, ROUND(AVG(hr)/g,2) AS avg_homeruns_per_game
FROM teams
WHERE yearid BETWEEN 1920 AND 2023
GROUP BY teamid, g, yearid
ORDER BY yearid ASC;



