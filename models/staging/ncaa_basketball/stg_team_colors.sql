with team_colors as (

    select * from {{ source('ncaa_basketball', 'team_colors') }}

)

select * from team_colors