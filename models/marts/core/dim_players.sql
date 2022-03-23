with players as (
    select
        player_id,
        season,
        last_name,
        first_name,
        full_name,
        abbr_name,
        height,
        weight,
        birth_place,
        birthplace_city,
        birthplace_state,
        birthplace_country,
        team_name,
        team_id,
        team_alias
    from {{ ref('stg_players_games_sr') }}
)

select * from players