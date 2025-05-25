/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
skills,
ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short = 'Data Analyst' AND 
salary_year_avg IS NOT NULL AND 
job_work_from_home = True
GROUP BY
skills
ORDER BY
average_salary DESC
LIMIT 25;

/* 
Query Results:
[
  {
    "skills": "pyspark",
    "average_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "average_salary": "189155"
  },
  {
    "skills": "couchbase",
    "average_salary": "160515"
  },
  {
    "skills": "watson",
    "average_salary": "160515"
  },
  {
    "skills": "datarobot",
    "average_salary": "155486"
  },
  {
    "skills": "gitlab",
    "average_salary": "154500"
  },
  {
    "skills": "swift",
    "average_salary": "153750"
  },
  {
    "skills": "jupyter",
    "average_salary": "152777"
  },
  {
    "skills": "pandas",
    "average_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "average_salary": "145000"
  },
  {
    "skills": "golang",
    "average_salary": "145000"
  },
  {
    "skills": "numpy",
    "average_salary": "143513"
  },
  {
    "skills": "databricks",
    "average_salary": "141907"
  },
  {
    "skills": "linux",
    "average_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "average_salary": "132500"
  },
  {
    "skills": "atlassian",
    "average_salary": "131162"
  },
  {
    "skills": "twilio",
    "average_salary": "127000"
  },
  {
    "skills": "airflow",
    "average_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "average_salary": "125781"
  },
  {
    "skills": "jenkins",
    "average_salary": "125436"
  },
  {
    "skills": "notion",
    "average_salary": "125000"
  },
  {
    "skills": "scala",
    "average_salary": "124903"
  },
  {
    "skills": "postgresql",
    "average_salary": "123879"
  },
  {
    "skills": "gcp",
    "average_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "average_salary": "121619"
  }
]


Insights:

Top 10 Highest Paying Skills

| Rank | Skill         | Average Salary (\$) |
| ---- | ------------- | ------------------- |
| 1    | PySpark       | 208,172             |
| 2    | Bitbucket     | 189,155             |
| 3    | Couchbase     | 160,515             |
| 4    | Watson        | 160,515             |
| 5    | DataRobot     | 155,486             |
| 6    | GitLab        | 154,500             |
| 7    | Swift         | 153,750             |
| 8    | Jupyter       | 152,777             |
| 9    | Pandas        | 151,821             |
| 10   | Elasticsearch | 145,000             |

Key Trends
Big Data & ML tools lead: Tools like PySpark, DataRobot, and Watson dominate the top-paying ranks, reflecting growing demand for data engineering and machine learning skills.

Version control skills pay well: Both Bitbucket and GitLab appear in the top 10, showing that strong DevOps/dataOps practices are valued even in analyst roles.

Open-source tech is rewarding: Tools like Jupyter, Pandas, and Elasticsearch offer strong salaries, supporting the continued dominance of Python and its ecosystem in data science.

Cross-functional skills command premiums: Knowledge of Swift hints at the advantage of having app-development capabilities alongside analytics.

Summary Stats
Average salary (top 25 skills): $143,380

Highest-paying skill: PySpark – $208,172

Lowest among top 25: $121,619