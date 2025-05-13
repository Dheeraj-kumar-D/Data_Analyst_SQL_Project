/** 
Question-1: Which companies are hiring the most Data Analysts?
- Identify the top 10 companies with the highest number of job postings for Data Analyst roles
- Focus only on roles explicitly titled "Data Analyst"
- Why? Helps job seekers understand where the demand for Data Analysts is highest, supporting targeted applications and better job search strategies
**/

SELECT 
    b.name AS company_name,
    COUNT(a.job_id) AS job_postings
FROM 
    job_postings a
    JOIN company b ON a.company_id = b.company_id
WHERE 
    a.job_title_short = 'Data Analyst'
GROUP BY 
    b.name
ORDER BY 
    job_postings DESC
FETCH FIRST 10 ROWS ONLY;

/**
Here's the breakdown of the companies have the highest data analyst job posting:
- Top Hiring Companies: Employers like Emprego, Robert Half, and Insight Global lead in the number of Data Analyst job postings, indicating a strong demand for analytics talent.
- Job Search Tip: Companies with lots of job posts, like Emprego and Insight Global, are good targets—they often hire for many roles and may have ongoing openings.

RESULT
======
| Company Name                                 | Job Postings |
|----------------------------------------------|--------------|
| Emprego                                      | 1121         |
| Robert Half                                  | 1047         |
| Insight Global                               | 892          |
| Citi                                         | 875          |
| Dice                                         | 604          |
| UnitedHealth Group                           | 592          |
| Confidenziale                                | 549          |
| Get It Recruit - Information Technology      | 510          |
| Michael Page                                 | 468          |
| Randstad                                     | 462          |
**/

/*
Question-2: Which companies are hiring the most Data Analysts for remote roles?
- Identify the top 10 companies offering the highest number of remote Data Analyst positions.
- Focus exclusively on remote-friendly (work from home) jobs.
- BONUS: Include the number of remote roles per company.
- Why? Pinpoint organizations leading the way in remote data talent acquisition, highlighting where demand for remote Data Analysts is strongest.
*/

SELECT 
    c.name AS company_name,
    COUNT(j.job_id) AS remote_job_count
FROM 
    job_postings j
JOIN 
    company c ON j.company_id = c.company_id
WHERE 
    j.job_title_short = 'Data Analyst'
    AND j.job_work_from_home = 'TRUE'
GROUP BY 
    c.name
ORDER BY 
    remote_job_count DESC
FETCH FIRST 10 ROWS ONLY;

/**
Here's the breakdown of the companies have the highest data analyst Remote job posting:
--Top Remote Employers: Companies like "Get It Recruit," "Dice," and "Peroptyx" offer the highest number of remote Data Analyst jobs.
--Helpful for Job Seekers: If you're looking for remote work, focusing on these companies can improve your chances of finding flexible job options.

RESULT
======
| Company Name                              | Remote Job Count |
|-------------------------------------------|------------------|
| Get It Recruit - Information Technology   | 488              |
| Dice                                      | 260              |
| Peroptyx                                  | 179              |
| TELUS International AI Data Solutions     | 161              |
| Crossover                                 | 119              |
| TELUS International                       | 118              |
| Insight Global                            | 98               |
| Robert Half                               | 90               |
| Talentify.io                              | 76               |
| Get It Recruit - Finance                  | 56               |
**/

/**
Question-3: Which countries have the highest average salary for Data Analysts?
- Identify the top 10 countries offering the highest average annual salary for Data Analyst roles.
- Filters out job postings where salary or country data is missing.
- Results are ordered by descending average salary.
-- Why? This helps Data Analysts understand which countries offer the most lucrative opportunities, guiding career planning or relocation considerations.
**/

SELECT 
    job_country,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_country IS NOT NULL
GROUP BY 
    job_country
ORDER BY 
    avg_salary DESC
FETCH FIRST 10 ROWS ONLY;

/**
Here's the breakdown of the Job Country have the highest Avg Salary:
- Top Countries: Countries like Belarus, Namibia, and Chile show very high average salaries for Data Analyst roles, which might be due to a small number of high-paying job postings.
- Remote Job Possibility: Some of these roles may be remote or posted by international companies, which could explain the higher salaries in unexpected countries.
- For Job Seekers: This information is useful for those looking for remote work or exploring opportunities in different countries.

RESULT
======
| Job Country                      | Avg Salary |
|----------------------------------|------------|
| Belarus                          | 400000     |
| Namibia                          | 135000     |
| Chile                            | 127250     |
| South Korea                      | 115709     |
| U.S. Virgin Islands              | 115000     |
| Malta                            | 113513     |
| Greece                           | 111683     |
| Congo, Democratic Republic of the| 111175     |
| Nicaragua                        | 111175     |
| Finland                          | 108110     |
**/

