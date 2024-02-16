--13. It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. 
--Investigate this claim and present evidence to either support or dispute this claim.
--First, determine just how rare left-handed pitchers are compared with right-handed pitchers.   
select left_throws, right_rhrows, right_rhrows - left_throws as difference, round((left_throws*100)/right_rhrows) percentage_of_left_throws
  from (select sum(case when throws = 'L' then 1 else 0 end) as left_throws, 
               sum(case when throws = 'R' then 1 else 0 end) as right_rhrows	   
          from people);

--Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?
select sum (case when throws = 'L' then 1 else 0 end) as left_throws, 
               sum (case when throws = 'R' then 1 else 0 end) as right_rhrows	   
  from people as p join awardsplayers as a
     using (playerid)
	 where awardid = 'Cy Young Award';
	 


select sum (case when throws = 'L' then 1 else 0 end) as left_throws, 
               sum (case when throws = 'R' then 1 else 0 end) as right_rhrows	        
	                                                                                             
  from people as p join halloffame as a  
     using (playerid)










select throws,awardid
 from people as p join halloffame as =h
     using (playerid)
	 where awardid = 'Cy Young Award';
	 
	 



	
 



	
	
		  
		 