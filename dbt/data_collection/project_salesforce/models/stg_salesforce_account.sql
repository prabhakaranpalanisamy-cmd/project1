{{ config(
    schema = '"salesforce"',
    pre_hook = "TRUNCATE TABLE if exists {{ this }}",
    tags = ["salesforce"]
) }}


with source as (
    select * from {{ source('bronze', 'Account') }}
),

renamed as (
    select
        *
    from source
)

select * from renamed