/**
Question-4: Do data analyst roles that mention health insurance benefits offer higher average salaries?
- This query analyzes whether job postings for Data Analyst roles that include health insurance benefits tend to have higher average annual salaries.
- It groups data by whether or not health insurance is offered (job_health_insurance).
- It filters out jobs with null salaries to ensure only complete and relevant data is included.
- The output compares the average salary for each group, helping to assess if offering health insurance correlates with better compensation.
Why? This helps Data Analysts understand if comprehensive benefits such as health insurance are associated with higher pay, which can be useful when evaluating job offers or negotiating compensation.
**/

SELECT 
    job_health_insurance,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    job_health_insurance;

/**
Here's the breakdown of the Health Insurance and Salary in Jobs:
- Pay: Jobs that offer health insurance tend to have a higher average salary ($95,550) compared to those without it ($92,638). This suggests that roles with health insurance might also come with better pay.
- Employer Commitment: Companies that provide health insurance may be more committed to attracting and retaining talent, offering additional benefits to employees.

RESULT
======
| Job Health Insurance | Avg Salary |
|----------------------|------------|
| TRUE                 | 95550      |
| FALSE                | 92638      |
**/

/**
Question-5: Is there a difference in pay between full-time and contract Data Analyst jobs?
- Compare the average salaries of Data Analyst roles across different job schedule types (e.g., full-time vs contract).
- Focus only on roles where both salary and job schedule type are clearly defined (i.e., remove nulls).
- Why? Understanding salary differences by job type helps analysts assess compensation expectations and career trade-offs between flexibility and stability.
*/

SELECT 
    job_schedule_type,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_schedule_type IS NOT NULL
GROUP BY 
    job_schedule_type
ORDER BY 
    avg_salary DESC;

/**
Here's the breakdown of the job types to understand how employment structure:
- Mixed Schedules Can Pay More: Roles that offer both full-time and part-time options have the highest average salary ($101,731), showing that flexible job types may come with better pay.
- Full-Time Is Still Strong: Standard full-time roles pay well ($94,390 on average), offering a balance of good income and job stability.
- Contract and Temp Work Varies: Contractor and temporary roles often offer decent pay but may lack benefits like health insurance or job security.
- Internships and Part-Time Pay Less: Internship and part-time roles are generally at the lower end of the salary range, likely due to less experience or fewer hours.
- Choose What Fits Best: Job seekers should consider both pay and job type. Some roles pay more but may be less stable, while others offer steady income with benefits.
RESULT
======
| Job Schedule Type                          | Avg Salary |
|--------------------------------------------|------------|
| Full-time and Part-time                    | 101731     |
| Full-time                                  | 94390      |
| Full-time, Contractor, and Temp work       | 86500      |
| Contractor                                 | 85217      |
| Full-time and Per diem                     | 82011      |
| Full-time and Contractor                   | 79017      |
| Contractor and Temp work                   | 78750      |
| Part-time                                  | 75677      |
| Full-time and Temp work                    | 73819      |
| Full-time, Part-time, and Contractor       | 70000      |
| Temp work                                  | 70000      |
| Full-time, Temp work, and Internship       | 67818      |
| Internship                                 | 65925      |
| Full-time, Contractor, and Internship      | 65000      |
| Full-time and Internship                   | 63750      |
| Part-time and Contractor                   | 60734      |
| Part-time and Full-time                    | 54000      |
| Internship and Full-time                   | 50400      |
**/

/**
Question-6: How many remote Data Analyst jobs are available compared to on-site jobs?
- This query calculates the distribution of Data Analyst jobs based on their work setup (remote vs. on-site).
- It groups job postings by the job_work_from_home flag, counting how many fall into each category.
- Why? This helps quantify the availability of remote opportunities for Data Analysts, which is essential for those seeking flexibility or work-from-anywhere roles.
**/

SELECT 
    job_work_from_home,
    COUNT(job_id) AS job_count
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    job_work_from_home;
    
