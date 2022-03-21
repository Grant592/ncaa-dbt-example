with historical_games as (

    select * from {{ source('ncaa_basketball', 'mbb_historical_teams_games') }}
    
)

select * from historical_games