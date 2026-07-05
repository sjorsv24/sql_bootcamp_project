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

/* what skills are needed for these 
top paying rolls? */



WITH topten_analyst AS (SELECT job_id, job_title, job_location, job_schedule_type, 
salary_year_avg, job_posted_date, job_country, dim.name
FROM job_postings_fact AS jobfacts
LEFT JOIN company_dim AS dim
ON jobfacts.company_id = dim.company_id
WHERE job_location = 'Anywhere' AND job_title = 'Data Analyst'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10) 

SELECT skillsdim.skills, COUNT (*) AS countskill
FROM topten_analyst
LEFT JOIN skills_job_dim as jobdim ON topten_analyst.job_id = jobdim.job_id
LEFT JOIN skills_dim as skillsdim ON jobdim.skill_id = skillsdim.skill_id
GROUP BY skillsdim.skills
ORDER BY countskill DESC

/* what are the most in demand
skills for data analyst? */



WITH data_analyst AS (SELECT job_id, job_title, job_location, job_schedule_type, 
salary_year_avg, job_posted_date, job_country
FROM job_postings_fact 
WHERE job_title = 'Data Analyst'
AND salary_year_avg IS NOT NULL) 

SELECT skillsdim.skills, COUNT (*) AS countskill
FROM data_analyst
LEFT JOIN skills_job_dim as jobdim ON data_analyst.job_id = jobdim.job_id
LEFT JOIN skills_dim as skillsdim ON jobdim.skill_id = skillsdim.skill_id
GROUP BY skillsdim.skills
ORDER BY countskill DESC;

/* what are the top skills based on salary
for my role? */

WITH data_analyst AS (SELECT job_id, job_title,
CASE 
WHEN salary_year_avg BETWEEN 30000 AND 80000 THEN 'Laag'
WHEN salary_year_avg BETWEEN 80000 AND 120000 THEN 'Gemiddeld' 
WHEN salary_year_avg > 120000 THEN 'Hoog' 
END AS salary_rank
FROM job_postings_fact 
WHERE job_title = 'Data Analyst'
AND salary_year_avg IS NOT NULL)

SELECT skillsdim.skills, COUNT (*) AS countskill, data_analyst.salary_rank
FROM data_analyst
LEFT JOIN skills_job_dim as jobdim ON data_analyst.job_id = jobdim.job_id
LEFT JOIN skills_dim as skillsdim ON jobdim.skill_id = skillsdim.skill_id
GROUP BY data_analyst.salary_rank, skillsdim.skills
ORDER BY data_analyst.salary_rank, countskill DESC;

/* what are the most optimal skills to learn?
high demand and high paying */

WITH highpaying_jobs AS (
SELECT job_title, COUNT (*) AS jobtitle_count, 
ROUND (AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact 
WHERE salary_year_avg IS NOT NULL
AND salary_year_avg > 100000
GROUP BY job_title
ORDER BY jobtitle_count DESC)

SELECT highpaying_jobs.job_title, 
highpaying_jobs.average_salary,
skillsdim.skills
FROM
LEFT JOIN skills_job_dim AS jobdim ON highpaying_jobs.job_id = jobdim.job_id
LEFT JOIN skills_dim AS skillsdim ON jobdim.skill_id = skillsdim.skill_id