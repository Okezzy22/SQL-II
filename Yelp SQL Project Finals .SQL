--Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet--

--This is a 2-part assignment. In the first part, you are asked a series of questions that will help you profile and understand the data just like a data scientist would. For this first part of the assignment, you will be assessed both on the correctness of your findings, as well as the code you used to arrive at your answer. You will be graded on how easy your code is to read, so remember to use proper formatting and comments where necessary.

--In the second part of the assignment, you are asked to come up with your own inferences and analysis of the data for a particular research question you want to answer. You will be required to prepare the dataset for the analysis you choose to do. As with the first part, you will be graded, in part, on how easy your code is to read, so use proper formatting and comments to illustrate and communicate your intent as required.

--For both parts of this assignment, use this "worksheet." It provides all the questions you are being asked, and your job will be to transfer your answers and SQL coding where indicated into this worksheet so 	
that your peers can review your work. You should be able to use any Text Editor (Windows Notepad, Apple TextEdit, Notepad ++, Sublime Text, etc.) to copy and paste your answers. If you are going to use Word or some other page layout application, just be careful to make sure your answers and code are lined appropriately.
In this case, you may want to save as a PDF to ensure your formatting remains intact for you reviewer.



Part 1: Yelp Dataset Profiling and Understanding

1. Profile the data by finding the total number of records for each of the tables below:

	Table        SQL Query                       Result

i. Attribute table = SELECT Count(*) FROM attribute = 10000

ii. Business table = SELECT Count(*) FROM business = 10000

iii. Category table = SELECT Count(*) FROM category = 10000

iv. Checkin table = SELECT Count(*) FROM checkin = 10000

v. elite_years table = SELECT Count(*) FROM elite_years = 10000

vi. friend table = SELECT Count(*) FROM friend = 10000

vii. hours table = SELECT Count(*) FROM hours = 10000

viii. photo table = SELECT Count(*) FROM photo = 10000

ix. review table = SELECT Count(*) FROM review = 10000

x. tip table = SELECT Count(*)FROM tip = 10000

xi. user table = SELECT Count(*) FROM user = 10000
	


2. Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.

     Table         SQL Query                            Result

i. Business = SELECT Count(distinct id) FROM business = 10000

ii. Hours = SELECT Count(distinct business_id) FROM hours = 1562

iii. Category = SELECT Count(distinct business_id)FROM category = 2643

iv. Attribute = SELECT Count(distinct business_id) FROM attribute = 1115

v. Review = SELECT Count(distinct id) FROM review = 10000
	    SELECT Count(distinct business_id) FROM review = 8090
            SELECT Count(distinct user_id) FROM review = 9581
 

vi. Checkin = SELECT Count(distinct business_id) FROM checkin = 493

vii. Photo = SELECT Count(distinct id) FROM photo = 10000
	     SELECT Count(distinct business_id)FROM photo = 6493

viii. Tip = SELECT Count(distinct user_id) FROM tip = 537
	    SELECT Count(distinct business_id) FROM tip = 3979

ix. User = SELECT Count(distinct id) FROM user = 10000

x. Friend = SELECT Count(distinct user_id) FROM friend = 11

xi. Elite_years = SELECT Count(distinct user_id) FROM friend = 2780

Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon.	



3. Are there any columns with null values in the Users table? Indicate "yes," or "no."

	Answer: No (Queried the user table and there are no null values)
	
	
	SQL code used to arrive at answer:
	
	SELECT COUNT(*)
	FROM user
	WHERE id IS NULL
	OR name IS NULL
	OR review_count IS NULL
	OR yelping_since IS NULL
	OR useful IS NULL
	OR funny IS NULL
	OR cool IS NULL
	OR fans IS NULL
	OR average_stars IS NULL
	OR compliment_hot IS NULL
	OR compliment_more IS NULL
	OR compliment_profile IS NULL
	OR compliment_cute IS NULL
	OR compliment_list IS NULL
	OR compliment_note IS NULL
	OR compliment_plain IS NULL
	OR compliment_cool IS NULL
	OR compliment_funny IS NULL
	OR compliment_writer IS NULL
	OR compliment_photos IS NULL

	
