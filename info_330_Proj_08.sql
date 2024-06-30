
USE INFO_330_Proj_08

create TABLE tblPLATFORM
(PlatformID INT IDENTITY(1,1) primary KEY,
PlatformName VARCHAR(50) not null,
platformdescr VARCHAR(125))
GO

insert into tblplatform (PlatformName, platformdescr)
values('Email', 'Monthly newletter to email subscribers'),
('Instagram', 'Weekly updates on club deals and offers'),
('Mobile App', 'Display with up-to-date information on deals through pop-ups'),
('Youtube', 'Youtube Ads')
-- 

CREATE TABLE tblCAMPAIGN_PLATFORM
(CampaignPlatID int IDENTITY (1,1) primary key,
CampaignID int not null,
PlatformID int not null,
StartDate date,
EndDate date,
foreign key(CampaignID) references tblCAMPAIGN(CampaignID),
foreign key(PlatformID) references tblPLATFORM(PlatformID))
go

EXEC atanInsertCamp
@CampaignName = 'Summer Deal 2023',
@platformName = 'Email',
@begindate = 'October 14, 2003',
@enddate = 'December 14, 2003'

EXEC atanInsertCamp
@CampaignName = 'Spring Deal 2023',
@platformName = 'Instagram',
@begindate = 'March 8, 2022',
@enddate = 'May 13, 2023'

EXEC atanInsertCamp
@CampaignName = 'Winter Deal 2023',
@platformName = 'Mobile App',
@begindate = 'January 5, 2023',
@enddate = 'February 14, 2023'
-- 
create table tblCAMPAIGN
(CampaignID int IDENTITY (1,1) PRIMARY key,
CampaignName VARCHAR (105) not null,
CampaignDescr varchar (125))
go 

insert into tblCAMPAIGN(CampaignName, CampaignDescr)
values ('Summer Deal 2023', 'First month free!'),
('Winter Deal 2023', 'First three months for only $1!'),
('Spring Deal 2023', 'First two months free!'),
('Fall Deal 2023', 'Free one week trial!')

-- added factypename
create table tblFACILITY_TYPE
(FacilityTypeID int IDENTITY (1,1) PRIMARY key,
FacilityTypeDesc varchar (105))
GO

alter table tblFACILITY_TYPE
drop column FacilityTypeID

alter table tblFACILITY_TYPE
add FacilityTypeID int IDENTITY(1,1) PRIMARY KEY;

insert into tblfacility_type (FacilityTypeID, FacilityTypeDesc, FacilityTypeName)
values(1, 'provide access to a wide range of fitness equipment, group exercise classes, personal training sessions, and other amenities', 'Fitness club (1FLOOR)'),
(2, 'provide access to a wide range of fitness equipment, group exercise classes, personal training sessions, and other amenities', 'Fitness club (1FLOOR)'),
(3, 'provide access to a wide range of fitness equipment, group exercise classes, personal training sessions, and other amenities', 'Fitness club (2FLOOR)')


select*
from sp_help tblfacility_type
-- 
create table tblEQUIPMENT
(EquipmentID int IDENTITY (1,1) PRIMARY key,
EquipmentTypeID int not null,
FacilityID int not null,
foreign key (EquipmentTypeID) references tblEQUIPMENT_TYPE(EquipmentTypeID),
foreign key (facilityid) references tblFACILITY(facilityid))
GO

update tblEQUIPMENT
set equipmentName = 'Lat Pull Down'
where equipmentid = 2
select *
from tblequipment

exec atanInsertEquip
@Equipmname = 'Bench Press',
@EquipmentTypeName ='Free Weights',
@facName ='24Hr Fitness',
@facAddress= '9012 S 204th Pl',
@facCity= 'Seattle',
@facState= 'WA',
@facZip='98031'


exec atanInsertEquip
@Equipmname = 'Shoulder Press Machine',
@EquipmentTypeName ='Machines',
@facName ='24Hr Fitness',
@facAddress= '9012 S 204th Pl',
@facCity= 'Seattle',
@facState= 'WA',
@facZip='98031'

exec atanInsertEquip
@EquipmentTypeName ='Cardio',
@facName ='24Hr Fitness',
@facAddress= '9012 S 204th Pl',
@facCity= 'Seattle',
@facState= 'WA',
@facZip='98031'

exec atanInsertEquip
@EquipmentTypeName ='Strength Training',
@facName ='24Hr Fitness',
@facAddress= '9012 S 204th Pl',
@facCity= 'Seattle',
@facState= 'WA',
@facZip='98031'

exec atanInsertEquip
@EquipmentTypeName ='Machines',
@facName ='24Hr Fitness',
@facAddress= '9012 S 204th Pl',
@facCity= 'Seattle',
@facState= 'WA',
@facZip='98031'

-- added facSTATE, facTYPEID, fac name
create table tblFACILITY
(FacilityID int IDENTITY (1,1) PRIMARY key,
FacilityAddress VARCHAR(105) not null,
FacilityCity VARCHAR(50) not null,
FacilityState VARCHAR(50) not null,
FacilityZip VARCHAR(50) not null,
FacilityCapacity int not null)
GO

alter table tblfacility
add campaignid int  

alter table tblfacility
add constraint fk
foreign key (campaignid) references tblcampaign (CampaignID)

insert into tblfacility(facilityid, facilitytypeid, FacilityAddress, FacilityCity, FacilityZip, FacilityCapacity,FacilityState, facilityName)
values (1, (select facilitytypeid
        from tblFACILITY_TYPE
        where facilitytypename = 'Fitness Club (2FLOOR)'), '9012 S 204th Pl', 'Seattle', '98031', '100', 'WA', '24Hr Fitness'),
        (2, (select facilitytypeid
        from tblFACILITY_TYPE
        where facilitytypename = 'Fitness Club (2FLOOR)'), '8013 W 204th Pl', 'Seattle', '98031', '100', 'WA', '24Hr Fitness'),
        (3, (select facilitytypeid
        from tblFACILITY_TYPE
        where facilitytypename = 'Fitness Club (2FLOOR)'), '7836 S 204th Pl', 'Bellevue', '98031', '100', 'WA', '24Hr Fitness')
GO
-- 
SELECT*
FROM tblEQUIPMENT
GO
------------------------


