#TopContents

SELECT content_id, COUNT(*) AS view_count
FROM sessions
WHERE session_start >= CURDATE() - INTERVAL 30 DAY			 # records to only include sessions that started within the last 30 days
GROUP BY content_id
ORDER BY view_count DESC
LIMIT 5;