4. For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	i. Table: Review, Column: Stars 

		SELECT min(stars) FROM review

		SELECT max(stars) FROM review
		
		SELECT avg(stars) FROM review

		min: 1		max:	5	avg: 3.7082 
		
	
	ii. Table: Business, Column: Stars

		SELECT min(stars) FROM business

		SELECT max(stars) FROM business

		SELECT avg(stars) FROM business
	
		min:	1	max:	5	avg: 3.6549 
		
	
	iii. Table: Tip, Column: Likes

		SELECT min(likes) FROM tip

		SELECT max(likes) FROM tip

		SELECT avg(likes) FROM tip

		min:	0	max: 2		avg: 0.0144
		
	
	iv. Table: Checkin, Column: Count

		SELECT min(count) FROM checkin

		SELECT max(count) FROM checkin

		SELECT avg(count) FROM checkin
			
		min:	1	max:	53	avg: 1.9414
		
	
	v. Table: User, Column: Review_count

		SELECT min(review_count) FROM user

		SELECT max(review_count) FROM user

		SELECT avg(review_count) FROM user
	
		min:	0	max:	2000	avg: 24.2995
		


5. List the cities with the most reviews in descending order:

	SQL code used to arrive at answer:
SELECT 
  city, 
   sum(review_count) as total_review
FROM business
GROUP BY city
ORDER BY total_review DESC

	
	Copy and Paste the Result Below:

+-----------------+--------------+
| city            | total_review |
+-----------------+--------------+
| Las Vegas       |        82854 |
| Phoenix         |        34503 |
| Toronto         |        24113 |
| Scottsdale      |        20614 |
| Charlotte       |        12523 |
| Henderson       |        10871 |
| Tempe           |        10504 |
| Pittsburgh      |         9798 |
| Montréal        |         9448 |
| Chandler        |         8112 |
| Mesa            |         6875 |
| Gilbert         |         6380 |
| Cleveland       |         5593 |
| Madison         |         5265 |
| Glendale        |         4406 |
| Mississauga     |         3814 |
| Edinburgh       |         2792 |
| Peoria          |         2624 |
| North Las Vegas |         2438 |
| Markham         |         2352 |
| Champaign       |         2029 |
| Stuttgart       |         1849 |
| Surprise        |         1520 |
| Lakewood        |         1465 |
| Goodyear        |         1155 |
+-----------------+--------------+
(Output limit exceeded, 25 of 362 total rows shown)
	
6. Find the distribution of star ratings to the business in the following cities:

i. Avon

SQL code used to arrive at answer:

SELECT 
    stars, 
    sum(review_count) AS [Star Rating Count]
FROM business
WHERE city = "Avon"
GROUP BY stars


Copy and Paste the Resulting Table Below (2 columns – star rating and count):
+-------+-------------------+
| stars | Star Rating Count |
+-------+-------------------+
|   1.5 |                10 |
|   2.5 |                 6 |
|   3.5 |                88 |
|   4.0 |                21 |
|   4.5 |                31 |
|   5.0 |                 3 |
+-------+-------------------+

ii. Beachwood

SQL code used to arrive at answer:

SELECT 
    stars, 
    sum(review_count) AS [Star Rating Count]
FROM business
WHERE city = "Beachwood"
GROUP BY stars


Copy and Paste the Resulting Table Below (2 columns – star rating and count):
+-------+-------------------+
| stars | Star Rating Count |
+-------+-------------------+
|   2.0 |                 8 |
|   2.5 |                 3 |
|   3.0 |                11 |
|   3.5 |                 6 |
|   4.0 |                69 |
|   4.5 |                17 |
|   5.0 |                23 |
+-------+-------------------+
		


