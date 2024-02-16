--Q.11
select m.teamid, m.yearid , sum(salary)as salary, sum(w) as win_games, sum(g) total_played, round((sum(w)*100)/sum(g),2) win_percentage
from managers as m join salaries as s
                 using (playerid)
where m.yearid >= 2000
group by m.teamid, m.yearid
order by m.teamid, m.yearid







