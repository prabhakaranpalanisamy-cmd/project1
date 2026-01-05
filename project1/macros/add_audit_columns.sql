{% macro add_audit_columns() %}
    , current_timestamp() as created_at
    , current_timestamp() as updated_at
    , current_user() as created_by
{% endmacro %}