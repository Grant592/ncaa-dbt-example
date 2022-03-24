with two_play_window as (

    select
        season,
        game_id,
        team_name,
        case 
          when home_name = team_name then 'home' 
          when away_name = team_name then 'away' 
          else null end as home_away,
        event_type,
        lead(team_name, 1) 
          over(
              partition by game_id
              order by timestamp
          ) as next_event_team_name,
        lead(event_type, 1) 
          over(
              partition by game_id
              order by timestamp
          ) as next_event
    from
        {{ ref('stg_play_by_play') }}

    order by game_id, timestamp
)

select * from two_play_window