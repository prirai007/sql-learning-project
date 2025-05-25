# 📈 Data Analyst Job Market Analysis (2023)

## 🌟 Goal of the Project

1. Analyze the **top-paying roles** and **high-demand skills** in the data analyst job market.
2. Use **SQL queries** to explore the dataset in a meaningful, career-specific way.
3. Learn and apply **SQL skills** to extract insights that can guide upskilling and job targeting for data analyst roles.

---

## 🔢 Key Questions Answered

1. What are the top-paying jobs for data analysts?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for data analysts?
4. Which skills are associated with the highest average salaries?
5. Which skills are both in-demand and high-paying (i.e., most optimal to learn)?

---

## 🔍 Introduction

📊 Dive into the data job market! This project analyzes the 2023 landscape for data analyst roles, identifying:

* 💰 Top-paying jobs
* 🔥 High-demand skills
* 📈 Where high demand meets high salary

> 🔍 SQL queries can be found in the [`project_sql`](project_sql/) folder.

---

## ⚙️ Tools Used

* **SQL**: Core querying tool for all data exploration and insights.
* **PostgreSQL**: Database platform used to host and run the SQL queries.
* **Visual Studio Code**: Editor for managing and running SQL queries.
* **Git & GitHub**: Version control and collaboration.

---

## 📊 The Analysis

### === 1. Top-Paying Data Analyst Jobs

This query filters remote jobs with available salary data, sorting by the highest salaries.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

#### 💰 Key Insights

* **Salary Range**: \$184,000 to \$650,000
* **Top Companies**: SmartAsset, Meta, AT\&T, and more
* **Job Diversity**: Ranges from analyst to director-level roles

![Top Paying Roles](./assets/1_top_paying_roles.png)

---

### === 2. Skills for Top-Paying Jobs

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

#### 🔎 Top Skills Identified

* **SQL**: 8/10 jobs
* **Python**: 7/10 jobs
* **Tableau**: 6/10 jobs
* **Others**: R, Pandas, Snowflake, Excel

![Top Paying Skills](./assets/2_top_paying_roles_skills.png)

---

### === 3. In-Demand Skills for Data Analysts

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

| Skill    | Demand Count | % Share of Top 5 |
| -------- | ------------ | ---------------- |
| SQL      | 7,291        | 30.01%           |
| Excel    | 4,611        | 18.98%           |
| Python   | 4,330        | 17.83%           |
| Tableau  | 3,745        | 15.42%           |
| Power BI | 2,609        | 10.74%           |

---

### === 4. Skills Based on Salary

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

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

---

### === 5. Most Optimal Skills to Learn

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill     | Average Salary (\$) | Demand Count |
| --------- | ------------------- | ------------ |
| Go        | 115,320             | 27           |
| Hadoop    | 113,193             | 22           |
| Snowflake | 112,948             | 37           |
| Azure     | 111,225             | 34           |
| AWS       | 108,317             | 32           |
| Java      | 106,906             | 17           |
| Jira      | 104,918             | 20           |
| Oracle    | 104,534             | 37           |
| Looker    | 103,795             | 49           |
| Python    | 101,397             | 236          |

---

## 🎓 What I Learned

* **Advanced SQL**: Using `WITH` clauses, joins, and nested queries
* **Aggregations**: `GROUP BY`, `AVG()`, and `COUNT()` to extract insights
* **Real-World Analysis**: Turned data questions into actionable insights

---

## 🔹 Conclusions

### 💡 Insights

1. **Top Salaries**: Highest remote analyst salary reached \$650,000
2. **Critical Skills**: SQL leads in both demand and appearance in high-paying jobs
3. **In-Demand Skills**: Excel, Python, and Tableau are must-haves
4. **Premium Skills**: Niche tools (e.g., PySpark, GitLab) offer the best salaries
5. **Optimal Skills**: Learning high-demand & high-paying skills like Python, Looker, AWS, Snowflake, and Go provides great ROI

### 🚀 Final Thoughts

This project boosted both my **SQL mastery** and **career strategy**. The journey revealed what matters most in the current data job market and how aspiring analysts can stay competitive by learning the right tools.

> Keep learning, keep querying, and stay curious. 🌍
