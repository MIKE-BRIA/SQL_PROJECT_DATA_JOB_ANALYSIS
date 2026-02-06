select
    count(job_id) as job_posted_count,
    EXTRACT (MONTH from JOB_POSTED_DATE) AS month
from job_postings_fact
where
job_title_short = 'Data Analyst'
GROUP BY month
order by job_posted_count DESC;

select *
from job_postings_fact
limit 100;

SELECT DISTINCT job_via
FROM job_postings_fact;

CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

select
    job_title_short as title,
    job_location as location
from job_postings_fact


/*
label new column as follows:
 'anywhere' jobs as 'remote'
    'on-site' jobs as 'on-site'
    'hybrid' jobs as 'hybrid'
    otherwise 'Onsite'
*/


select job_title_short as title,
    job_location as location,
    case
        when job_location = 'Anywhere' then 'remote'
        when job_location = 'hybrid' then 'hybrid'
        else 'Onsite'
    end as location_type
from job_postings_fact


SELECT
    job_title_short AS title,
    CASE
        WHEN job_location = 'Anywhere' THEN 'remote'
        WHEN job_location = 'hybrid' THEN 'hybrid'
        ELSE 'onsite'
    END AS location_type,
    COUNT(*) AS job_count
FROM job_postings_fact
GROUP BY
    job_title_short,
    location_type
ORDER BY
    job_title_short,
    location_type;


select job_title_short as title,
        job_country as country_of_job,
        case
            when job_location = 'Anywhere' then 'remote'
            when job_location = 'remote' then 'remote'
            else 'Onsite'
        end as location_type,
        count(*) as job_count
FROM
    job_postings_fact
group by
    title,
    country_of_job,
    location_type

