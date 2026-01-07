{% snapshot user %}

{{
    config(
        target_database = 'silver',
        target_schema='"salesforce"',             
        unique_key = ['"Id"'],   
        strategy='timestamp',             
        updated_at='last_modified_date_'           
    )
}}
select * exclude("LastModifiedDate") from (
SELECT
    *,
    CAST("LastModifiedDate" AS TIMESTAMP) AS last_modified_date_
FROM {{ source('bronze', 'User') }})
{% endsnapshot %}