with teams as (

    select * from {{ source('ncaa_basketball', 'mbb_teams') }}

)

select * from teams