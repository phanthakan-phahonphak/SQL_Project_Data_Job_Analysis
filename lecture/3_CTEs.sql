WITH april_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 4
)

SELECT * FROM april_jobs LIMIT 100;

SELECT
    name AS company_name,
    company_id
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = true
);

/*
Find the companies that have the most job openings.
    -Get the total number of job postings per company id (job_postings_fact)
    -Return the total number of jobs with the company name (company_dim)
*/

SELECT * FROM job_postings_fact LIMIT 100;

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT
    cd.name AS company_name,
    cjc.total_jobs
FROM company_dim cd
LEFT JOIN company_job_count cjc ON cd.company_id = cjc.company_id
ORDER BY total_jobs DESC;


/*
Find the companies that have the most job openings in Thailand.
    -Get the total number of job postings per company id (job_postings_fact)
    -Return the total number of jobs with the company name (company_dim)
*/

WITH thailand_company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS th_total_jobs
    FROM job_postings_fact
    WHERE job_location LIKE '%Thailand%'
    GROUP BY company_id
)

SELECT
    cd.name AS company_name,
    cd.link AS company_website,
    cd.link_google AS job_link,
    th.th_total_jobs
FROM company_dim cd
JOIN thailand_company_job_count th
ON cd.company_id = th.company_id
ORDER BY th_total_jobs DESC;

/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim skills_job
    LEFT JOIN job_postings_fact job_postings ON skills_job.job_id = job_postings.job_id
    WHERE 
        job_postings.job_work_from_home = True AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)

SELECT 
    skills.skill_id, 
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON remote_job_skills.skill_id = skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;