/*
UNION
    - combine results from two or more SELECT statements
    - They need to have the same amount of columns, and the data type must match
    - Gets rid of duplicate rows >> All rows are unique
*/

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

/*
UNION ALL
    - combine the result of two or more SELECT statements
    - They need to have the same amount of columns, and the data type must match
    - Returns all rows, even duplicates >>
        Personal note: I mostly use this to combine two tables together
*/

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;


/*
Practice problem 8
Find job postings from the first quarter that have a salary greater than $70K
    - Combine job posting tables from the first quarter of 2023 (Jan-Mar)
    - Gets job postings with an average yearly salary > $70,000
*/


SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;
