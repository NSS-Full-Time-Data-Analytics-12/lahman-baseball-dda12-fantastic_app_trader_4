--4. Using the fielding table, group players into *three groups* based on their position: 
--label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
--and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.

SELECT pos, yearid,
		CASE WHEN pos IN ('OF') THEN 'Outfield'
			 WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
			 ELSE 'Battery' END AS position
			 
FROM fielding
WHERE yearid = '2016'
ORDER BY position;

--------------------------------------------------------------------------------------------------------
SELECT *
FROM fielding

--Outfield 2016--354 Outfield
SELECT pos, yearid,
		CASE WHEN pos IN ('OF') THEN 'Outfield'
			 END AS position
			 
FROM fielding
WHERE yearid = '2016' AND pos = 'OF'
ORDER BY position;

--Infield 2016--661 Infield
SELECT pos, yearid,
		CASE WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
			 END AS position
			 
FROM fielding
WHERE yearid = '2016' AND pos IN ('SS','1B','2B','3B')
ORDER BY position DESC;
----


--Battery 2016--938 Battery
SELECT pos, yearid,
		CASE WHEN pos IN ('P','C') THEN 'Battery'
			 END AS position
FROM fielding
WHERE yearid = '2016' AND pos IN ('P','C')
ORDER BY position DESC;

