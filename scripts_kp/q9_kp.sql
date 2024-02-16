--9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
--Give their full name and the teams that they were managing when they won the award.


					 	
SELECT a.playerid,a.awardid,a.yearid,a.lgid,b.lgid
FROM awardsmanagers AS a INNER JOIN awardsmanagers AS b
                        USING (playerid)
                       LEFT JOIN people USING (playerid)
WHERE a.awardid = 'TSN Manager of the Year' 
  AND a.lgid IN ('AL','NL')
  AND b.lgid IN ('NL','AL') 
  AND a.lgid <> b.lgid
GROUP BY a.playerid,a.awardid,a.yearid,a.lgid,b.lgid					
						
						
						
						