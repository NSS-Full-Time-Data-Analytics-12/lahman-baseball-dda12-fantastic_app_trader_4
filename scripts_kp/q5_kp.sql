--5. Find the average number of strikeouts per game by decade since 1920.
--Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?


  
SELECT g, yearid/10*10 AS decades,ROUND(AVG(so),2)AS avg_strikouts_per_game
  FROM teams
 WHERE yearid BETWEEN 1920 AND 2023
 GROUP BY g, yearid/10*10
 ORDER BY 1, 2;


SELECT teamid,g,yearid/10*10 AS decades,ROUND(AVG(hr)/g,2)AS avg_homeruns_per_game
FROM teams
WHERE yearid BETWEEN 1920 AND 2023
GROUP BY teamid, g,yearid
ORDER BY yearid ASC;

