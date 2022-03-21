with play_by_play as (

    select * from {{ source('ncaa_basketball', 'mbb_pbp_sr') }}
    
)

select * from play_by_play