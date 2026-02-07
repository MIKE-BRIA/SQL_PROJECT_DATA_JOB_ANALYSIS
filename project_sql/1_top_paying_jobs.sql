/*
Question: what are the top paying data analyst jobs?
-identify the top 10 highest paying data analyst roles that are available remotely
-focus on job postings with specified salaries
*/

select job_id,
    job_title,
    company_dim.name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::date
from job_postings_fact
left join company_dim using (company_id)
where
    job_title = 'Data Analyst' and
    salary_year_avg is not null and
    job_location = 'Anywhere'
order by salary_year_avg desc
limit 100;
