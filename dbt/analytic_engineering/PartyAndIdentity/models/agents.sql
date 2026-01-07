{{ config(
    schema = '"PartyAndIdentity"',
    pre_hook = "TRUNCATE TABLE if exists {{ this }}",
    tags = ["salesforce"]
) }}


select 
a."Id" as agent_id,
a."APLID__c" as APLID__c,
a."SalesforceID18Digit__c" as sfdc_id,
a."ParentId" as parent_id,
a."AssistantEMail__c" as email,
a."Fax" as FAX,
u."Phone" as phone,
a."AdvisorFirmFidelityBlockTradeAcct__c" as fidelity_block_trade_account,
a."AgentIDFname__c" as first_name,
a."AgentIDLname__c" as last_name,
a."AgentIDMname__c" as middle_name,
concat(first_name,' ',middle_name,' ',last_name) as name,
u."Phone" as mobile,
u."City" as city,    
u."State" as state,
u."Street" as street,
u."PostalCode" as zip_code,
a."AgentIDFname__c" as agent_first_name,
a."AgentIDLname__c" as agent_last_name,
a."AgentIDMname__c" as agent_middle_name,
a."AgentType__c" as agent_type,
a."Agreement_Date__c" as agreement_date,
a."AllowedFAALevel__c" as allowed_faa_level,
a."AssistantEMail__c" as assistant_email,
a."AssistantName__c" as assistant_name,
a."AssistantPhone__c" as assistant_phone,
a."OwnerId" as OWNER_ID,
a."PrimaryAdvisor__c" as primary_advisor,
a."RecordTypeId" as RECORD_TYPE_ID,
rt."Name" as record_type_name,
rt."Description" as Description,
a."Status__c" as status,
a."NetContributionsTotal__c" as net_contribution_total,
a."Total_AUM__c" as total_aum,
a."Contract_Number__c" as contract_number
from {{ref('project_salesforce', 'account')}} a
left join {{ ref('project_salesforce', 'user') }} u
    on a."OwnerId" = u."Id"
left join {{ref('project_salesforce', 'recordtype')}}  rt
    on a."RecordTypeId" = rt."Id"
   and rt."SobjectType" = 'Account'
where ("APLID__c" like 'AG%' or "RecordTypeId" = '012600000009MsPAAU')
and a.DBT_VALID_TO is null
