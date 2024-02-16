--4. Using the fielding table, group players into three groups based on their position: 
--label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". 
--Determine the number of putouts made by each of these three groups in 2016.

 select  sum(po),
         case when pos = 'OF' then 'outfiled'
		      when pos in ('SS','1B','2B','3B') then 'infield'
			  when pos in ('P','C')  then 'battery'
		 else ' ' 
		 end as position
   from fielding
  where yearid = 2016
  group by position;

