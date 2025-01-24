/*
    Use :: for casting, which means converting a value from one data type to another
    You can use it to convert a host of different data types
        '2023-02-19'::DATE,
        '123'::INT,
        'true'::BOOLEAN,
        '3.14'::REAL
*/

SELECT
    job_title_short AS title,
    job_location    AS location,
    job_posted_date AS date
FROM job_postings_fact
LIMIT 20;

-- ::DATE >> convert value into a date format
SELECT
    job_title_short       AS title,
    job_location          AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 20;

-- AT TIME ZONE >> converts timestamps between different time zones
SELECT
    job_title_short                    AS title,
    job_location                       AS location,
    job_posted_date AT TIME ZONE 'UTC' AS date_time
FROM job_postings_fact
LIMIT 20;

SELECT
    job_title_short                                       AS title,
    job_location                                          AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 20;

-- EXTRACT >> gets field (e.g., year, month, day) from a date/time value
SELECT
    job_title_short                     AS title,
    job_location                        AS location,
    job_posted_date                     AS date,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 20;

SELECT
    COUNT(job_id)                       AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_posted_count;