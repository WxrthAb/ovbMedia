create database ovbMedia;									# assigning ovbMedia as database

use ovbMedia;

															# creating first table 

create table users(
user_id varchar (30) primary key,
registration_date date
);	

															#creating second table

create table sessions(
	
    session_id 				varchar (30) primary key,
	user_id  				varchar (30), 										
	content_id  			varchar (30),         							#(ID of the viewed article/video)
	session_start  			datetime,        							#(start time of the session)
	session_end 			datetime
    
);

#creating third table

create table subscriptions(
	
    subscription_id 		varchar (30) primary key,					# (unique identifier) as varchar 
	user_id 				varchar (30),										
	subscription_start 		datetime,								#(start date of the subscription)
	subscription_end 		datetime								#(end date of the subscription, null if still active)
);

# assigning first foreign key 

alter table sessions   
add constraint fk_UsersID_Users								# (foreign key to users table)
foreign key (user_id)references users(user_id);

# assigning second foreign key 

alter table subscriptions
add constraint fk2_UsersID_Users							#(foreign key to users table)
foreign key (user_id)references users(user_id);

insert into users (user_id,registration_date)
values
	(1, '2023-01-01'),
	(2, '2023-02-15'),
	(3, '2023-03-20'),
	(4, '2023-04-25'),
	(5, '2023-05-30');

insert into sessions (session_id,user_id,content_id,session_start, session_end )
values
	(101, 1, 201, '2023-10-01 09:00:00', '2023-10-01 09:30:00'),
	(102, 2, 202, '2023-10-02 10:00:00', '2023-10-02 10:45:00'),
	(103, 3, 201, '2023-10-03 11:00:00', '2023-10-03 11:20:00'),
	(104, 4, 203, '2023-10-04 12:00:00', '2023-10-04 12:30:00'),
	(105, 5, 202, '2023-10-05 13:00:00', '2023-10-05 13:40:00');

insert into subscriptions (subscription_id,user_id,subscription_start,subscription_end )
values
	(301, 1, '2019-01-15 11:00:00', '2020-11-16 19:44:00'),
	(302, 2, '2021-02-20 23:00:00', '2022-09-05 23:34:00'),
	(303, 3, '2020-03-25 17:00:00', '2021-07-25 08:23:00'),
	(304, 4, '2021-05-01 22:00:00', '2023-03-23 02:26:00'),
	(305, 5, '2020-06-05 12:00:00', '2022-02-15 23:30:00');

# ActiveUsers

SELECT COUNT(DISTINCT user_id) AS active_users_last_7_days
FROM sessions
WHERE session_start >= CURDATE() - INTERVAL 7 DAY;            # records to only include sessions that started within the last 7 days

#TopContents

SELECT content_id, COUNT(*) AS view_count
FROM sessions
WHERE session_start >= CURDATE() - INTERVAL 30 DAY			 # records to only include sessions that started within the last 30 days
GROUP BY content_id
ORDER BY view_count DESC
LIMIT 5;

#SubscriptionConcversion

SELECT COUNT(DISTINCT u.user_id) AS subscription_conversion
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 6 MONTH			# only users who have registered in the last 6 months
AND s.subscription_start <= u.registration_date + INTERVAL 30 DAY;	# include only those subscriptions that started within 30 days of the user's registration date



