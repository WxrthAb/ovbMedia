#SubscriptionConcversion

SELECT COUNT(DISTINCT u.user_id) AS subscription_conversion
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 6 MONTH			# only users who have registered in the last 6 months
AND s.subscription_start <= u.registration_date + INTERVAL 30 DAY;	# include only those subscriptions that started within 30 days of the user's registration date
