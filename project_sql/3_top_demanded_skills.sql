/*
Question: What are the most in-demand skills for data analyst?
- join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst role
- Why? Retrieves the top 5 skills with the highest demand in the job market
    providing insights into the most valuable skills for job seekers
*/

select
 skills,
 count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim using (job_id)
inner join skills_dim using (skill_id)
where job_postings_fact.job_title = 'Data Analyst'
group by  skills
order by demand_count desc
limit 100
