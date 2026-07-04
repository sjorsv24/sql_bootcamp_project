select job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT '2023-02-19'::DATE,
'123'::INTEGER,
'true'::BOOLEAN,
'3.14'::REAL;

SELECT job_title_short AS title,
job_location AS location,
job_posted_date AS date
FROM job_postings_fact;

-- but we only want the date not the timestap with it


SELECT job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS date
FROM job_postings_fact;

-- now we want to change the timezone of the table 
--from utc to est time zone (the original table is utc)

SELECT job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' 
AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 5;

-- now we want to use extract
-- gets year, month, day, time from a date/time value

SELECT job_title_short AS title,
job_location AS location,
EXTRACT (MONTH FROM job_posted_date) AS month,
EXTRACT (YEAR FROM job_posted_date) AS year
FROM job_postings_fact
LIMIT 5;

-- lets group by now
-- how many job postings in each month?

SELECT COUNT(job_id),
EXTRACT (MONTH FROM job_posted_date) AS month 
FROM job_postings_fact
GROUP BY month
ORDER BY month ASC;

-- eigen gemaakte

--chatgpt antw;
--In SQL geldt een gouden regel zodra je een verzamelfunctie zoals COUNT() gebruikt: Elke kolom in je SELECT die géén onderdeel is van een berekening (zoals COUNT, SUM, AVG), 
-- MOET in de GROUP BY staan.

SELECT COUNT(job_id), job_country AS country,
EXTRACT (MONTH FROM job_posted_date) AS month 
FROM job_postings_fact
GROUP BY month, country
ORDER BY country ASC, month ASC;

SELECT COUNT(job_id) AS total_job,
EXTRACT (MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY total_job DESC;

-- opdrachten
-- ik had het eigenlijk gedaan zonder coalesce , 0 maar chatgpt zei dat dit alle NULL resultaten veraderent in 0, schiet eig ook niks op maargoed

SELECT COALESCE(AVG(salary_year_avg), 0) AS salary_year_avg,
COALESCE(AVG (salary_hour_avg), 0) AS salary_hour_avg,
job_schedule_type
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01' 
GROUP BY job_schedule_type;



SELECT COUNT(job_id) AS job_count,
EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' 
AT TIME ZONE 'EST') AS month
FROM job_postings_fact
GROUP BY month
ORDER BY job_count DESC;

-- de alias jobdate mag niet in de WHERE statement

SELECT job_posted_date AS jobdate, company.name
FROM job_postings_fact as job_fact
INNER JOIN company_dim as company
ON company.company_id = job_fact.company_id
WHERE job_health_insurance = TRUE
AND EXTRACT (quarter from job_posted_date) = 2
AND EXTRACT (year from job_posted_date) = 2023;


-- laten we wat dingen toevoegen om m nog beter te krijgen

SELECT DISTINCT company.name
FROM job_postings_fact as job_fact
INNER JOIN company_dim as company
ON company.company_id = job_fact.company_id
WHERE job_health_insurance = TRUE
AND EXTRACT (quarter from job_posted_date) = 2
AND EXTRACT (year from job_posted_date) = 2023
GROUP BY company.name, job_posted_date;

CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT (month from job_posted_date) = 1 AND
EXTRACT (year from job_posted_date) = 2023; 

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT (month from job_posted_date) = 2 AND
EXTRACT (year from job_posted_date) = 2023; 

CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT (month from job_posted_date) = 3 AND
EXTRACT (year from job_posted_date) = 2023; 

SELECT job_posted_date
FROM march_jobs;

-- case expression
-- CASE begins the expression, WHEN specificies the conditions to look at, THEN what to do when the condition is TRUE, ELSE, provides output if none of the conditions are met
-- END concludes the CASE expression
-- very similiar to an IF statement

SELECT
job_title_short,
job_location
FROM job_postings_fact;

-- label new colum as follows
-- 'anywhere' jobs as 'remote'
-- 'new york, ny' jobs as 'local'
-- otherwise 'onsite'

SELECT
job_title_short,
job_location,
CASE
WHEN job_location = 'Anywhere' THEN 'remote'
WHEN job_location = 'New York, NY' THEN 'local'
ELSE 'onsite'
END AS location_category
FROM job_postings_fact;

-- how many jobs can i apply to that are remote, local or onsite

SELECT
COUNT(job_id),
CASE
WHEN job_location = 'Anywhere' THEN 'remote'
WHEN job_location = 'New York, NY' THEN 'local'
ELSE 'onsite'
END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

-- subqueries and CTEs, used for organizing and simplifying complex queries
-- helps break down the query into smaller more managable parts
-- subqueries are for simpler queries, CTEs for more complex
-- it can be used in SELECT FROM and WHERE statements

SELECT *
FROM ( -- subquery starts here
SELECT *
FROM job_postings_fact
WHERE EXTRACT (month FROM job_posted_date) = 1
) AS january_jobs;
--subquery ends here 

SELECT *
FROM job_postings_fact
WHERE EXTRACT (month FROM job_posted_date) = 1;

-- Klopt als een bus! In dit specifieke voorbeeld is het resultaat van beide queries exact hetzelfde. Beide queries geven je alle vacatures die in de maand januari zijn geplaatst.
-- Waarom zou je dan in hemelsnaam die extra moeite doen voor die eerste optie (de subquery)?
--omdat een subquery pas nuttig wordt als je de data daarna wilt bewerken, filteren of combineren op een manier die in één enkele query heel onoverzichtelijk of zelfs onmogelijk wordt.
-- Zie een subquery als het maken van een tijdelijke, virtuele tabel waar je daarna pas je échte actie op loslaat.

-- CTEs (common table expression) can be used in SELECT, INSERT, UPDATE OR DELETE statements
-- defined with WITH 

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;


SELECT company_id,
job_no_degree_mention
FROM job_postings_fact
WHERE job_no_degree_mention = TRUE;

-- now lets add it as subquery

SELECT name AS company_name, company_id
FROM company_dim
WHERE company_id IN (
    SELECT company_id
FROM job_postings_fact
WHERE job_no_degree_mention = TRUE
ORDER BY company_id
);

-- find the company that has the most job openings
-- get the total number of job postings per company_id (job_posting_fact)
-- return the total number of jobs with the company name (company_dim)

 

 