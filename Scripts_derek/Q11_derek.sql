--11. Is there any correlation between number of wins and team salary? 
--Use data from 2000 and later to answer this question. 
--As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.


SELECT SUM(salary) AS salary, SUM(w) AS win_games, m.yearid
FROM managers AS m INNER JOIN salaries AS s USING (playerid)
WHERE m.yearid >= 2000
GROUP BY m.yearid
ORDER BY salary DESC;


SELECT *
FROM managers AS m INNER JOIN salaries AS s USING (playerid)