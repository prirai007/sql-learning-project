/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles

WITH skills_demand AS (
SELECT
skills_dim.skill_id, 
skills_dim.skills,
COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short = 'Data Analyst' AND
job_work_from_home = True AND
salary_year_avg IS NOT NULL
GROUP BY  
skills_dim.skill_id
),
average_salary AS (
SELECT
skills_job_dim.skill_id,
ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short = 'Data Analyst' AND 
salary_year_avg IS NOT NULL AND 
job_work_from_home = True
GROUP BY
skills_job_dim.skill_id
)

SELECT
skills_demand.skill_id,
skills_demand.skills,
demand_count,
average_salary.average_salary
FROM
skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE 
demand_count>15
ORDER BY
average_salary.average_salary DESC,
demand_count DESC
LIMIT 25;

-- -- Query Results:
-- [
--   {
--     "skill_id": 8,
--     "skills": "go",
--     "demand_count": "27",
--     "average_salary": "115320"
--   },
--   {
--     "skill_id": 97,
--     "skills": "hadoop",
--     "demand_count": "22",
--     "average_salary": "113193"
--   },
--   {
--     "skill_id": 80,
--     "skills": "snowflake",
--     "demand_count": "37",
--     "average_salary": "112948"
--   },
--   {
--     "skill_id": 74,
--     "skills": "azure",
--     "demand_count": "34",
--     "average_salary": "111225"
--   },
--   {
--     "skill_id": 76,
--     "skills": "aws",
--     "demand_count": "32",
--     "average_salary": "108317"
--   },
--   {
--     "skill_id": 4,
--     "skills": "java",
--     "demand_count": "17",
--     "average_salary": "106906"
--   },
--   {
--     "skill_id": 233,
--     "skills": "jira",
--     "demand_count": "20",
--     "average_salary": "104918"
--   },
--   {
--     "skill_id": 79,
--     "skills": "oracle",
--     "demand_count": "37",
--     "average_salary": "104534"
--   },
--   {
--     "skill_id": 185,
--     "skills": "looker",
--     "demand_count": "49",
--     "average_salary": "103795"
--   },
--   {
--     "skill_id": 1,
--     "skills": "python",
--     "demand_count": "236",
--     "average_salary": "101397"
--   },
--   {
--     "skill_id": 5,
--     "skills": "r",
--     "demand_count": "148",
--     "average_salary": "100499"
--   },
--   {
--     "skill_id": 78,
--     "skills": "redshift",
--     "demand_count": "16",
--     "average_salary": "99936"
--   },
--   {
--     "skill_id": 182,
--     "skills": "tableau",
--     "demand_count": "230",
--     "average_salary": "99288"
--   },
--   {
--     "skill_id": 186,
--     "skills": "sas",
--     "demand_count": "63",
--     "average_salary": "98902"
--   },
--   {
--     "skill_id": 7,
--     "skills": "sas",
--     "demand_count": "63",
--     "average_salary": "98902"
--   },
--   {
--     "skill_id": 61,
--     "skills": "sql server",
--     "demand_count": "35",
--     "average_salary": "97786"
--   },
--   {
--     "skill_id": 9,
--     "skills": "javascript",
--     "demand_count": "20",
--     "average_salary": "97587"
--   },
--   {
--     "skill_id": 183,
--     "skills": "power bi",
--     "demand_count": "110",
--     "average_salary": "97431"
--   },
--   {
--     "skill_id": 0,
--     "skills": "sql",
--     "demand_count": "398",
--     "average_salary": "97237"
--   },
--   {
--     "skill_id": 215,
--     "skills": "flow",
--     "demand_count": "28",
--     "average_salary": "97200"
--   },
--   {
--     "skill_id": 201,
--     "skills": "alteryx",
--     "demand_count": "17",
--     "average_salary": "94145"
--   },
--   {
--     "skill_id": 199,
--     "skills": "spss",
--     "demand_count": "24",
--     "average_salary": "92170"
--   },
--   {
--     "skill_id": 22,
--     "skills": "vba",
--     "demand_count": "24",
--     "average_salary": "88783"
--   },
--   {
--     "skill_id": 196,
--     "skills": "powerpoint",
--     "demand_count": "58",
--     "average_salary": "88701"
--   },
--   {
--     "skill_id": 181,
--     "skills": "excel",
--     "demand_count": "256",
--     "average_salary": "87288"
--   }
-- ]--

-- Insights:
-- Observations & Trends
-- Python and SQL are strong all-rounders — they are highly in demand and also offer strong average salaries (Python at ~$101K, SQL at ~$97K).

-- Cloud platforms like Snowflake, AWS, and Azure offer excellent pay, though their demand is more moderate compared to tools like SQL or Tableau.

-- Visualization & BI tools like Looker, Power BI, and Tableau balance strong demand with good compensation.

-- Niche high-paying skills (e.g., Go, Hadoop, Java) offer premium salaries, but aren’t as frequently listed in job postings.

-- Demand vs. Salary Correlation
-- Correlation coefficient: -0.28

-- This indicates a moderate negative correlation: as demand increases, average salary tends to slightly decrease.

-- This suggests that highly specialized skills may command higher salaries, even if they appear in fewer job listings.