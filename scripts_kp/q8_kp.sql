--8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 
--(where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. 
--Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

select park_name,team,round(avg(attendance)/ games,2)as avg_attendance_per_game
from homegames inner join parks 
              using(park)
where year = 2016
     and games >=10
group by park_name,team,games
order by avg_attendance_per_game desc
limit 5

select park_name,team,round(avg(attendance)/ games,2)as avg_attendance_per_game
from homegames inner join parks 
              using(park)
where year = 2016
     and games >=10
group by park_name,team,games
order by avg_attendance_per_game asc
limit 5