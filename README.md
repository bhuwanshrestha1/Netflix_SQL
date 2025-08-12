# 📺 Netflix Data Analysis with PostgreSQL

## 📌 Overview

This project analyzes the **Netflix Titles Dataset** using **PostgreSQL** to answer **15 real-world business problems**.  
It involves importing a dataset, creating a database table, and running SQL queries to generate insights about Netflix content.

We use:

- `netflix_titles.csv` → Dataset containing Netflix shows and movies metadata.
- `Business Problems Netlfix.sql` → Problem statements.
- `Answers.sql` → PostgreSQL queries with solutions.

---

## 📂 Files in this Repository

| File                              | Description                                                                                                       |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **netflix_titles.csv**            | Dataset containing Netflix titles with attributes like title, director, cast, country, release year, rating, etc. |
| **Business Problems Netlfix.sql** | Contains 15 business questions to solve using SQL queries.                                                        |
| **Answers.sql**                   | SQL code to create the table and run queries answering each business problem.                                     |

---

## 🗄 Database Table Structure

```sql
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


```

## 📊 Business Problems to Solve

1. Count the number of Movies vs TV Shows.

2. Find the most common rating for movies and TV shows.

3. List all movies released in a specific year (e.g., 2020).

4. Find the top 5 countries with the most content on Netflix.

5. Identify the longest movie.

6. Find content added in the last 5 years.

7. Find all the movies/TV shows by director 'Rajiv Chilaka'.

8. List all TV shows with more than 5 seasons.

9. Count the number of content items in each genre.

10. Find each year and the average numbers of content release in India on Netflix. Return top 5 years with highest average content release.

11. List all movies that are documentaries.

12. Find all content without a director.

13. Find how many movies actor 'Salman Khan' appeared in last 10 years.

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field.

## ⚙️ How to Run

### 1️⃣ Import the CSV into PostgreSQL
If you are using pgAdmin (remote or local PostgreSQL), you can either:

Use the Import/Export Data tool, or

Use the \COPY command:

```sql
\COPY public.netflix
FROM '/path/to/netflix_titles.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    NULL '',
    ENCODING 'UTF8'
);

```
### 2️⃣ Execute the Queries
Open Answers.sql in pgAdmin Query Tool or any PostgreSQL client.

Run the CREATE TABLE statement.

Import the CSV.

Execute queries for each of the 15 business problems.

## 🛠 Requirements

PostgreSQL 13 or later

pgAdmin 4 (optional but recommended)

Basic SQL knowledge

## 📈 Example Query

Find all Salman Khan movies in the last 10 years:

```sql
SELECT 
    title,
    release_year
FROM netflix
WHERE casts ILIKE '%Salman Khan%' 
  AND type = 'Movie' 
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```


