with historical_games as (

    select * from {{ source('ncaa_basketball', 'mbb_historical_tournament_games') }}
    
)

select * from historical_games