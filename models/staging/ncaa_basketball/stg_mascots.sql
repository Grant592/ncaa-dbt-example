with mascots as (

    select * from {{ source('ncaa_basketball', 'mascots') }}
    
)

select * from mascots