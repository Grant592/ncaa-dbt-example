with historical_seasons as (

    select * from {{ source('ncaa_basketball', 'mbb_historical_teams_seasons') }}
    
)

select * from historical_seasons