/* 
find the count of the number of remote job postings per skill
- display the top 5 skills by their demand in remote jobs
- include skill ID, name and count of posting requiring the skill*/

WITH skillper_id AS (
SELECT skill_id, count (*) as skill_count
FROM skills_job_dim AS skillsjob
INNER JOIN job_postings_fact AS jobs
ON skillsjob.job_id = jobs.job_id
WHERE job_work_from_home = TRUE 
GROUP BY skillsjob.skill_id)

SELECT skillper_id.skill_id, skillsdim.skills, skillper_id.skill_count
FROM skillper_id
INNER JOIN skills_dim AS skillsdim 
ON skillper_id.skill_id = skillsdim.skill_id
ORDER BY skillper_id.skill_count DESC
LIMIT 5


-- what are the most in demand skills for data analyst?
-- top 5

SELECT skillsdim.skills AS skills, COUNT(*)
FROM skills_job_dim AS skillsjobdim
INNER JOIN job_postings_fact as jobposting
ON skillsjobdim.job_id = jobposting.job_id
INNER JOIN skills_dim as skillsdim 
ON skillsjobdim.skill_id = skillsdim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY count(*) DESC
LIMIT 5

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

/* what are the top skills based on salary
for my role? */
-- low paying jobs

SELECT skillsdim.skills AS skillsforlowpayingjobs, count(*)
FROM skills_job_dim as jobdimskills
INNER JOIN job_postings_fact AS jobpostings 
ON jobdimskills.job_id = jobpostings.job_id
INNER JOIN skills_dim as skillsdim
ON jobdimskills.skill_id = skillsdim.skill_id
WHERE jobpostings.salary_year_avg BETWEEN 30000 AND 80000
AND jobpostings.job_title_short = 'Data Analyst'
GROUP BY skillsdim.skills
ORDER BY COUNT(*) DESC
LIMIT 5;

/* what are the top skills based on salary
for my role? */
-- middle paying jobs

SELECT skillsdim.skills AS skillsformiddlepayingjobs, count(*)
FROM skills_job_dim as jobdimskills
INNER JOIN job_postings_fact AS jobpostings 
ON jobdimskills.job_id = jobpostings.job_id
INNER JOIN skills_dim as skillsdim
ON jobdimskills.skill_id = skillsdim.skill_id
WHERE jobpostings.salary_year_avg BETWEEN 80000 AND 120000
AND jobpostings.job_title_short = 'Data Analyst'
GROUP BY skillsdim.skills
ORDER BY COUNT(*) DESC
LIMIT 5;
/* what are the top skills based on salary
for my role? */
-- high paying jobs

SELECT skillsdim.skills AS skillsforhighpayingjobs, count(*)
FROM skills_job_dim as jobdimskills
INNER JOIN job_postings_fact AS jobpostings 
ON jobdimskills.job_id = jobpostings.job_id
INNER JOIN skills_dim as skillsdim
ON jobdimskills.skill_id = skillsdim.skill_id
AND jobpostings.job_title_short = 'Data Analyst'
WHERE jobpostings.salary_year_avg > 120000  
GROUP BY skillsdim.skills
ORDER BY COUNT(*) DESC
LIMIT 5;

-- what is the average salary associated with the top 5 skills for data analyst

SELECT skillsdim.skills AS skills, count(*), ROUND (AVG(jobposting.salary_year_avg), 2) AS average_skill_salary
FROM skills_job_dim AS skillsjobdim
INNER JOIN job_postings_fact as jobposting
ON skillsjobdim.job_id = jobposting.job_id
INNER JOIN skills_dim as skillsdim 
ON skillsjobdim.skill_id = skillsdim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY count(*) DESC 
LIMIT 5