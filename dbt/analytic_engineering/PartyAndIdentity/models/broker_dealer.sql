{{ config(
    schema = '"PartyAndIdentity"',
    pre_hook = "TRUNCATE TABLE if exists {{ this }}",
    tags = ["salesforce"]
) }}
select 
    a."Id" as bd_id,
    a."SalesforceID18Digit__c" as sfdc_id,
    a."BDOrBDNetworkName__c" as name,
    a."Agreement_Date__c" as agreement_date,
    COALESCE(a."BillingCity", a."ShippingCity") as city,    
    COALESCE(a."BillingCountry", a."ShippingCountry") as country,
    COALESCE(a."BillingGeocodeAccuracy", a."ShippingGeocodeAccuracy") as geocode_accuracy,
    COALESCE(a."BillingLatitude", a."ShippingLatitude") as latitude,
    COALESCE(a."BillingLongitude", a."ShippingLongitude") as longitude,
    COALESCE(a."BillingPostalCode", a."ShippingPostalCode") as postal_code,
    COALESCE(a."BillingState", a."ShippingState") as state,
    COALESCE(a."BillingStreet", a."ShippingStreet") as street,
    a."Phone" as phone,
    a."Fax" as FAX,
    a."Contract_Number__c" as CONTRACT_NUMBER,
    a."OwnerId" as OWNER_ID,
    u."Id" as owner_user_id,
    u."Name" as owner_name,
    u."Email" as owner_email,
    u."IsActive" as owner_is_active,
    a."ParentId" as PARENT_ID,
    a."RecordTypeId" as RECORDTYPE_ID,
    rt."Name" as record_type_name,
    rt."DeveloperName" as record_type_devname,
    a."BD_Status__c" as status,
    a."BDTypes__c" as type,
    a."NetContributionsTotal__c" as NET_CONTRIBUTIONS_TOTAL,
    a."Total_AUM__c" as TOTAL_AUM
from {{ ref('project_salesforce', 'account') }} a
left join {{ ref('project_salesforce', 'user') }} u
    on a."OwnerId" = u."Id"
left join {{ ref('project_salesforce', 'recordtype') }} rt
    on a."RecordTypeId" = rt."Id"
   and rt."SobjectType" = 'Account'
where (a."APLID__c" like 'BD%'
    or a."RecordTypeId" = '012600000009BINAA2')
 and a.DBT_VALID_TO is null