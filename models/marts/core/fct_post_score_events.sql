{% set events = ["twopointmiss", "threepointmiss", "twopointmade", "threepointmade"] %}

with two_play_events as (
    select * from {{ ref('games_pbp__windowed') }}
),

percentages as (
    select
        season,
        team_name,
        home_away,
        {% for event1 in events -%}
            {% for event2 in events %}
                safe_divide(
                    count(case 
                        when event_type = '{{ event1 }}' 
                        and next_event = '{{ event2 }}' 
                        and next_event_team_name <> team_name 
                        then 1 
                        else null end),
                    count(case
                        when event_type = '{{ event1 }}' then 1
                        else null end)
                 ) as {{ event1 }}_{{ event2 }}_rate
                {%- if not loop.last -%}, {% endif %}
            {%- endfor %}
            {%- if not loop.last -%}, {%- endif %}
        {%- endfor %}

    from two_play_events
    group by 1,2,3
)

select
    season,
    team_name,
    home_away,

    {% for event1 in events %}
        {% for event2 in events %}
            round({{ event1 }}_{{ event2 }}_rate * 100, 2) as {{ event1 }}_{{ event2 }}_rate {% if not loop.last %}, {% endif %}
        {% endfor %}
        {% if not loop.last %},{% endif %}
    {% endfor %}

 from percentages

 order by team_name, season, home_away
