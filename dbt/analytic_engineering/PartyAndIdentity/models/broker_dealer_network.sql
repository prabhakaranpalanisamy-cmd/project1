{{ config(
    schema = '"PartyAndIdentity"',
    pre_hook = "TRUNCATE TABLE if exists {{ this }}",
    tags = ["salesforce"]
) }}

SELECT 
a."SalesforceID18Digit__c" as sfdc_id,
a."BDOrBDNetworkName__c" as name,
a."Agreement_Date__c" as agreement_date,
u."City" as city,    
u."Country" as country,
u."GeocodeAccuracy" as geocode_accuracy,
u."Latitude" as latitude,
u."Longitude" as longitude ,
u."PostalCode" as postal_code,
u."State" as state,
u."Street" as street,
a."Phone" as phone,
a."Fax" as FAX,
a."OwnerId" as OWNER_ID,
a."RecordTypeId" as RECORD_TYPE_ID,
rt."Name" as record_type_name,
rt."Description" as Description,
a."BD_Status__c" as status
from {{ ref('project_salesforce', 'account') }} a
left join {{ ref('project_salesforce', 'user') }} u
    on a."OwnerId" = u."Id"
left join {{ ref('project_salesforce', 'recordtype') }} rt
    on a."RecordTypeId" = rt."Id"
   and rt."SobjectType" = 'Account'
where  a."RecordTypeId" = '012600000009Y32AAE'
and a.DBT_VALID_TO is null