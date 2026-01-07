{{ config(
    pre_hook = "TRUNCATE TABLE if exists {{ this }}",
    tags = ["salesforce"]
) }}

select 
    a."Id" as sfdc_id,
    a."BenefitId__c" as benefit_id,
    a."ParentId" as parent_id,
    a."BenefitStatus__c" as BENEFIT_STATUS,
    a."BenefitStatusAccommodationEndDate__c" as BENEFIT_STATUS_ACCOMMODATION_END,
    a."BenefitStatusAccommodationStartDate__c" as BENEFIT_STATUS_ACCOMMODATION_START_DATE,
    a."BenefitStatusAccommodationStatus__c" as BENEFIT_STATUS_ACCOMMODATION_STATUS,
    a."BenefitStatusCalculatedStatus__c" as BENEFIT_STATUS_CALCULATED_STATUS,
    a."BenefitStatusNextEvaluationDate__c" as BENEFIT_STATUS_NEXT_EVALUATION_DATE,
    a."BenefitStatusPreviousStatus__c" as BENEFIT_STATUS_PREVIOUS_STATUS,
    a."BenefitStatusStartDate__c" as BENEFIT_STATUS_START_DATE,
    a."ServiceModel__c" as SERVICE_MODEL,
    a."ServiceModelAccommodationStartDate__c" as SERVICE_MODEL_ACCOMMODATION_START_DATE,
    a."ServiceModelAccommodationEndDate__c" as SERVICE_MODEL_ACCOMMODATION_END_DATE,
    a."ServiceModelAccommodationStatus__c" as SERVICE_MODEL_ACCOMMODATION_STATUS,
    a."ServiceModelCalculatedStatus__c" as SERVICE_MODEL_CALCULATED_STATUS,
    a."ServiceModelStartDate__c" as SERVICE_MODEL_START_DATE,
    a."RecordTypeId" as contact_record_type_id,
    rt."Name" as contact_record_type_name,
    rt."DeveloperName" as contact_record_type_devname,
    a."Status__c" as contact_status,
    a."NetContributionsTotal__c" as net_contribution_total,
    a."Total_AUM__c" as total_aum,
    a."AdvisorEMail__c" as email,
    a."AdvisorFax__c" as fax,
    concat(a."AdvisorFirstName__c",' ',a."AdvisorMiddleName__c",' ',a."AdvisorLastName__c") as name,
    a."AdvisorCity__c" as city,
    null as country,
    a."AdvisorZipCode__c" as postal_code,
    a."AdvisorState__c" as state,
    a."AdvisorStreet__c" as street,
    a."AdvisorPhone__c" as phone,
    a."OwnerId" as OWNER_ID,
    u."Id" as owner_user_id,
    u."Name" as owner_name,
    u."Email" as owner_email,
    u."IsActive" as owner_is_active,
    null ::DATE as setup_date
from {{ ref('project_salesforce', 'stg_salesforce_account') }} a
left join {{ ref('project_salesforce', 'user') }} u
    on a."OwnerId" = u."Id"
left join {{ ref('project_salesforce', 'recordtype') }} rt
    on a."RecordTypeId" = rt."Id"
    and rt."SobjectType" = 'Account'
where a."BenefitId__c" is not null
  --and a.DBT_VALID_TO is null