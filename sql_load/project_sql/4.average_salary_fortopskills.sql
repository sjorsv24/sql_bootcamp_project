-- what is the average salary associated with the top 5 skills for data analyst

SELECT skillsdim.skills AS skills, count(*) as no_of_skills, ROUND (AVG(jobposting.salary_year_avg), 0) AS average_skill_salary
FROM skills_job_dim AS skillsjobdim
INNER JOIN job_postings_fact as jobposting
ON skillsjobdim.job_id = jobposting.job_id
INNER JOIN skills_dim as skillsdim 
ON skillsjobdim.skill_id = skillsdim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY no_of_skills DESC 
LIMIT 5

-- what are the 15 highest average salary linked to
skill

SELECT skillsdim.skills AS skills, ROUND (AVG(jobposting.salary_year_avg), 0) AS average_skill_salary
FROM skills_job_dim AS skillsjobdim
INNER JOIN job_postings_fact as jobposting
ON skillsjobdim.job_id = jobposting.job_id
INNER JOIN skills_dim as skillsdim 
ON skillsjobdim.skill_id = skillsdim.skill_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_skill_salary DESC
LIMIT 15

/* json results
[
  {
    "skills": "svn",
    "average_skill_salary": "400000"
  },
  {
    "skills": "solidity",
    "average_skill_salary": "179000"
  },
  {
    "skills": "couchbase",
    "average_skill_salary": "160515"
  },
  {
    "skills": "datarobot",
    "average_skill_salary": "155486"
  },
  {
    "skills": "golang",
    "average_skill_salary": "155000"
  },
  {
    "skills": "mxnet",
    "average_skill_salary": "149000"
  },
  {
    "skills": "dplyr",
    "average_skill_salary": "147633"
  },
  {
    "skills": "vmware",
    "average_skill_salary": "147500"
  },
  {
    "skills": "terraform",
    "average_skill_salary": "146734"
  },
  {
    "skills": "twilio",
    "average_skill_salary": "138500"
  },
  {
    "skills": "gitlab",
    "average_skill_salary": "134126"
  },
  {
    "skills": "kafka",
    "average_skill_salary": "129999"
  },
  {
    "skills": "puppet",
    "average_skill_salary": "129820"
  },
  {
    "skills": "keras",
    "average_skill_salary": "127013"
  },
  {
    "skills": "pytorch",
    "average_skill_salary": "125226"
  }
] */ 