use INFO_330_Proj_08
GO

--Add a computed column showing the duration of a campaign_platform. 
create function atan_campduration(@PK int)
returns INT
AS
BEGIN
    declare @RET INT = (select DATEDIFF(day, startDate, isnull(enddate, getdate()))
                        from tblCAMPAIGN_PLATFORM
                        where campaignPlatid = @PK)
return @RET 
END
GO

alter table tblCAMPAIGN_PLATFORM
add duration as (dbo.atan_campduration(campaignPlatid))
GO


-- Add a computed column showing total number of customers with an
-- active membership at a facility.
create function atanTotalCust(@PK int)
returns INT
AS
BEGIN
    declare @RET int = (select count(c.customerid) totalCustomers
                        from tblcustomer C
                            join tblmembership m on c.customerid = m.customerid
                            join tblmember_status ms on m.membershipid = ms.membershipid
                            join tblvisit v on m.membershipid = v.membershipid
                            join tblfacility f on v.FacilityID=f.FacilityID
                            join tblstatus s on ms.statusid = s.statusid
                        where s.statusName = 'Active'
                            and f.facilityid = @pk)
return @RET
END
GO

alter table tblfacility
add totalActiveCustomers as (dbo.atanTotalCust(facilityid))