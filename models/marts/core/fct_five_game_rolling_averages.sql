with game_summary as (
    select
        name as team_name,
        scheduled_date,
        two_points_made,
        two_points_att,
        three_points_made,
        three_points_att
    from {{ ref('stg_box_scores_v2') }}
    where minutes is not null
),

five_game_summary as (
    select
        team_name,
        scheduled_date,
        sum(two_points_made)
          over (
              partition by team_name
              order by scheduled_date
              rows between 4 preceding and current row
          ) as two_point_made_sum,
        sum(two_points_att)
          over (
              partition by team_name
              order by scheduled_date
              rows between 4 preceding and current row
          ) as two_point_att_sum,
        sum(three_points_made)
          over (
              partition by team_name
              order by scheduled_date
              rows between 4 preceding and current row
          ) as three_point_made_sum,
        sum(two_points_att)
          over (
              partition by team_name
              order by scheduled_date
              rows between 4 preceding and current row
          ) as three_point_att_sum,
        sum(two_points_made)
          over (
              partition by team_name
              order by unix_date(scheduled_date)
              range between 28 preceding and current row
          ) as two_point_made_sum_28,
        sum(two_points_att)
          over (
              partition by team_name
              order by unix_date(scheduled_date)
              range between 28 preceding and current row
          ) as two_point_att_sum_28,
        sum(three_points_made)
          over (
              partition by team_name
             order by unix_date(scheduled_date)
              range between 28 preceding and current row
          ) as three_point_made_sum_28,
        sum(two_points_att)
          over (
              partition by team_name
              order by unix_date(scheduled_date)
              range between 28 preceding and current row
          ) as three_point_att_sum_28
    
    from game_summary
)

select
  team_name,
  scheduled_date,
  round(safe_divide(two_point_made_sum, two_point_att_sum) * 100, 2) as two_point_5_game_pct,
  round(safe_divide(three_point_made_sum, three_point_att_sum) * 100, 2) as three_point_pct_5_game_pct,
  round(safe_divide(two_point_made_sum_28, two_point_att_sum_28) * 100, 2) as two_point_28_day_pct,
  round(safe_divide(three_point_made_sum_28, three_point_att_sum_28) * 100, 2) as three_point_pct_28_day_pct,
from five_game_summary
order by 1,2

    