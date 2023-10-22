# ActiveUsers

SELECT COUNT(DISTINCT user_id) AS active_users_last_7_days
FROM sessions
WHERE session_start >= CURDATE() - INTERVAL 7 DAY;            # records to only include sessions that started within the last 7 days
