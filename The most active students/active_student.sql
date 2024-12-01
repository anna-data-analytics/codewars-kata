SELECT
  sc.student_id,
  s.name,
  ac.num_courses,
  sc.highest_scored_course,
  ac.course_list
   
FROM (

    SELECT distinct on (2)
      id, student_id, score as highest_score
      ,course_name||' ('||score||')' AS highest_scored_course
    FROM courses 
    WHERE course_date BETWEEN '2022-10-01' AND '2022-12-31'
    ORDER BY 
      student_id ASC,
      score DESC,
      course_date DESC,
      course_name ASC
      
  ) sc JOIN (

    SELECT
      student_id,
      COUNT(DISTINCT course_name) AS num_courses,
      STRING_AGG (course_name||' ('||course_date||' - '||score||')', ', ' ORDER BY course_date ASC, course_name ASC) AS course_list
    FROM courses
       WHERE course_date BETWEEN '2022-10-01' AND '2022-12-31'
    GROUP BY student_id

   ) ac ON sc.student_id = ac.student_id


  LEFT JOIN students s ON s.id = sc.student_id
  ORDER BY ac.num_courses DESC, sc.highest_score DESC, sc.student_id ASC
  LIMIT 20
