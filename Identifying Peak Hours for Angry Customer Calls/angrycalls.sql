WITH angry_calls AS (
  SELECT 
    call_id,
    regexp_matches(content, 'F-word', 'g') AS matched, 
    COUNT(call_id) AS f_word_counts
  FROM transcriptions
  GROUP BY transcription_id, matched
  HAVING COUNT(call_id) >= 3 
  ), 

call_stats AS (
  SELECT 
    EXTRACT(HOUR FROM c.timestamp) AS call_hour,
    c.status
  FROM calls c
  JOIN angry_calls ac ON ac.call_id = c.call_id
  WHERE c.status = 'transferred_to_rep'  
  )

SELECT 
  call_hour,
  COUNT(*) AS angry_call_count
FROM call_stats 
GROUP BY call_hour
ORDER BY angry_call_count DESC, call_hour ASC
