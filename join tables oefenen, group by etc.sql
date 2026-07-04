SELECT ROUND(AVG(salary_year_avg), 2), p.job_country
FROM job_postings_fact p 
LEFT JOIN company_dim d 
ON p.company_id = d.company_id
WHERE EXTRACT(MONTH FROM p.job_posted_date) IN (3,4,5)
AND salary_year_avg IS NOT NULL
GROUP BY p.job_country;


SELECT CASE
WHEN job_country = 'Netherlands' THEN 'NL'
WHEN job_country = 'United States' THEN 'USA'
ELSE 'whogivesafuck'
END AS land_code, 
ROUND (AVG(salary_year_avg), 2)
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
AND job_title_short = 'Data Analyst'
GROUP BY land_code;

/* -- STAP 1: Data verzamelen en categoriseren met JOIN en CASE
WITH GecategoriseerdeBanen AS (
    SELECT 
        j.job_country,
        j.salary_year_avg,
        CASE 
            SELECT WHEN j.job_title_short LIKE '%Data Analyst%' THEN 'Data & Analytics'
            ELSE 'Other IT'
        END AS job_category
    FROM job_postings_fact j
    JOIN companies_dim c ON j.company_id = c.company_id -- <-- De JOIN
),

-- STAP 2: De tussentijdse berekening (Gemiddelde per land/categorie)
GemiddeldenPerLand AS (
    SELECT 
        job_country,
        job_category,
        AVG(salary_year_avg) AS avg_salary
    FROM GecategoriseerdeBanen -- <-- Gebruikt de vorige CTE!
    GROUP BY job_country, job_category
)

-- STAP 3: Het uiteindelijke filter (Het 2-in-1 probleem oplossen)
SELECT *
FROM GemiddeldenPerLand
WHERE avg_salary > 100000; 

1. Gebruik WHERE ... IN als:
Je de subquery puur gebruikt als een filter (een checklist).

Kenmerk: Je wilt alleen kolommen zien uit de hoofdtabel (zoals company_name). De data uit de subquery zelf (de vacatures) hoef je niet op je scherm te zien; ze bepalen alleen óf een bedrijf getoond mag worden.

Denkwijze: "Geef mij de bedrijven DIE VOORKOMEN IN deze lijst."

2. Gebruik een subquery in de FROM als:
Je de subquery gebruikt om een nieuwe, samengestelde tabel te maken (vaak met een GROUP BY of berekening), waar je vervolgens in je hoofdquery weer uit wilt putten.

Kenmerk: Je hebt geaggregeerde data nodig (zoals een gemiddelde, som of aantal) en die wil je tonen óf combineren met een andere tabel.

Denkwijze: "Bereken eerst per bedrijf het aantal vacatures, noem die uitkomst 'hulptabel X', en laat mij daarna de bedrijfsnaam én dat aantal zien."
*/


/* opdr
find the companies with the most job openings
- get the total number of job postings per company id
- return the total number of jobs with the company name (company_dim)
*/

WITH totalnumberjobs AS (SELECT company_id, COUNT(*) as jobcounts
FROM job_postings_fact AS jobfacts
GROUP BY company_id)

SELECT company_dim.name AS companyname, totalnumberjobs.jobcounts
FROM company_dim
LEFT JOIN totalnumberjobs ON totalnumberjobs.company_id = company_dim.company_id
ORDER BY totalnumberjobs.jobcounts DESC;

/* ok dus de ON maakt niet uit de volgorde. het gaat echt om de LEFT JOIN en wat daar achter komt. 
het gene wat daar achter komt is het gene wat word toegevoegd aan de tabel die al staat in FROM */


SELECT 
    nodim.skill_id, 
    nodim.skills AS skill_name, -- Of een andere kolom uit de basistabel
    sub.preciseskill
FROM 
    skills_dim AS nodim -- Dit is je basistabel (bijv. de tabel met skill-namen)
LEFT JOIN (
    -- Hier staat je subquery die de telling doet
    SELECT 
        skill_id, 
        COUNT(*) AS preciseskill
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
) AS sub ON nodim.skill_id = sub.skill_id -- 'sub' is de alias voor de subquery
ORDER BY sub.preciseskill DESC
LIMIT 5 