7. Find the top 3 users based on their total number of reviews:
		
	SQL code used to arrive at answer:
SELECT 
    name, 
    sum(review_count) AS Review
FROM user
GROUP BY id
ORDER BY review DESC
LIMIT 3

	
		
	Copy and Paste the Result Below:
+--------+--------+
| name   | Review |
+--------+--------+
| Gerald |   2000 |
| Sara   |   1629 |
| Yuri   |   1339 |
+--------+--------+
		


8. Does posing more reviews correlate with more fans?

	Please explain your findings and interpretation of the results:

Ans: 
No, there are no correlation, because based of the results below we can see that review has a higher number than fans, Gerald has a total review of 2000 with 253 fans and Eric has a total review of 1116 with 16 fans the numbers are way too distant therefore there are no correlation.

SQL Code:
SELECT 
    name, 
    sum(review_count) AS Review, 
    fans,
    sum(review_count)/fans AS [Average Fan Review]
FROM user
GROUP BY id
ORDER BY review DESC

Result:
+-----------+--------+------+--------------------+
| name      | Review | fans | Average Fan Review |
+-----------+--------+------+--------------------+
| Gerald    |   2000 |  253 |                  7 |
| Sara      |   1629 |   50 |                 32 |
| Yuri      |   1339 |   76 |                 17 |
| .Hon      |   1246 |  101 |                 12 |
| William   |   1215 |  126 |                  9 |
| Harald    |   1153 |  311 |                  3 |
| eric      |   1116 |   16 |                 69 |
| Roanna    |   1039 |  104 |                  9 |
| Mimi      |    968 |  497 |                  1 |
| Christine |    930 |  173 |                  5 |
| Ed        |    904 |   38 |                 23 |
| Nicole    |    864 |   43 |                 20 |
| Fran      |    862 |  124 |                  6 |
| Mark      |    861 |  115 |                  7 |
| Christina |    842 |   85 |                  9 |
| Dominic   |    836 |   37 |                 22 |
| Lissa     |    834 |  120 |                  6 |
| Lisa      |    813 |  159 |                  5 |
| Alison    |    775 |   61 |                 12 |
| Sui       |    754 |   78 |                  9 |
| Tim       |    702 |   35 |                 20 |
| L         |    696 |   10 |                 69 |
| Angela    |    694 |  101 |                  6 |
| Crissy    |    676 |   25 |                 27 |
| Lyn       |    675 |   45 |                 15 |
+-----------+--------+------+--------------------+
(Output limit exceeded, 25 of 10000 total rows shown)

	

	
9. Are there more reviews with the word "love" or with the word "hate" in them?

	Answer: from the result below we can then the word "love" had more review than "hate".


	
	SQL code used to arrive at answer:
SELECT  
    feelings, 
    count(*) AS total_count
FROM (SELECT 
      CASE  WHEN text LIKE "%love%" THEN "love"
            WHEN text LIKE "%hate%" THEN "hate"
            ELSE "Others"
            END feelings
      FROM review)
GROUP BY feelings
ORDER BY total_count DESC

	Result:
+----------+-------------+
| feelings | total_count |
+----------+-------------+
| Others   |        8042 |
| love     |        1780 |
| hate     |         178 |
+----------+-------------+


	
	
10. Find the top 10 users with the most fans:

	SQL code used to arrive at answer:

SELECT 
    NAME, 
    MAX(FANS) AS [Most Fans]
FROM USER
GROUP BY NAME
ORDER BY MAX(FANS) DESC
LIMIT 10



	
	Copy and Paste the Result Below:
+-----------+-----------+
| name      | Most Fans |
+-----------+-----------+
| Amy       |       503 |
| Mimi      |       497 |
| Harald    |       311 |
| Gerald    |       253 |
| Christine |       173 |
| Lisa      |       159 |
| Cat       |       133 |
| William   |       126 |
| Fran      |       124 |
| Lissa     |       120 |
+-----------+-----------+
	
		

