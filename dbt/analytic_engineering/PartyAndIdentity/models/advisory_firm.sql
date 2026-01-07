{{ config(
    schema = '"PartyAndIdentity"',
    pre_hook = "TRUNCATE TABLE if exists {{ this }}",
    tags = ["salesforce"]
) }}



SELECT  
    a."Id" as firm_id,
    a."SalesforceID18Digit__c" as sfdc_id,
    a."Firm_Name__c" as name,
    a."ParentId" as parent_id,
    a."AdvisorCity__c" as city,
    COALESCE(a."BillingCountry", a."ShippingCountry") as country,
    COALESCE(a."BillingGeocodeAccuracy", a."ShippingGeocodeAccuracy") as geocode_accuracy,
    COALESCE(a."BillingLatitude", a."ShippingLatitude") as latitude,
    COALESCE(a."BillingLongitude", a."ShippingLongitude") as longitude,
    COALESCE(a."BillingPostalCode", a."ShippingPostalCode") as postal_code,
    a."AdvisorState__c" as state,
    a."AdvisorStreet__c" as street,
    a."AdvisorPhone__c" as phone,
    a."AdvisorFax__c" as fax,
    a."Contract_Number__c" as contract_number,
    a."OwnerId" as OWNER_ID,
    u."Id" as owner_user_id,
    u."Name" as owner_name,
    u."Email" as owner_email,
    u."IsActive" as owner_is_active,
    a."Agreement_Date__c" as agreement_date,
    a."RecordTypeId" as RECORD_TYPE_ID,
    rt."Name" as record_type_name,
    rt."DeveloperName" as record_type_devname,
    a."Status__c" as status,
    a."AdvisorSegmentationType__c" as type,
    a."NetContributionsTotal__c" as net_contribution_total,
    a."Total_AUM__c" as total_aum
from {{ ref('project_salesforce', 'account') }} a
left join {{ ref('project_salesforce', 'user') }} u
    on a."OwnerId" = u."Id"
left join {{ ref('project_salesforce', 'recordtype') }} rt
    on a."RecordTypeId" = rt."Id"
   and rt."SobjectType" = 'Account'
where (a."APLID__c" LIKE 'AD%' or a."RecordTypeId" = '012600000009BISAA2')
  and a.DBT_VALID_TO is null