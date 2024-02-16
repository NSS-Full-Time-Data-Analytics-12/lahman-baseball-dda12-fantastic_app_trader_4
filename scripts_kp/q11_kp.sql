--11. Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this question. 
--As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.


select m.teamid, m.yearid , sum(salary)as salary, sum(w) as win_games, sum(g) total_played, round((sum(w)*100)/sum(g),2) win_percentage
from managers as m join salaries as s
                 using (playerid)
where m.yearid >= 2000
group by m.teamid, m.yearid
order by m.teamid, m.yearid ;	















select *
from managers m join salaries as s
              using (playerid)
where s.playerid = 'olsongr01'
and s.yearid = 1997	  


"olsongr01"	2	1997

select *
from salaries
where playerid = 'olsongr01'
 and yearid = 1997


select  playerid,teamid,yearid ,count(salary)
from salaries
 group by playerid,teamid,yearid 
--having count(salary) > 1

select distinct yearid from managers
where yearid > 2000;

select playerid,salary,yearid
from salaries
where playerid = 'blanche01'
and yearid >2000
order by yearid

select m.yearid, s.yearid, m.*
from managershalf m join salaries s on m.playerid = s.playerid
--                               and m.yearid = s.yearid
where m.yearid > 2000;

select *
 from salaries
 where yearid > 2000
  and  playerid= 'sciosmi01';

where playerid = 'koehlto01'

select salary,sum(w),m.yearid 
from managers as m join salaries as s
                 using (playerid)
where m.yearid >= 2000
group by salary,m.yearid
order by m.yearid desc;	