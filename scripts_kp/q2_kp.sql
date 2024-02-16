--2. Find the name and height of the shortest player in the database. How many games did he play in? 
--What is the name of the team for which he played?


SELECT playerid,(namefirst||' ' ||namelast )as player_name, height,teamid,sum(g_all)
FROM people
FULL JOIN appearances USING (playerid)
group by playerid,height,teamid,player_name
ORDER BY people.height
LIMIT(1)

SELECT playerid,(namefirst||' ' ||namelast )as player_name, name,height,teamid,sum(g_all)
FROM people
 JOIN appearances USING (playerid)
 join teams using (teamid,yearid)
group by playerid,height,teamid,player_name,name
ORDER BY people.height
LIMIT(1)