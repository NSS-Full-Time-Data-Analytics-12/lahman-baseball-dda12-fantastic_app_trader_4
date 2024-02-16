--Q4SL. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", 
--those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery".
--Determine the number of putouts made by each of these three groups in 2016.
SELECT namefirst, namelast,yearid,SUM(po)AS num_putouts,CASE WHEN pos = 'OF' THEN 'Outfield'
              WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
			  WHEN pos IN ('P','C') THEN 'Battery'END AS full_position 
FROM fielding INNER JOIN people USING(playerid)
WHERE yearid = 2016
GROUP BY namefirst, namelast,yearid,pos,po, full_position;
