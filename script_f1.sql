-- create database
create database F1_statistics;

--create table racer 

create table if not exists racer(
	racer_id serial primary key,
	email varchar(128) not null unique,
	pass varchar(20) not null,
	numb_of_races_r int not null,
	all_points_r int not null,
	team_id int references team(team_id)
);

--create table team 

create table if not exists team(
	team_id serial primary key,
	email varchar(128) not null unique,
	pass varchar(20) not null,
	numb_of_races_t int not null,
	team_points int not null
); 

--create table grandprix

create table if not exists grandprix(
	gp_id serial primary key,
	date_of_gp date not null,
	name_of_gp varchar(128) not null
);

--create table racer_grandprix

create table if not exists racer_grandprix(
	racer_id int references racer(racer_id),
	gp_id int references grandprix(gp_id),
	race_points int not null,
	primary key (racer_id, gp_id)
);

-- adding information to the data base 

insert into team (team_id,email,pass,numb_of_races_t,team_points)
values (1,'Ferrari@example.com','Ferraripass',300,'10158'),
(2,'Mercedes@example.com','Mercedespass',444,'6952'),
(3,'RedBull@example.com','RedBullpass',123,'6431'),
(4,'AstonMartin@example.com','AstonMartinpass',456,'155'),
(5,'Williams@example.com','Williamspass',321,'3599');
select * from team;

insert into racer(racer_id,email,pass,numb_of_races_r,team_id,all_points_r)
values (1,'Maxv@example.com','MaxVpass','162',3,'2011'),
(2,'CharlesL@example.com','CharlesLpass','103',1,'868'),
(3,'LewisH@example.com','LewisHpass','310',2,'4405'),
(4,'FernandoA@example.com','FernandoApass','358',4,'2076'),
(5,'AlexanderA@example.com','AlexanderApass','58',5,'202');
select * from racer;


insert into grandprix (gp_id, date_of_gp,name_of_gp)
values (1,'2022-03-18', 'The Bahrain Grand Prix 2022'),
(2,'2022-03-25','The Saudi Arabian Grand Prix 2022'),
(3,'2022-04-08','The Australian Grand Prix 2022');
select * from grandprix g ;

insert into racer_grandprix(racer_id,gp_id,race_points)
values(1,1,'2'),
(1,2,'1'),
(1,3,'1'),
(2,1,'1'),
(2,2,'2'),
(2,3,'3'),
(3,1,'3'),
(3,2,'3'),
(3,3,'2');
select * from racer_grandprix rg  ;

-- the best racer 
select email as "Racer",
all_points_r as "Points"
from racer r 
order by all_points_r desc ;

-- the most experienced racer 
select numb_of_races_r as "Number of races",
email as "Racer"
from  racer r
order by numb_of_races_r desc;

-- the most experienced team 
select numb_of_races_t as "Number of races",
email as "Team"
from  team t 
order by numb_of_races_t desc;

--the best team 
select email as "Team",team_points as "Points"
from team t
order by team_points desc;

--first place in the race
select
sum(race_points) as "Points",
racer_grandprix.racer_id,
email as "Racer"
from racer_grandprix  
inner join racer r on racer_grandprix.racer_id = r.racer_id 
inner join grandprix g on racer_grandprix.gp_id = g.gp_id 
group by racer_grandprix.racer_id,email
order by 1 desc;

