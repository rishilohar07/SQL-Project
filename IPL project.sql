Use Project;

-- Created table for Batters---
create table Batters (Player_Name varchar(40), Team varchar(20), Runs int, Matches int, Innings int, Highest_Score int, Avg float, Ball_faced int, Strike_Rate float, 100s int, 50s int, 4s int, 6s int);
desc Batters;
-- Imported dataset using table import wizard --
select * from Batters;

-- Created table for Bowlers---
create table Bowlers (Player_Name varchar(40), Team varchar(20), WKT int, Matches int, Innings int, Overs float, Runs int, BBI varchar(10),	Avg float, Economy float, Strike_Rate float, 4W int, 5W int);
desc Bowlers;
-- Imported dataset using table import wizard --
select * from Bowlers;

--- EDA to verify all data have been imported ---
select count(*) from batters;
select count(*) from bowlers;

-- Finding batsman with highest strike rate --
select Player_Name as Batter, Strike_Rate from Batters order by Strike_Rate desc limit 1;  ## using order and limit
select Player_Name as Batter, Strike_Rate from Batters where Strike_Rate in (select max(Strike_Rate) from Batters); ## using subqueries

-- Finding Bowler with lowest strike rate ---- 

select Player_Name as Bowler, Strike_Rate from Bowlers order by Strike_Rate limit 1;  ## using order and limit
select Player_Name as Bowler, Strike_Rate from Bowlers where Strike_Rate in (select min(Strike_Rate) from Bowlers); ## using subqueries

-- Findning best batsmans and bolwers for bidding based on average, economy and strike rate --
select Player_Name as Batter, Avg, Strike_Rate from Batters
where Avg>=50 and Strike_Rate>=150;

select Player_Name as Bowler, Economy, Strike_Rate from Bowlers
where Economy<10 and Strike_Rate<20
order by Economy limit 10;

select count(Player_Name) from Bowlers
where Economy<10 and Strike_Rate<20; ## Gives number 34 bowlers

-- Finding 10 all rounders ---
select bt.Player_Name as All_Rounder,bt.Team, bt.Avg as Batting_Avg, bw.economy as Bowling_Economy
from Batters bt 
inner join Bowlers bw 
on bt.Player_Name=bw.Player_Name
order by Batting_Avg desc limit 20;

-- Five wickets hall --
select Player_Name, Team, 5W from Bowlers where 5W>0;

-- Teams as per their 4s and 6s --
SELECT 
    Team,
    SUM(4s) AS Max_Fours,
    SUM(6s) AS Max_sixes,
    (SUM(4s) + SUM(6s)) AS Total_Boundries
FROM
    Batters
GROUP BY Team
ORDER BY Total_Boundries DESC;

--- top 5 players with the most runs in a single match -- 
select Player_Name, Team, Highest_Score from Batters order by Highest_Score desc limit 5;

-- top 3 bowlers with the most wickets overall --Purple cap race --
select Player_Name, Team, WKT as Wickets from Bowlers order by Wickets desc limit 3;

-- Finding Orange Cap holder --
select Player_Name, Team, Runs from Batters order by Runs desc limit 3; 

--- All round performance in season --- 
Select bt.Player_Name, bt.Runs, bw.WKT
From Batters bt
Join Bowlers bw 
  On bt.Player_Name = bw.Player_Name
Where bt.Runs >= 200
  And bw.WKT >= 10;
  
  --- Performance category ---
  select Player_Name as Batsman, Runs,
  case
  when Runs > 500 then "Top Performer"
  when Runs between 500 and 300 then " High Performer"
  when Runs between 100 and 300 then "Medium Performer"
  Else "Low Performer"
  End as Performance from Batters;
  
  --  Top 5 sixes hitters  --
  select Player_Name as Batsman , 6s from Batters order by 6s desc limit 5;

select bt.Player_Name as Playername, bt.Runs, bw.WKT
from Batters bt join Bowlers bw on bt.Player_Name=bw.Player_Name
where bt.Runs>600 and bw.WKT>20;