/**
Here's the breakdown of the Availability of Work From Home in data analyst roles:
- Mostly On-Site Jobs: The majority of Data Analyst jobs (183,262) are not work-from-home, while only a smaller portion (13,331) are remote.
- Remote Options Exist: Even though fewer, remote jobs are still available, giving some flexibility for people who prefer to work from home.
- Job Seekers Can Choose: Knowing the number of remote roles helps job seekers decide if they want to focus on local jobs or look for remote opportunities.

RESULT
======
| Work From Home | Job Count |
|----------------|-----------|
| TRUE           | 13331     |
| FALSE          | 183262    |
**/
    
/**
Question-7: What is the trend in job postings over time for Data Analyst roles?
- Analyze how Data Analyst job postings fluctuate over time.
- Query 1 breaks down the trend by day (DD-MM-YYYY), showing the top 30 days with the most postings.
- Query 2 examines job posting distribution by month to highlight peak hiring periods.
- Why? Understanding posting patterns can help job seekers and analysts identify high-opportunity times for job searching or market activity.
**/

-- Query 1: with Day/month/year.
SELECT 
    TO_CHAR(JOB_POSTED_DATE, 'DD-MM-YYYY') AS posting_month,
    COUNT(job_id) AS posting_count
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    TO_CHAR(JOB_POSTED_DATE, 'DD-MM-YYYY')
ORDER BY 
    posting_count DESC
    FETCH FIRST 30 ROWS ONLY;

/**
RESULT
======
| Posting Month | Posting Count |
|--------------|---------------|
| 04-01-2023   | 1087          |
| 20-01-2023   | 968           |
| 26-01-2023   | 926           |
| 01-01-2023   | 906           |
| 11-01-2023   | 889           |
| 09-02-2023   | 880           |
| 19-01-2023   | 878           |
| 25-01-2023   | 858           |
| 10-01-2023   | 857           |
| 09-11-2023   | 856           |
| 01-09-2023   | 854           |
| 27-01-2023   | 841           |
| 06-01-2023   | 836           |
| 05-01-2023   | 818           |
| 18-01-2023   | 798           |
| 13-01-2023   | 795           |
| 24-01-2023   | 791           |
| 24-08-2023   | 789           |
| 12-01-2023   | 788           |
| 31-08-2023   | 787           |
| 31-01-2023   | 785           |
| 25-08-2023   | 781           |
| 23-01-2023   | 776           |
| 02-03-2023   | 766           |
| 25-05-2023   | 754           |
| 01-08-2023   | 751           |
| 01-02-2023   | 748           |
| 18-08-2023   | 748           |
| 09-01-2023   | 747           |
| 19-09-2023   | 746           |
**/
-- Query 2: with only month.

SELECT 
    TO_CHAR(JOB_POSTED_DATE, 'Month') AS month,
    COUNT(job_id) AS job_count
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    TO_CHAR(JOB_POSTED_DATE, 'Month')
ORDER BY 
    job_count DESC;

/**
Here's the breakdown of the Trend in job postings over time for Data Analyst roles:
- Hiring Peaks in January: Most job postings for Data Analyst roles were made in January 2023, showing it's a busy month for hiring.
- Other Active Months: February, August, and September also had high posting days, suggesting more openings in early and mid-year.
- Good to Know for Job Seekers: If you're planning to apply, targeting these peak times can increase your chances of finding more opportunities.

RESULT
======
| Posting Month | Posting Count |
|---------------|---------------|
| January       | 23697         |
| August        | 18602         |
| February      | 16479         |
| March         | 16342         |
| October       | 16260         |
| July          | 16150         |
| June          | 15932         |
| April         | 15499         |
| November      | 15133         |
| September     | 14997         |
| December      | 14045         |
| May           | 13457         |
**/

/**
Question-8: What job locations offer the highest average salaries for Data Analyst roles?
- Identify the top 10 locations with the highest average annual salary for Data Analysts
- Filters out any job postings without specified salaries
- Uses aggregation to calculate average salary per location
- Why? This analysis helps Data Analysts understand where geographically the most lucrative opportunities are concentrated.
**/

SELECT 
    job_location,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    job_location
ORDER BY 
    avg_salary DESC
    FETCH FIRST 10 ROWS ONLY;