Part 2: Inferences and Analysis

1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.

	Ans: 
I Picked Phoenix as my city and Restaurants as category.

	SQL Code: 
SELECT 
count(distinct business.id) AS [company count],
name,
city, 
c.category,
h.hours AS [working hours],
        CASE WHEN stars >= 4 THEN "4-5 stars"
             WHEN stars >= 2 THEN "2-3 stars"
             ELSE "below 2"
             END [ratings rank]
FROM business
INNER JOIN hours h ON business.id = h.business_id
INNER JOIN category c ON business.id = c.business_id
WHERE city = "Phoenix" AND c.category = "Restaurants"
GROUP BY [ratings rank]

	Results:
+---------------+----------------------------------------+---------+-------------+----------------------+--------------+
| company count | name                                   | city    | category    | working hours        | ratings rank |
+---------------+----------------------------------------+---------+-------------+----------------------+--------------+
|             3 | Gallagher's                            | Phoenix | Restaurants | Saturday|9:00-2:00   | 2-3 stars    |
|             2 | Bootleggers Modern American Smokehouse | Phoenix | Restaurants | Saturday|11:00-22:00 | 4-5 stars    |
+---------------+----------------------------------------+---------+-------------+----------------------+--------------+
  
	
i. Do the two groups you chose to analyze have a different distribution of hours?

Ans: Based on Analysis they do have different distribution of hours, Restaurant- Gallagher's working hour is Saturday|9:00-2:00 and falls under the range of 2-3 stars 
as compared to Restaurant- Bootleggers Modern American Smokehouse working hour is Saturday|11:00-22:00 and has a rating of 4-5 stars, it can be said that the restaurant
with the most rating opens late.


ii. Do the two groups you chose to analyze have a different number of reviews?

	Ans: 
Yes they do have different number of reviews, Bootleggers Modern American Smokehouse Restaurant has the highest number of review with a total of 626.
	
	SQL Code: 
SELECT 
name,
city, 
c.category,
count(distinct business.id) AS [company count],
sum(review_count) as [total review],
        CASE WHEN stars >= 4 THEN "4-5 stars"
             WHEN stars >= 2 THEN "2-3 stars"
             ELSE "below 2"
             END [ratings rank]
FROM business
INNER JOIN category c ON business.id = c.business_id
WHERE city = "Phoenix" AND c.category = "Restaurants"
GROUP BY [ratings rank]

	Result: 
+----------------------------------------+---------+-------------+---------------+--------------+--------------+
| name                                   | city    | category    | company count | total review | ratings rank |
+----------------------------------------+---------+-------------+---------------+--------------+--------------+
| Gallagher's                            | Phoenix | Restaurants |             3 |          131 | 2-3 stars    |
| Bootleggers Modern American Smokehouse | Phoenix | Restaurants |             3 |          626 | 4-5 stars    |
+----------------------------------------+---------+-------------+---------------+--------------+--------------+
     
         
iii. Are you able to infer anything from the location data provided between these two groups? Explain.

SQL code used for analysis:
SELECT 
name,
city, 
address,
postal_code as [postal Code],
        CASE WHEN stars >= 4 THEN "4-5 stars"
             WHEN stars >= 2 THEN "2-3 stars"
             ELSE "below 2"
             END [ratings rank]
FROM business
INNER JOIN category c ON business.id = c.business_id
WHERE city = "Phoenix" AND c.category = "Restaurants"
ORDER BY [ratings rank] DESC

