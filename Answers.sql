DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id VARCHAR(6),
	type VARCHAR(10),
	title VARCHAR(150),
	director VARCHAR(250),
	casts VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(50),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(50),
	listed_in VARCHAR(250),
	description VARCHAR(250)
);

SELECT * FROM netflix;

SELECT 
	COUNT(*) AS total_content 
FROM netflix;

-- 15 Business Problems

-- 1. Count the number of Movies vs TV Shows

SELECT 
	type, 
	COUNT(*) as total_content
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows

SELECT type,  rating as most_common_rating
FROM (
	SELECT 
		type,
		rating,
		COUNT(*),
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
	FROM netflix
	GROUP BY 1,2
) as t1
WHERE
	ranking = 1;



-- 3. List all movies released in a specific year (e.g., 2020)

SELECT 
	title, 
	release_year,
	type
FROM netflix
WHERE release_year = '2020' AND type = 'Movie';


-- 4. Find the top 5 countries with the most content on Netflix

SELECT 
	UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
	COUNT(*)
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;



-- 5. Identify the longest movie

SELECT title,duration
FROM netflix
WHERE type ='Movie' and duration = (
	SELECT MAX(duration) from netflix
);


-- 6. Find content added in the last 5 years

SELECT 
 	*
FROM netflix
WHERE 
	 TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

	

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT 
 	*,
	director
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';


-- 8. List all TV shows with more than 5 seasons

SELECT
	*
	-- SPLIT_PART(duration,' ',1) as season
FROM netflix
WHERE type = 'TV Show' and SPLIT_PART(duration,' ',1)::numeric > 5 

-- SELECT SPLIT_PART('APPLE,BANANA,CHERRY' , ',', 1)
-- SELECT SPLIT_PART('APPLE,BANANA,CHERRY' , ',', 3)


-- 9. Count the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in,', ')) as genre,
	count(show_id) as total_count
FROM netflix
GROUP BY 1;


-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!

SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY'))as year,
	count(*) as yearly_content,
	ROUND(
	count(*)::numeric /( SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100 
	,2)as average_content_release
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;

-- 11. List all movies that are documentaries

SELECT * FROM netflix
WHERE type = 'Movie' AND listed_in ILIKE '%documentaries%';


-- 12. Find all content without a director
SELECT * FROM netflix
WHERE director is null


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT 
	count(*) as total_movie_salmankhan_appeared
FROM netflix
WHERE casts ILIKE '%Salman Khan%' 
	and type='Movie' 
	and release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;



-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	UNNEST(STRING_TO_ARRAY(casts,', ')) as actors,
	count(show_id)
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

WITH new_table
AS
(
	SELECT 
			show_id,
			description,
			CASE 
			WHEN description ILIKE '%kill%'
			OR
				description ILIKE '%violence%' THEN 'Bad_Content'
			ELSE 'Good_Content'
			END category
	FROM netflix
)
SELECT
	category,
	count(*) AS total_content
FROM new_table
GROUP BY 1
	


