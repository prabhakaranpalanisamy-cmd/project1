select 
*
{{ add_audit_columns() }}
from 
{{ source('silver', 'ACCOUNT') }}