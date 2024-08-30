select categories.id as category_id, category, title, views, p.id as post_id
from categories left join lateral (
  select *
  from posts
  where category_id = categories.id
  order by posts.views desc
  limit 2
) p on true
order by category, views desc, post_id
