select ship_region, count(*) as nb_orders from orders group by ship_region order by nb_orders desc;