/**
Here's the breakdown of the Job locations that have highest average salaries for Data Analyst roles:
- Top Paying Locations: Places like Belarus, parts of California, Germany, and Taiwan offer the highest average salaries for Data Analyst roles.
- Not Just Big Cities: Some smaller or unexpected locations also pay very well, showing that high salaries aren’t limited to major tech hubs.
- Think Beyond Salary: While these numbers are attractive, it's important to also consider the cost of living in each location when comparing offers.

RESULT
======
| Job Location              | Avg Salary |
|---------------------------|------------|
| Belarus                   | 400000     |
| Berkeley Heights, NJ      | 200000     |
| Merced, CA                | 200000     |
| Hildesheim, Germany       | 200000     |
| Nea Smyrni, Greece        | 200000     |
| Renningen, Germany        | 199838     |
| South San Francisco, CA   | 182771     |
| Taipei, Taiwan            | 180000     |
| Valparaiso, IN            | 173500     |
| Saratoga, CA              | 170000     |
**/

/**
Question-9: What job types (schedule) are most common for Data Analyst roles, and how do they relate to salary?
- Analyze the distribution of job schedule types (e.g., full-time, part-time, contract) for Data Analyst roles
- Identify how each job schedule type correlates with average salary
- Filter out postings with missing salary or schedule type data
- Why? Helps job seekers understand which work schedules are most prevalent and lucrative in the Data Analyst job market.
**/

SELECT 
    job_schedule_type,
    COUNT(job_id) AS job_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_schedule_type IS NOT NULL
GROUP BY 
    job_schedule_type
ORDER BY 
    job_count DESC;
/**
Here's the breakdown of most common job types for Data Analyst roles:
- Full-Time Leads the Market: Most Data Analyst jobs are full-time (5,169 postings), with a strong average salary of $94,390—making it the most common and stable option.
- Contract Work Pays Well: Contractor roles are fewer but still offer good pay ($85,217), often due to specialized short-term projects.
- Flexible Schedules, Higher Pay: Some mixed schedules (like full-time and part-time) show even higher average salaries, but these are rare.
- Choose What Fits You: Whether you're looking for stability, flexibility, or short-term projects, there's a range of job types—each with different pay and lifestyle balance.

RESULT
======
| Job Schedule                           | Job Count | Avg Salary |
|----------------------------------------|-----------|------------|
| Full-time                              | 5169      | 94390      |
| Contractor                             | 134       | 85217      |
| Full-time and Part-time                | 56        | 101731     |
| Part-time                              | 31        | 75677      |
| Full-time and Contractor               | 20        | 79017      |
| Full-time and Temp work                | 9         | 73819      |
| Internship                             | 8         | 65925      |
| Temp work                              | 8         | 70000      |
| Contractor and Temp work               | 4         | 78750      |
| Full-time and Internship               | 4         | 63750      |
| Full-time, Contractor, and Internship  | 3         | 65000      |
| Full-time, Contractor, and Temp work   | 2         | 86500      |
| Full-time and Per diem                 | 2         | 82011      |
| Full-time, Part-time, and Contractor   | 1         | 70000      |
| Part-time and Full-time                | 1         | 54000      |
| Full-time, Temp work, and Internship   | 1         | 67818      |
| Internship and Full-time               | 1         | 50400      |
| Part-time and Contractor               | 1         | 60734      |
**/

/**
Question-10: How frequently is a degree NOT required in remote Data Analyst job postings?
- This query examines remote job listings specifically for "Data Analyst" roles.
- It analyzes whether a degree is mentioned as a requirement or not (job_no_degree_mention = TRUE or FALSE).
- It counts how many jobs fall into each category and calculates the average salary for each group.
- Filters out postings without salary data to ensure reliable salary averages.
- Why? To provide insight into the necessity of a formal degree for remote data analyst jobs and whether salary differs based on that requirement.
**/

SELECT 
    job_no_degree_mention,
    COUNT(job_id) AS job_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND job_work_from_home = 'TRUE'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    job_no_degree_mention;
    
/**
Here's the breakdown of the degree NOT required in Data Analyst:
- Skills Over Degrees: Some remote Data Analyst jobs (114 postings) mention a degree requirement, showing that many companies are open to hiring based on skills instead of formal education.
- Good Pay Without a Degree: These no-degree jobs actually offer higher average salaries ($103,119) compared to jobs that do require a degree ($92,827).
- Focus on What You Can Do: Employers are placing more value on hands-on experience, technical skills, and real-world projects rather than just academic qualifications.

RESULT
======
| No Degree Mention | Job Count | Avg Salary |
|-------------------|-----------|------------|
| TRUE              | 114       | 103119     |
| FALSE             | 490       | 92827      |
**/

