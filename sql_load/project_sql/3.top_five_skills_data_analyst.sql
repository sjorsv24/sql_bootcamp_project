-- what are the most in demand skills for data analyst?
-- top 5

SELECT skillsdim.skills AS skills, COUNT (skillsjobdim.job_id)
FROM skills_job_dim AS skillsjobdim
INNER JOIN job_postings_fact as jobposting
ON skillsjobdim.job_id = jobposting.job_id
INNER JOIN skills_dim as skillsdim 
ON skillsjobdim.skill_id = skillsdim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY count((skillsjobdim.job_id)) DESC
LIMIT 5

SELECT skillsdim.skills AS skills, COUNT (*)
FROM skills_job_dim AS skillsjobdim
INNER JOIN job_postings_fact as jobposting
ON skillsjobdim.job_id = jobposting.job_id
INNER JOIN skills_dim as skillsdim 
ON skillsjobdim.skill_id = skillsdim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY count (*) DESC
LIMIT 5