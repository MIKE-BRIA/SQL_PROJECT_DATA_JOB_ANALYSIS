/*
subqueries are used to create temporary tables within a query and
is mainly used to break down simple queries

while

CTEs are used to create temporary result sets that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement and mainly used to improve readability and organization of complex queries.
*/

-- Example of a subquery

select *
from (SELECT *
      FROM job_postings_fact
      where extract(month from job_posted_date) = 3
     ) as march_jobs
where job_country = 'United States';

select name as company_name
from company_dim
where company_id in (
      select company_id
      from job_postings_fact
      where job_no_degree_mention = true
)






/*
CTE - Common Table Expression : define a temporary result set that you can reference within a SELECT,INSERT,UPDATE, OR DELETE statement.

DEFINED USING THE WITH CLAUSE
*/

with march_jobs as (
      select *
      from job_postings_fact
      where extract(month from job_posted_date) = 3
)

select *
from march_jobs


/*
Find the companies that have the most job openings.
-Get the total number of job posting per company id(job_postings_fact)
-Return the total number of jobs with the company name (company_dim)
*/


with company_job_counts as(
      select company_id,
      count(*) as total_jobs
      from job_postings_fact
      group by company_id
)


select company_dim.name as company_name,
      company_job_counts.total_jobs
from company_dim
left join company_job_counts using (company_id)



---Practice problems

/* Identify the top 5 skills that are most frequently mentioned in job postings. use a subquery to find the skill ids with the highest counts in the skills_job_dim table, then join with the skills_dim table to get the skill names.*/

select skills_dim.skills as skill_name,
      skills_job_dim.skill_id,
      count(*) as skill_count
from skills_job_dim
join skills_dim using (skill_id)
group by skills_dim.skills, skills_job_dim.skill_id
where job_title_short = 'data analyst'
order by skill_count desc
limit 15;

select skills as skills_name
from skills_dim
where skill_id in(
      select skill_id
      from skills_job_dim
      group by skill_id
      order by count(*) desc
      limit 10
)




/* Determine the size category (small,medium,large)for each company by first identifying the number of job postings they have. Use a subquery to calculate the total job postings per company . A company is condiered 'small' if it has less than 10 job postings, 'medium' if the number of job postings is between 10 and 50, and 'large' if it has more than 50 job postings. Implement a subquery to aggregate job counts per company before classifying the based on size*/



/*
determine the size category (small, medium, large) of companies based on the number of job postings they have. Use a CTE to calculate the total number of job postings per company, then categorize them based on predefined thresholds (e.g., small: 1-10 jobs, medium: 11-50 jobs, large: 51+ jobs).
*/