/**
Question-11: What percentage of Data Analyst jobs explicitly mention a degree requirement?
- Objective: Determine how many Data Analyst job listings require a formal degree versus those that do not.
- Focus: Analyze job postings for the presence or absence of degree requirements using the job_no_degree_mention flag.
- BONUS: Provide both raw counts and percentages for jobs requiring and not requiring a degree.
- Why? Helps job seekers understand the educational expectations in the Data Analyst job market and identify opportunities that may be accessible without a formal degree.
**/
  SELECT 
      COUNT(*) AS total_jobs,
      COUNT(CASE WHEN job_no_degree_mention = 'FALSE' THEN 1 END) AS jobs_requiring_degree,
      ROUND(100.0 * COUNT(CASE WHEN job_no_degree_mention = 'FALSE' THEN 1 END) / COUNT(*), 2) AS percentage_degree,
      COUNT(CASE WHEN job_no_degree_mention = 'TRUE' THEN 1 END) AS jobs_no_degree_required,
      ROUND(100.0 * COUNT(CASE WHEN job_no_degree_mention = 'TRUE' THEN 1 END) / COUNT(*), 2) AS percentage_no_degree
  FROM 
      job_postings
  WHERE 
      job_title_short = 'Data Analyst';

/**
Here's the breakdown of the degree NOT required in Data Analyst:
- No Degree? Still a Chance: About 39% of Data Analyst jobs don’t mention a degree requirement, which is good news for self-taught professionals or those from non-traditional backgrounds.
- Degree Still Common: Around 61% of job postings still ask for a degree—often in areas like Computer Science, Business, or Statistics.
- Helpful Insight: This shows that while having a degree helps, strong skills and experience can still open many doors in the data analyst field.

RESULT
======
| Total Jobs | Jobs Requiring Degree | Percentage Degree | Jobs No Degree Required | Percentage No Degree |
|------------|-----------------------|-------------------|-------------------------|----------------------|
| 196593     | 120536                | 61.31%            | 76057                   | 38.69%               |
**/
    
/**
Question-12: Do remote (work-from-home) Data Analyst jobs offer better salaries than on-site jobs?
- Compare the average salaries between remote and non-remote Data Analyst positions.
- Count how many jobs fall into each category (remote vs. on-site).
- Why? To evaluate whether remote roles are more financially rewarding than their on-site counterparts.
**/

SELECT 
    job_work_from_home,
    COUNT(job_id) AS job_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    job_work_from_home;
/**
Here's the breakdown of the remote (work-from-home) Data Analyst jobs offer better salaries:
- Remote Pays Slightly More: Remote Data Analyst jobs have a slightly higher average salary ($94,770) compared to on-site roles ($93,765).
- Wider Talent Options: Remote work allows companies to hire skilled professionals from anywhere, and analysts can access better-paying roles without moving.
- Remote Work is Growing: This shows that remote work is becoming a strong option for data analysts, both in terms of flexibility and pay.

RESULT
======
| Work From Home | Job Count | Avg Salary |
|----------------|-----------|------------|
| TRUE           | 604       | 94770      |
| FALSE          | 4859      | 93765      |
**/

/**
Question-13: Which tools (e.g., Tableau vs Power BI) are linked with higher average salaries?
- Identify average salaries associated with specific data analyst tools
- Focus only on jobs with known salaries and specific tools: SQL, Python, Excel, Tableau, and Power BI
- Show tool usage frequency across job postings to contextualize their demand
- Why? To help Data Analysts understand which tools command higher pay and prioritize learning accordingly
**/

