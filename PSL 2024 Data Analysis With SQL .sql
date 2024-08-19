create database psl2024;

use psl2024;

-- Total Data 
select *from bating;
select *from bowling;
select *from players;
select *from match_summary;


-- Data Cleaning

alter table bating alter column runs int
alter table bating add innings int
alter table bowling alter column 'over 1' int
alter table bowling alter column runs int
alter table bating alter column sixes int
alter table bating alter column fours int

exec sp_rename 'dbo.bowling.[overs 1]' , 'Overs','column';
exec sp_rename 'dbo.players.[name]' , 'names','column';




-- Data Analysis

-- show the total highest score in this season 

select top 10
player_name as Players ,
sum(innings) as Innings,
sum(runs) as  Runs,
round((sum(runs) / sum(innings)) ,2) as Average
from bating
group by player_name
order by sum(runs) desc



-- show the top bowlers of this season

select top 10
bowlerName as Bowlers,
sum(innings) as Innings,
sum(wickets) as Wickets,
round(sum(economy) / sum(innings),2) as Economy
from bowling
group by bowlerName
order by wickets desc

-- show the highest scores of this season

select top 10
player_name as Players,
runs as 'Highest Score',
strikeRate as 'Strike Rate'
from bating
order by runs desc


-- show the best bowling figure in this season

select top 10
bowlerName as Bowler,
Overs as 'Overs',
economy as Economy,
concat(wickets,'/',runs) as 'Best Bowling'
from bowling 
order by wickets desc


-- show the best bating average 

select top 10
player_name as Players ,
sum(innings) as Innings,
sum(runs) as  Runs,
round((sum(runs) / sum(innings)) ,2) as Average
from bating
group by player_name
order by Average desc


-- show the best average in bowling

select top 10
bowlerName as Bowlers,
sum(innings) as Innings,
sum(wickets) as Wickets,
(sum(runs) / sum(innings) * 1.0) as Average
from bowling
group by bowlerName
order by Average asc


-- show the most fifties

select top 10
player_name as Players,
sum(case when runs>= 50 then 1
else 0
end) as Fifties
from bating
group by player_name
order by Fifties desc 


-- show the most hundard

select top 3
player_name as Players,
sum(case when runs>= 100 then 1
else 0
end) as Hundard
from bating
group by player_name
order by Hundard desc


-- show the most economical bowler

select top 10
bowlerName as Bowlers,
sum(innings) as Innings,
sum(wickets) as Wickets,
round(sum(economy) / sum(innings),2) as 'Most Economical'
from bowling
group by bowlerName
order by 'Most Economical' asc


-- show the which bowlers take whole five wickets

select top 3
bowlerName as Bowler,
sum(innings) as Innings,
sum(wickets) as Wickets,
sum(case when wickets >= 5 then 1 else 0 end) as '5Wickets'
from bowling
group by bowlerName
order by '5Wickets' desc 


-- show the most sixes in this session

select top 10
player_name as Players,
sum(innings) as Innings,
sum(runs) as Runs,
sum(sixes) as 'Most Sixes'
from bating
group by player_name
order by 'Most Sixes' desc



-- show the most fours in this session

select top 10
player_name as Players,
sum(innings) as Innings,
sum(runs) as Runs,
sum(fours) as 'Most Fours'
from bating
group by player_name
order by 'Most Fours' desc






-- show the most boundaries in this session

select top 10
player_name as Players,
sum(innings) as Innings,
sum(runs) as Runs,
(sum(fours) + sum(sixes)) as 'Most Boundaries'
from bating
group by player_name
order by 'Most Boundaries' desc



-- show that most matches winners in this session

select
winner as Teams,
count(winner) as 'Most Winners'
from match_summary
group by winner
order by 'Most Winners' desc


-- show that the Player Role In this Season

select
playerRole as 'Player Roles',
count(playerRole) as Counts
from players
group by playerRole
order by Counts desc