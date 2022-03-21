with box_scores as (

    select * from {{ source('ncaa_basketball', 'mbb_games_sr') }}
    
)

select * from box_scores