SELECT 
    c.skills,
    COUNT(b.job_id) AS job_count,
    ROUND(AVG(a.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings a
    JOIN skills_job b ON a.job_id = b.job_id
    JOIN skills c ON b.skill_id = c.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND a.salary_year_avg IS NOT NULL
    AND c.skills IN ('sql', 'python', 'excel', 'tableau', 'power bi')
GROUP BY 
    c.skills
ORDER BY 
    avg_salary DESC;
    
/**
Here's the breakdown of the Which tools are linked with higher salary:
- Python Leads in Pay: Jobs requiring Python have the highest average salary ($101,512), showing its strong value in the data analyst job market.
- SQL Is Most Common: SQL appears in the most job postings (3,083), making it a must-have skill for most data analyst roles.
- Excel Still Matters: While Excel is widely used, it's linked with lower average salaries ($86,419), suggesting it's more common in entry-level or support roles.
- Tableau vs. Power BI: Tableau jobs tend to offer slightly higher pay than Power BI, possibly because it's more often used in larger or more data-driven companies.
- Skill Strategy: Learning multiple tools boosts your chances, but focusing deeply on high-paying ones like Python or Tableau can help with better job offers and salary negotiations.

RESULT
======
| Skills   | Job Count | Avg Salary |
|----------|-----------|------------|
| python   | 1840      | 101512     |
| tableau  | 1659      | 97978      |
| sql      | 3083      | 96435      |
| power bi | 1044      | 92324      |
| excel    | 2143      | 86419      |
**/

/**
Question-14: Which data visualization tools are associated with higher average salaries for Data Analyst roles?
- Compare average salaries linked to specific tools: Tableau vs Power BI
- Filter out job postings without salary data
- Focus exclusively on 'Data Analyst' roles
- Why? This analysis helps identify which visualization tool expertise commands a higher premium in the job market for Data Analysts.
**/

SELECT 
    c.skills,
    COUNT(b.job_id) AS job_count,
    ROUND(AVG(a.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings a
    JOIN skills_job b ON a.job_id = b.job_id
    JOIN skills c ON b.skill_id = c.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND a.salary_year_avg IS NOT NULL
    AND c.skills IN ('tableau', 'power bi')
GROUP BY 
    c.skills
ORDER BY 
    avg_salary DESC;
/**
Here's the breakdown of the Which tools (e.g., Tableau vs Power BI) are linked with higher salary:
- Tableau Pays More: Jobs needing Tableau have a higher average salary ($97,978) compared to Power BI ($92,324), suggesting it's more valued in certain industries or roles.
- Power BI is Microsoft-Friendly: Power BI is often used in companies that rely on Microsoft tools, making it widely adopted and easier to learn for those already in that environment.
- Best of Both Worlds: Learning both tools keeps you competitive, but getting certified or specializing in one especially Tableau can help you earn more and stand out in job applications.

RESULT
======
| Skills    | Job Count | Avg Salary |
|-----------|-----------|------------|
| Tableau   | 1659      | 97978      |
| Power BI  | 1044      | 92324      |
**/
    
/**
Question-15: How do job titles (seniority levels) impact average salaries in data analyst roles?
- Analyze how different job titles containing "Analyst" relate to salary variations
- Filter out job postings without a specified salary to ensure meaningful averages
- Provide job counts for each title to show market demand
- Why? To help Data Analysts understand how job title progression can influence earning potential and where salary opportunities might lie
**/

SELECT 
    job_title_short,
    COUNT(job_id) AS job_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings
WHERE 
    job_title_short LIKE '%Analyst%' 
    AND salary_year_avg IS NOT NULL
GROUP BY 
    job_title_short
ORDER BY 
    avg_salary DESC;
    
/**
Here's the breakdown of the Job titles (seniority levels) impact average salaries:
- Higher Title = Higher Pay: Senior Data Analysts earn more ($114,104) compared to regular Data Analysts ($93,876) and Business Analysts ($91,071), showing that experience and title matter.
- Most Jobs Are Mid-Level: The majority of openings are for general Data Analyst roles, making it a common entry or mid-level starting point.
- Grow Your Skills, Grow Your Pay: Moving up to senior roles can bring a big salary boost, so gaining experience and learning advanced skills is a smart long-term move.

RESULT
======
| Job Title Short       | Job Count | Avg Salary |
|-----------------------|-----------|------------|
| Senior Data Analyst   | 1132      | 114104     |
| Data Analyst          | 5463      | $93876     |
| Business Analyst      | 617       | $91071     |
**/

/**
Question-16: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
**/

  SELECT 
          job_id,
          job_title,
          job_location,
          job_schedule_type,
          salary_year_avg,
          job_posted_date
  FROM
      job_postings
  WHERE 
      job_title_short = 'Data Analyst' 
      AND
      job_location = 'Anywhere'
      AND
      salary_year_avg is not NUll
  ORDER BY 
          salary_year_avg DESC;
          
/**
Here's the breakdown of the top data analyst jobs in 2023:
- Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

RESULTS
=======
| Job ID    | Job Title                                          | Job Location | Schedule Type | Salary (Year Avg) | Posted Date  |
|-----------|----------------------------------------------------|--------------|---------------|-------------------|--------------|
| 226942    | Data Analyst                                       | Anywhere     | Full-time     | 650000           | 20-02-23     |
| 547382    | Director of Analytics                              | Anywhere     | Full-time     | 336500           | 23-08-23     |
| 552322    | Associate Director- Data Insights                  | Anywhere     | Full-time     | 255829.5         | 18-06-23     |
| 99305     | Data Analyst, Marketing                            | Anywhere     | Full-time     | 232423           | 05-12-23     |
| 1021647   | Data Analyst (Hybrid/Remote)                       | Anywhere     | Full-time     | 217000           | 17-01-23     |
| 168310    | Principal Data Analyst (Remote)                    | Anywhere     | Full-time     | 205000           | 09-08-23     |
| 731368    | Director, Data Analyst - HYBRID                    | Anywhere     | Full-time     | 189309           | 07-12-23     |
| 310660    | Principal Data Analyst, AV Performance Analysis    | Anywhere     | Full-time     | 189000           | 05-01-23     |
| 1749593   | Principal Data Analyst                             | Anywhere     | Full-time     | 186000           | 11-07-23     |
| 387860    | ERM Data Analyst                                   | Anywhere     | Full-time     | 184000           | 09-06-23     |
| ...       | ...                                                | ...          | ...           | ...              | ...          |
| ...       | ...                                                | ...          | ...           | ...              | ...          |
| ...       | ...                                                | ...          | ...           | ...              | ...          |
| 663127    | Data Quality Analyst (Fraud Prevention)            | Anywhere     | Full-time     | 40000            | 26-10-23     |
| 994565    | Remote Data Analyst                                | Anywhere     | Full-time     | 39000            | 28-04-23     |
| 1349849   | Financial Data Analyst                             | Anywhere     | Full-time     | 36000            | 08-06-23     |
| 1178688   | Data Analyst                                       | Anywhere     | Contractor    | 35000            | 20-06-23     |
| 216489    | Research Scientist                                 | Anywhere     | Full-time     | 25000            | 18-07-23    
**/
          
/**
Question-17: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
**/

WITH top_paying_jobs AS
  (
      SELECT 
              a.job_id,
              a.job_title,
              b."NAME" AS company_name,
              a.salary_year_avg
      FROM
              job_postings a
              LEFT JOIN company b ON a.company_id = b.company_id
      WHERE 
              a.job_title_short = 'Data Analyst' 
              AND a.job_location = 'Anywhere'
              AND a.salary_year_avg is not NUll
              ORDER BY 
              a.salary_year_avg DESC
      FETCH FIRST 10 ROWS ONLY
   )
      SELECT 
              tpj.job_id,
              tpj.job_title,
              tpj.company_name,
              s.skills,
              tpj.salary_year_avg
      FROM 
              top_paying_jobs tpj
              INNER JOIN skills_job sj ON tpj.job_id = sj.job_id
              INNER JOIN skills s ON s.skill_id = sj.skill_id;
 
/**
Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings:
SQL is leading with a bold count of 8.
Python follows closely with a bold count of 7.
Tableau is also highly sought after, with a bold count of 6.
Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.  

RESULT
======
| Job ID   | Job Title                          | Company Name                            | Skills      | Salary (Year Avg) |
|----------|------------------------------------|-----------------------------------------|-------------|-------------------|
| 552322   | Associate Director- Data Insights  | AT&T                                    | python      | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | sql         | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | r           | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | azure       | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | databricks  | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | aws         | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | powerpoint  | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | pyspark     | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | jupyter     | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | excel       | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | tableau     | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | power bi    | 255829.5          |
| 552322   | Associate Director- Data Insights  | AT&T                                    | pandas      | 255829.5          |
| 99305    | Data Analyst, Marketing            | Pinterest Job Advertisements            | python      | 232423            |
| 99305    | Data Analyst, Marketing            | Pinterest Job Advertisements            | sql         | 232423            |
| ...      | ...                                | ...                                     | ...         | ...               |
| ...      | ...                                | ...                                     | ...         | ...               |
| ...      | ...                                | ...                                     | ...         | ...               |
| 1749593  | Principal Data Analyst             | SmartAsset                              | numpy       | 186000            |
| 1749593  | Principal Data Analyst             | SmartAsset                              | excel       | 186000            |
| 387860   | ERM Data Analyst                   | Get It Recruit - Information Technology | sql         | 184000            |
| 387860   | ERM Data Analyst                   | Get It Recruit - Information Technology | python      | 184000            |
| 387860   | ERM Data Analyst                   | Get It Recruit - Information Technology | r           | 184000            |
**/
              
/**
Question-18: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
**/
  SELECT 
          skills,
          COUNT(b.job_id) AS demand_count
  FROM
          job_postings a
          INNER JOIN skills_job b ON a.job_id = b.job_id
          INNER JOIN skills c ON b. skill_id = c.skill_id
  WHERE
          job_title_short = 'Data Analyst'
          AND a.job_work_from_home = 'TRUE'
  GROUP BY
          skills
  ORDER BY
          demand_count DESC
          FETCH FIRST 5 ROWS ONLY;
          
/**
Here's the breakdown of the most demanded skills for data analysts in 2023
- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

RESULT
======
| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |
**/
          
/**
Question-19: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve
**/

WITH skills_demand AS 
    (

       SELECT 
              b.skill_id,
              c.skills,
              COUNT(b.job_id) AS demand_count
        FROM
              job_postings a
        INNER JOIN skills_job b ON a.job_id = b.job_id
        INNER JOIN skills c ON b. skill_id = c.skill_id
        WHERE
              job_title_short = 'Data Analyst'
              AND a.job_work_from_home = 'TRUE'
              AND salary_year_avg IS NOT NULL
        GROUP BY
                b.skill_id,
                c.skills
    ),
        average_salary AS 
    (
        SELECT 
                b.skill_id,
                ROUND(AVG(salary_year_avg),0) AS Avg_Salary
        FROM
                job_postings a
        INNER JOIN skills_job b ON a.job_id = b.job_id
        INNER JOIN skills c ON b. skill_id = c.skill_id
        WHERE
                job_title_short = 'Data Analyst'
                AND a.job_work_from_home = 'TRUE' 
                AND salary_year_avg IS NOT NULL
        GROUP BY
                b.skill_id
    )
        SELECT
              skills_demand.skill_id,
              skills_demand.skills,
              demand_count,
              avg_salary
        FROM
              skills_demand
              INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
        WHERE
              demand_count > 10
        ORDER BY
              avg_salary DESC,
              demand_count DESC
        FETCH FIRST 25 ROWS ONLY;
        
/**
Here's a breakdown of the results for top paying skills for Data Analysts:
- High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

RESULT
======
| Skills        | Average Salary     |
|---------------|--------------------|
| pyspark       |             208172 |
| bitbucket     |             189155 |
| couchbase     |             160515 |
| watson        |             160515 |
| datarobot     |             155486 |
| gitlab        |             154500 |
| swift         |             153750 |
| jupyter       |             152777 |
| pandas        |             151821 |
| elasticsearch |             145000 |
**/
        
/**
Question-20: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis
**/

  SELECT 
          skills,
          COUNT(b.job_id) AS demand_count
  FROM
          job_postings a
          INNER JOIN skills_job b ON a.job_id = b.job_id
          INNER JOIN skills c ON b. skill_id = c.skill_id
  WHERE
          job_title_short = 'Data Analyst'
          AND a.job_work_from_home = 'TRUE'
  GROUP BY
          skills
  ORDER BY
          demand_count DESC
          FETCH FIRST 5 ROWS ONLY;
          
/**
Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- Business Intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

RESULT
======
| Skill ID | Skills     | Demand Count | Average Salary     |
|----------|------------|--------------|--------------------|
| 8        | go         | 27           |             115320 |
| 234      | confluence | 11           |             114210 |
| 97       | hadoop     | 22           |             113193 |
| 80       | snowflake  | 37           |             112948 |
| 74       | azure      | 34           |             111225 |
| 77       | bigquery   | 13           |             109654 |
| 76       | aws        | 32           |             108317 |
| 4        | java       | 17           |             106906 |
| 194      | ssis       | 12           |             106683 |
| 233      | jira       | 20           |             104918 |
**/