/* what are the top paying analist jobs?
identify the top 10 highest paying data analyst roles that are available remotely
focuses on job postings with specified salaries (remove nulls)
why? highlight the top paying opportunities for data analysts */

SELECT job_id, job_title, job_location, job_schedule_type, 
salary_year_avg, job_posted_date, job_country, dim.name
FROM job_postings_fact AS jobfacts
LEFT JOIN company_dim AS dim
ON jobfacts.company_id = dim.company_id
WHERE job_location = 'Anywhere' AND job_title = 'Data Analyst'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

