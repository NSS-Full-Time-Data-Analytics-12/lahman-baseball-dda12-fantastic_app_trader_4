--12. In this question, you will explore the connection between number of wins and attendance.
    --<ol type="a">
      --<li>Does there appear to be any correlation between attendance at home games and number of wins? </li>
      --<li>Do teams that win the world series see a boost in attendance the following year?
	  --What about teams that made the playoffs? Making the playoffs means either being a division winner or a wild card winner.</li>
    --</ol>
	
	
	
SELECT CORR(homegames.attendance,w)AS corr_attend
FROM teams INNER JOIN homegames ON teamid = team AND yearid =year
WHERE homegames IS NOT NULL


SELECT teams.w,h.year, h.team,ROUND(AVG( h.attendance),2)AS avg_attendance, h2.year, h2.team,ROUND(AVG( h2.attendance),2)AS next_year_avg_attendance
FROM teams INNER JOIN homegames AS h ON teams.yearid = h.year AND teams.teamid = h.team	
           INNER JOIN homegames AS h2 ON teams.yearid + 1  = h2.year AND teams.teamid = h2.team
WHERE wswin = 'Y' AND h.attendance <> 0			
GROUP BY h.year, h.team, teams.w , teams.yearid,h2.year, h2.team
ORDER BY h.year


	  	 
SELECT teams.w,h.year, h.team,ROUND(AVG(h.attendance),2)AS avg_attendance, h2.year, h2.team,ROUND(AVG( h2.attendance),2)AS next_year_avg_attendance
FROM teams INNER JOIN homegames AS h ON teams.yearid = h.year AND teams.teamid = h.team
           INNER JOIN homegames AS h2 ON teams.yearid + 1  = h2.year AND teams.teamid = h2.team
WHERE divwin = 'Y' OR wcwin = 'Y'			
GROUP BY h.year, h.team, teams.w, teams.yearid,h2.year, h2.team
ORDER BY h.team