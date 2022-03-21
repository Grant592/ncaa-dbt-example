with player_box_scores as (

    select * from {{ source('ncaa_basketball', 'mbb_players_games_sr') }}
    
)

select * from player_box_scores