Result:
+----------------------------------------+---------+-------------------------+-------------+--------------+
| name                                   | city    | address                 | postal Code | ratings rank |
+----------------------------------------+---------+-------------------------+-------------+--------------+
| Charlie D's Catfish & Chicken          | Phoenix | 1153 E Jefferson St     | 85034       | 4-5 stars    |
| Matt's Big Breakfast                   | Phoenix | 3118 E Camelback Rd     | 85016       | 4-5 stars    |
| Bootleggers Modern American Smokehouse | Phoenix | 3375 E Shea Blvd        | 85028       | 4-5 stars    |
| Five Guys                              | Phoenix | 2641 N 44th St, Ste 100 | 85008       | 2-3 stars    |
| McDonald's                             | Phoenix | 1850 S 7th St           | 85004       | 2-3 stars    |
| Gallagher's                            | Phoenix | 751 E Union Hls Dr      | 85024       | 2-3 stars    |
+----------------------------------------+---------+-------------------------+-------------+--------------+


Ans: Not really but we can see that all restaurants regardless of their ratings have different address and Postal Code.


		
		
2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
i. Difference 1:
From the result below the first difference spotted was the review count there we can see that business that are open had more reviews than the ones closed
   
         
ii. Difference 2:
The second difference is the average rating judging based on the results opened businesses had a higher average rating than the ones closed.
         
         
         
SQL code used for analysis:
SELECT 
Count(review_count) as [review count],
Round(avg(stars), 2) as [average rating],
    case when is_open = '1' then 'open'
         when is_open = '0' then 'closed'
         else 'null'
         end as status
from business
group by status
order by status desc

Result:
+--------------+----------------+--------+
| review count | average rating | status |
+--------------+----------------+--------+
|         8480 |           3.68 | open   |
|         1520 |           3.52 | closed |
+--------------+----------------+--------+
	
	
3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
i. Indicate the type of analysis you chose to do:
    
i'll be performing statistical analysis for business to see the city that has the best healthcare and compare the average rating to the minimum rating
           
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:

To be able to perform the analysis below, first we need to think of the data we will, for this analysis I used city, id, stars and review count from the business table and category from category table. Next we count the number of businesses then we calculate the average ratings, the minimum ratings and the total number of reviews, and then will filter by health using wildcards. I chose the data to see the city that has the best healthcare facilities and compare the their ratings to generate more insights.
                           
                  
iii. Output of your finished dataset:

+------------+----------------------------+--------------------+----------------+---------------+--------------+
| city       | category                   | number of business | average rating | lowest rating | total review |
+------------+----------------------------+--------------------+----------------+---------------+--------------+
| Tempe      | Health & Medical           |                  2 |           4.75 |           4.5 |           18 |
| Las Vegas  | Health & Medical           |                  4 |            4.5 |           4.0 |           36 |
| Mesa       | Health & Medical           |                  1 |            4.5 |           4.5 |           16 |
| Phoenix    | Health & Medical           |                  3 |           4.33 |           3.0 |           41 |
| Charlotte  | Counseling & Mental Health |                  1 |            4.0 |           4.0 |            5 |
| Charlotte  | Health & Medical           |                  1 |            4.0 |           4.0 |            5 |
| Henderson  | Health & Medical           |                  1 |            4.0 |           4.0 |            7 |
| Scottsdale | Health & Medical           |                  1 |            4.0 |           4.0 |           20 |
| Toronto    | Health & Medical           |                  2 |           3.25 |           2.0 |           21 |
| Avondale   | Health & Medical           |                  1 |            3.0 |           3.0 |           30 |
| Peoria     | Health & Medical           |                  1 |            3.0 |           3.0 |            9 |
+------------+----------------------------+--------------------+----------------+---------------+--------------+
         
         
iv. Provide the SQL code you used to create your final dataset:

Select 
b.city,
c.category,
count(b.id) as [number of business],
Round(avg(b.stars), 2) as [average rating],
min(b.stars) as [lowest rating],
sum(b.review_count) as [total review]
from business b 
inner join category c on b.id = c.business_id
where c.category like "%Health%"
group by b.city, c.category
order by [average rating] desc
