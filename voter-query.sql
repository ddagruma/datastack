with electionhistory as (

	select "ElectionDate", "ElectionTypeDesc", "ElectionName", count(*) as total_voters 
	from voterhistory 
	group by "ElectionDate", "ElectionTypeDesc", "ElectionName" 
)

, electionhistory_filtered as (

select *
from electionhistory
where "ElectionTypeDesc" not in ('MUNICIPAL' , 'OTHER') 
order by cast( "ElectionDate" as date ) desc 
LIMIT 5 
) ,

distinct_voters as (

select "RegistrantID", h."ElectionDate", h."ElectionName"
from electionhistory_filtered e 
join voterhistory h 
  on e."ElectionDate" = h."ElectionDate"
  and e."ElectionName" = h."ElectionName"
group by "RegistrantID", h."ElectionDate", h."ElectionName"
) ,

compulsive_voters as (

select h."RegistrantID", count(*) as election_voted
from electionhistory_filtered e 
join distinct_voters h 
  on e."ElectionDate" = h."ElectionDate"
  and e."ElectionName" = h."ElectionName"
GROUP BY h."RegistrantID" 
HAVING COUNT(*) = 5 

) ,

households as (
select count(*) as voter_count,
	"AddressNumber" ,
	"HouseFractionNumber" ,
	"AddressNumberSuffix" ,
	"StreetDirPrefix" ,
	"StreetName" ,
	"UnitType" ,
	"UnitNumber" ,
	"City" ,
	"State" ,
	"Zip" ,
	md5(ROW("AddressNumber" ,
	"HouseFractionNumber" ,
	"AddressNumberSuffix" ,
	"StreetDirPrefix" ,
	"StreetName" ,
	"UnitType" ,
	"UnitNumber" ,
	"City" ,
	"State" ,
	"Zip")::TEXT) as housekey 
from voter v 
group by "AddressNumber" ,
	"HouseFractionNumber" ,
	"AddressNumberSuffix" ,
	"StreetDirPrefix" ,
	"StreetName" ,
	"UnitType" ,
	"UnitNumber" ,
	"City" ,
	"State" ,
	"Zip",
	md5(ROW("AddressNumber" ,
	"HouseFractionNumber" ,
	"AddressNumberSuffix" ,
	"StreetDirPrefix" ,
	"StreetName" ,
	"UnitType" ,
	"UnitNumber" ,
	"City" ,
	"State" ,
	"Zip")::TEXT) 
	) ,

household_with_compulsive_voter as (
select 
	v."AddressNumber" ,
	v."HouseFractionNumber" ,
	v."AddressNumberSuffix" ,
	v."StreetDirPrefix" ,
	v."StreetName" ,
	v."UnitType" ,
	v."UnitNumber" ,
	v."City" ,
	v."State" ,
	v."Zip" ,
	count(*) as total_5_voters 
from voter v 
join compulsive_voters c on c."RegistrantID" = v."RegistrantID"

group by v."AddressNumber" ,
	v."HouseFractionNumber" ,
	v."AddressNumberSuffix" ,
	v."StreetDirPrefix" ,
	v."StreetName" ,
	v."UnitType" ,
	v."UnitNumber" ,
	v."City" ,
	v."State" ,
	v."Zip"
)



select v.*
from voter v 
join compulsive_voters c on v."RegistrantID" = c."RegistrantID"







