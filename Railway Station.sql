Create database RailwaySystem
Use RailwaySystem
go

create table Station
(
StationId int not null ,
StationName varchar(MAX) not null
)

alter table Station
add constraint PK_1 Primary key (StationId)

insert into Station values (1,'Lahore Railway Station')
insert into Station values (2,'Karachi Station')
insert into Station values(3,'Rawalpindi Station')
insert into Station values(4,'Hyderabad Juction')
insert into Station values(5,'Faisalabad Junction')
insert into Station values(6,'Attock Railway Station')

Select * from Station
select *from fare_schedules

--Inner Join AND ORDER--
select * from Station as A
inner join fare_schedules as B
on A.StationId=B.StationId

select A.StationName,B.SingleFare,B.ReturnFare from Station as A --A and B are the alliase--
inner join fare_schedules as B
on A.StationId=B.StationId order by SingleFare

--LEFT JOIN  --
insert into Station values(7,'Attock Railway Station')
select * from Station as A
left join fare_schedules as B
on A.StationId=B.StationId

create table timetable
(
timeTable int primary key,
StationId int Foreign key references Station(StationId),
departureTime time,
arrivalTime time
)

Alter table timetable 
add constraint DF_1 default 1 for StationID

insert into timetable values(1111,1,'2:45:00 PM','4:12:00 PM')
insert into timetable values(2222,2,'1:15:00 AM','2:49:00 AM')
insert into timetable values(3333,1,'9:00:00 PM','12:00:00 AM')
insert into timetable values(4444,5,'7:45:00 AM','8:12:00 AM')
insert into timetable values(5555,3,'6:45:00 PM','7:35:00 PM')
insert into timetable values(6666,4,'8:30:00 AM','11:20:00 AM')
Select * from timetable

create table passenger
(
passengerId int primary key,--int primary key identity(1,1)--
passengerName varchar(MAX),
passengerGender varchar(25),
passengerAge int,
passengerEmail varchar(MAX),
passengerNumber varchar(50),
)


alter table Passenger
add constraint ck_1 check (PassengerAge>0)

insert into passenger values(1,'M Shaheryar Sajid','MALE',21,'sp19-bcs-038@cuiatk.edu.pk','03400587684')
insert into passenger values(2,'Shahzaib Mehmood','MALE',21,'sp19-bcs-053@cuiatk.edu.pk','03085639696')
insert into passenger values(3,'Sara Khan','FEMALE',26,'sarakhan26@gmail.com','03123156432')
insert into passenger values(4,'Engin Altan','MALE',45,'enginaltan@cuiatk.edu.pk','03432345684')
insert into passenger values(5,'Haleema Sultan','FEMALE',29,'haleemasultan@cuiatk.edu.pk','03432344684')
insert into passenger values(6,'Bamsi Bey','MALE',47,'bamsibey@cuiatk.edu.pk','0336285684')

alter table Passenger
Add Adres Varchar(50)

update passenger set adres='Pindighaib' where passengerId=1 or Passengerid=3 
update passenger set adres='Attock' where passengerId=2 or Passengerid=4
update passenger set adres=' Lahore'where passengerId=5 
update passenger set adres='Karachi' where passengerId=6 
Select * from Passenger



create table fare_schedules(
fareId int primary key,
timeTable int foreign key references timetable(timetable),
StationId int foreign key references Station(StationId),
SingleFare int,
ReturnFare int)

insert into fare_schedules values (111,1111,1,1200,1400)
insert into fare_schedules values (222,2222,2,100,100)
insert into fare_schedules values (333,3333,4,1500,1500)
insert into fare_schedules values (444,4444,6,450,500)
insert into fare_schedules values (555,5555,3,120,120)
insert into fare_schedules values (666,6666,5,60,60)

select * from fare_schedules

create table ticket
(
ticketId int primary key,
passengerId int foreign key references passenger(passengerId),
fromStationName varchar(MAX) not null,
toStationName varchar(MAX) not null,
dateIssued date,
single_or_return varchar(30),
fare int,
fareId int Foreign key references fare_schedules(FareId )
)
--Triggers--
create trigger ticket_forinsert --This trigger will show a message after execution--
on ticket
after insert 
as
begin print 'Something happened to the ticket Table';
end

alter trigger ticket_forinsert   --This trigger creates another copy of what you insert and show automatically--
on ticket 
after insert 
as begin 
select *from inserted
end;

insert into ticket values(77,6,'Attock Junction','Basal Junction','12-24-2020','single',1200,666) --extra--

--Trigger for deletion--
create trigger ticket_fordeletion
on ticket
after delete
as begin select *from deleted
end;

delete from ticket where ticketId=77


insert into ticket values(11,1,'Attock Junction','Basal Junction','12-24-2020','single',1200,111)
insert into ticket values(22,2,'Islamabad Junction','Rawalpindi Junction','12-25-2020','single and Return',200,222)
insert into ticket values(33,3,'Jehlum Junction','Hyderabad Junction','11-23-2020','single',1500,333)
insert into ticket values(44,4,'Lahore Junction','Kaarachi Junction','12-22-2020','single',450,444)
insert into ticket values(55,5,'Multan Junction','Narowal Junction','10-11-2020','single and Return',240,555)
insert into ticket values(66,6,'Peshawar Junction','Mirzapur Junction','12-24-2020','single',60,666)
select *from ticket

--Trigger for update--
create trigger tr_passengerforupdte
on passenger
after update 
as 
begin 
select * from inserted
select * from deleted
end

update ticket set fromStationName='Pindigheb Junction' where ticketId=11

sp_helptext tr_passengerforupdte --(system store procedure )--
--*****************************************************************--

select * from passenger as A
join ticket as B
on A.passengerId=B.passengerId

select A.passengerName,A.passengerEmail,A.passengerAge,A.passengerNumber,B.fromStationName,B.toStationName,B.fare from passenger as A
join ticket as B
on A.passengerId=B.passengerId


--- Applying store procedure on the table passenger for saving the code for viweing the passenger name and age....
create proc sppassenger  --we use profix (sp) for store procedure--
@passengerName varchar(MAX),
@passengerAge int
as begin
select passengerName,passengerAge from passenger
where passengerName=@passengerName and passengerAge=@passengerAge
End
--For executing the store procedure....
execute sppassenger 'Bamsi Bey',47
