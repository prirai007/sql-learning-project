/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
skills,
COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short = 'Data Analyst' AND
job_work_from_home = True
GROUP BY 
skills
ORDER BY
demand_count DESC
LIMIT 5;

/*
Query Results:
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]

Insights:

| Skill    | Demand Count | % Share of Top 5 |
| -------- | ------------ | ---------------- |
| sql      | 7,291        | 30.01%           |
| excel    | 4,611        | 18.98%           |
| python   | 4,330        | 17.83%           |
| tableau  | 3,745        | 15.42%           |
| power bi | 2,609        | 10.74%           |

Total postings captured (top 5): 24,586

SQL alone accounts for almost one-third (30%) of these high-demand skill mentions, making it the clear frontrunner.

Excel and Python together make up roughly 37% of the demand, underscoring their continued importance in data-analysis workflows.

Visualization tools (Tableau and Power BI) combine for about 26% of mentions, highlighting that the ability to create dashboards and reports remains a core expectation.

Overall, these five skills constitute 100% of the top-5 demand segment, with each reflecting a distinct functional area:

SQL: database querying and manipulation

Excel: spreadsheet analysis and quick ad-hoc reporting

Python: scripting, automation, and advanced analytics

Tableau & Power BI: interactive visualization and dashboarding

 */
