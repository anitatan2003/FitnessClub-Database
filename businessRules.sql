use INFO_330_Proj_08
Go
/*
Two business rules leveraging User-Defined Functions (UDF) in 
addition to a sentence or two to describe the purpose/intent of each business rule.
*/

--Restrict customers from being active on more than one membership type.
--This is to ensure that customers are not active on multiple membership plans.
--add mem type 
create or alter function atanBSMembership()
returns INT
AS
begin
    declare @RET int = 0

if exists (select s.StatusID, c.CustomerID, c.CustomerFname, c.CustomerLname, mt.membershiptypeid, count(s.StatusID)numMembership
            from tblcustomer c 
                join tblmembership m on c.CustomerID = m.CustomerID
                join tblMEMBER_STATUS ms on m.MembershipID = ms.MembershipID
                join tblstatus s on ms.StatusID=s.StatusID
                join tblmembership_type mt on m.MembershipTypeID = mt.MembershipTypeID
            where s.StatusName = 'Active'
            group by s.StatusID, c.CustomerID, c.CustomerFname, c.CustomerLname, mt.membershiptypeid
            having count(s.StatusID) > 1)
set @RET = 1
return @RET 
END
go

alter table tblmembership
add CONSTRAINT atanNoMultMembership
check(dbo.atanBSMembership()=0)
GO

-- Restrict customers from signing in for their visit if their membership is not currently
-- active.
-- This business rule maintains membership status, and requires customers to take action (whether
-- that be paying for membership, or other) in order to use gym equipment.

alter function atanBSNoSignIN()
returns INT
AS
begin
    declare @RET int = 0

if exists (select v.VisitID, C.CustomerID, c.CustomerFname, c.CustomerLname
            from tblcustomer c 
                join tblmembership m on c.CustomerID = m.CustomerID
                join tblMEMBER_STATUS ms on m.MembershipID = ms.MembershipID
                join tblstatus s on ms.StatusID=s.StatusID
                join tblvisit v on m.MembershipID=v.MembershipID
            where s.StatusName not in ('Active'))
set @RET = 1
return @RET 
END
go

alter table tblvisit
add CONSTRAINT atanNoSignIN
check (dbo.atanBSNoSignIN()=0)