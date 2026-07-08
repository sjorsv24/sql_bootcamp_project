/* what skills are needed for these 
top paying rolls? */

/* in this version we use inner join, cause
with left join you can add jobs that maybe dont have skills listed,
if you do inner join you make sure that all jobs posted have skills listed aswell*/

WITH topten_analyst AS (SELECT job_id, job_schedule_type, 
salary_year_avg, job_posted_date, job_country, dim.name
FROM job_postings_fact AS jobfacts
LEFT JOIN company_dim AS dim
ON jobfacts.company_id = dim.company_id
WHERE job_location = 'Anywhere' AND job_title = 'Data Analyst'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10) 

SELECT topten_analyst.*, skillsdim.skills
FROM topten_analyst
INNER JOIN skills_job_dim as jobdim ON topten_analyst.job_id = jobdim.job_id
INNER JOIN skills_dim as skillsdim ON jobdim.skill_id = skillsdim.skill_id
ORDER BY topten_analyst.salary_year_avg DESC


-- i remove 'anywhere'
-- i make it 50 highest paid results instead of 10

WITH topfifty_analyst AS (SELECT job_id, job_schedule_type, 
salary_year_avg, job_posted_date, job_country, dim.name
FROM job_postings_fact AS jobfacts
LEFT JOIN company_dim AS dim
ON jobfacts.company_id = dim.company_id
WHERE job_title = 'Data Analyst'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 50) 

SELECT topfifty_analyst.*, skillsdim.skills
FROM topfifty_analyst
INNER JOIN skills_job_dim as jobdim ON topfifty_analyst.job_id = jobdim.job_id
INNER JOIN skills_dim as skillsdim ON jobdim.skill_id = skillsdim.skill_id
ORDER BY topfifty_analyst.salary_year_avg DESC


/* Wat valt op?
Python is duidelijk de belangrijkste skill. Vrijwel alle goedbetaalde datafuncties vragen Python.
SQL staat bijna net zo hoog. Dat bevestigt dat SQL een absolute kernvaardigheid is voor data-analisten en data scientists.
R komt verrassend vaak voor. Hoewel Python populairder is, blijft R relevant voor statistische en analytische functies.
BI-tools zijn sterk vertegenwoordigd. Tableau, Looker en Power BI komen samen 8 keer voor.
Cloudkennis (AWS, GCP, BigQuery) komt regelmatig terug. Dat laat zien dat moderne datafuncties steeds vaker met cloudplatformen werken.
Excel staat nog steeds in de top. Ondanks alle moderne tools blijft Excel een gevraagde basisvaardigheid.
Pandas en Scikit-learn komen minder vaak voor. Dat suggereert dat vacatures vaker algemene programmeertalen noemen (Python) dan specifieke libraries.*/

/* [
  {
    "job_id": 1246069,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-12-08 09:16:37",
    "job_country": "United Kingdom",
    "name": "Plexus Resource Solutions",
    "skills": "python"
  },
  {
    "job_id": 1246069,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-12-08 09:16:37",
    "job_country": "United Kingdom",
    "name": "Plexus Resource Solutions",
    "skills": "mysql"
  },
  {
    "job_id": 1246069,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-12-08 09:16:37",
    "job_country": "United Kingdom",
    "name": "Plexus Resource Solutions",
    "skills": "aws"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "sql"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "python"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "r"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "sas"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "matlab"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "pandas"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "tableau"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "looker"
  },
  {
    "job_id": 712473,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19",
    "job_country": "United States",
    "name": "Get It Recruit - Information Technology",
    "skills": "sas"
  },
  {
    "job_id": 456042,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "151500.0",
    "job_posted_date": "2023-09-25 10:59:56",
    "job_country": "United States",
    "name": "Get It Recruit - Healthcare",
    "skills": "sql"
  },
  {
    "job_id": 456042,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "151500.0",
    "job_posted_date": "2023-09-25 10:59:56",
    "job_country": "United States",
    "name": "Get It Recruit - Healthcare",
    "skills": "python"
  },
  {
    "job_id": 456042,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "151500.0",
    "job_posted_date": "2023-09-25 10:59:56",
    "job_country": "United States",
    "name": "Get It Recruit - Healthcare",
    "skills": "r"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "sql"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "python"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "r"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "golang"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "elasticsearch"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "aws"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "bigquery"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "gcp"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "pandas"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "scikit-learn"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "looker"
  },
  {
    "job_id": 479485,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-03-15 16:59:55",
    "job_country": "United States",
    "name": "Level",
    "skills": "kubernetes"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "python"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "java"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "r"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "javascript"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "c++"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "tableau"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "power bi"
  },
  {
    "job_id": 405581,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "145000.0",
    "job_posted_date": "2023-05-01 13:00:20",
    "job_country": "United States",
    "name": "CyberCoders",
    "skills": "qlik"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "sql"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "python"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "r"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "swift"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "excel"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "tableau"
  },
  {
    "job_id": 1090975,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "140500.0",
    "job_posted_date": "2023-03-24 07:06:43",
    "job_country": "United States",
    "name": "Uber",
    "skills": "looker"
  },
  {
    "job_id": 1482852,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "138500.0",
    "job_posted_date": "2023-11-23 12:38:59",
    "job_country": "Greece",
    "name": "Overmind",
    "skills": "sql"
  },
  {
    "job_id": 1482852,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "138500.0",
    "job_posted_date": "2023-11-23 12:38:59",
    "job_country": "Greece",
    "name": "Overmind",
    "skills": "python"
  },
  {
    "job_id": 479965,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "135000.0",
    "job_posted_date": "2023-02-26 01:04:44",
    "job_country": "United States",
    "name": "InvestM Technology LLC",
    "skills": "sql"
  },
  {
    "job_id": 479965,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "135000.0",
    "job_posted_date": "2023-02-26 01:04:44",
    "job_country": "United States",
    "name": "InvestM Technology LLC",
    "skills": "excel"
  },
  {
    "job_id": 479965,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "135000.0",
    "job_posted_date": "2023-02-26 01:04:44",
    "job_country": "United States",
    "name": "InvestM Technology LLC",
    "skills": "power bi"
  },
  {
    "job_id": 1326467,
    "job_schedule_type": "Full-time",
    "salary_year_avg": "135000.0",
    "job_posted_date": "2023-06-26 17:00:18",
    "job_country": "United States",
    "name": "EPIC Brokers",
    "skills": "excel"
  }
]*/