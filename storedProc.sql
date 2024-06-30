use info_330_Proj_08
Go
-- write a stored procedure to insert a campaign platform.
create or alter proc atanGetcID
@CampaignName2 varchar(105),
@C_ID int output 
AS
BEGIN
set @C_ID = (select top 1 campaignid
            from tblCAMPAIGN
            where CampaignName=@CampaignName2)
END
go 

create or alter proc atanGetpID
@PlatformName2 VARCHAR(50), 
@P_ID int output 
AS
begin
set @p_ID = (select top 1platformid
            from tblPLATFORM
            where platformName=@platformname2)
end 
go 

create or alter proc atanInsertCamp
@CampaignName varchar (105),
@platformName varchar (50),
@begindate date,
@enddate date

as 

declare @c_id int, @p_id int 

exec atanGetpID
@PlatformName2 =@platformname, 
@P_ID = @p_id OUTPUT

if @P_id is NULL
    BEGIN
        print '@F_id is null... check spelling';
        throw 54365, 'cannot be null statement is termingating', 1;
    END

exec atanGetcID
@CampaignName2 =@CampaignName,
@C_ID =@c_id output 

if @C_id is NULL
    BEGIN
        print '@F_id is null... check spelling';
        throw 54365, 'cannot be null statement is termingating', 1;
    END

begin TRANSACTION g1
insert into tblCAMPAIGN_PLATFORM (CampaignID, PlatformID, StartDate, EndDate)
values (@c_id, @p_id, @begindate, @enddate )
commit TRANSACTION g1

-- write a stored procedure to insert a piece of equipment.
select *
from sp_help tblEQUIPMENT_TYPE
GO

create PROC atanGetet_ID
@EquipTypeName1 VARCHAR(50),
@et_id int output 
as
set @et_id = (select EquipmentTypeID
            from tblEQUIPMENT_TYPE
            where EquipmentTypeName = @EquipTypeName1)
GO

create proc atanGetf_ID
@facName1 varchar(50),
@facAddress1 VARCHAR(105),
@facCity1 VARCHAR(50),
@facState1 VARCHAR(50),
@facZip1 VARCHAR (50),
@f_id int output
AS
set @f_id = (select FacilityID
            from tblfacility
            where facilityName=@facName1
                and FacilityAddress = @facAddress1
                and FacilityCity = @facCity1
                and FacilityState = @facState1
                and FacilityZip = @facZip1)
GO


create or alter proc atanInsertEquip
@Equipmname varchar(75),
@EquipmentTypeName VARCHAR(50),
@facName varchar(50),
@facAddress VARCHAR(105),
@facCity VARCHAR(50),
@facState VARCHAR(50),
@facZip VARCHAR (50)

AS

DECLARE @ET_ID int, @F_id int

EXEC atanGetet_ID
@EquipTypeName1 = @EquipmentTypeName,
@et_id = @ET_ID OUTPUT

if @ET_id is NULL
    BEGIN
        print '@ET_id is null... check spelling';
        throw 54365, 'cannot be null statement is termingating', 1;
    END


exec atanGetf_ID
@facName1 = @facName,
@facAddress1 = @facAddress,
@facCity1 = @facCity,
@facState1 = @facState,
@facZip1 = @facZip,
@f_id = @F_id OUTPUT

if @F_id is NULL
    BEGIN
        print '@F_id is null... check spelling';
        throw 54365, 'cannot be null statement is termingating', 1;
    END


BEGIN TRANSACTION g1
    insert into tblEQUIPMENT (EquipmentTypeID, FacilityID, equipmentName)
    VALUES (@et_id, @f_id, @Equipmname)
commit TRANSACTION g1

