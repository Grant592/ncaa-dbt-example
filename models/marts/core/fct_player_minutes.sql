{% set seasons = dbt_utils.get_column_values(ref('stg_players_games_sr'), 'season') %}

with player_summary as (
    select
        player_id,
        full_name,
        team_name,
        {% for year in seasons | sort %}
            sum(
                case when season = {{ year }}
                  then minutes_int64
                else 0
                end
            ) as season_{{ year }}_minutes
            {%- if not loop.last -%},{%- endif -%}
        {%- endfor %}
        from {{ ref('stg_players_games_sr') }}
        group by 1,2,3
)

select * from player_summary