-- SQL QUERIES QUESTIONS 

USE new_schema;

SELECT *FROM human_resource;

-- 1. What is the gender breakdown of employees in the company?

SELECT gender ,count(*) AS count
FROM human_resource
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, count(*) AS count
FROM human_resource
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?

SELECT 
min(AGE)AS youngest,
max(AGE) AS oldest
FROM human_resource;

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group,gender,
  COUNT(*) AS count
FROM 
  human_resource
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?

SELECT location, count(*)  AS count
FROM human_resource
GROUP BY location;

-- 5.What is the average length of employment for employees who have been terminated??

SELECT round(avg(datediff(termdate, hire_date))/365,0)  AS avg_lengh_employment
FROM human_resource
WHERE termdate <= curdate();

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department,gender, count(*) AS COUNT
FROM human_resource
GROUP BY department,gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS COUNT
FROM human_resource
GROUP BY jobtitle
ORDER BY jobtitle DESC;


-- 8. Which department has the highest turnover/ternimate rate?

SELECT department,
total_count,
terminated_count,
terminated_count/total_count AS termination_rate
FROM(
      SELECT department,
      count(*) AS total_count,
      SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
      FROM human_resource
	  GROUP BY department)
      AS subquery
      ORDER BY termination_rate DESC;

-- 9 WHAT IS DISTRIBUTION OF EMPLOYEES ACROSS LOCATION BY CITY AND STATE?

SELECT location_state, count(*)AS count
FROM human_resource
GROUP BY location_state
ORDER BY count DESC;

-- 10 HOW HAS THE COMPANY'S EMPLOYEES COUNT CHANGED OVER TIME BASED ON HIRE AND TERM DATE??
 
 SELECT year, hires, terminations, (hires - terminations) AS net_change,
 round((hires - terminations)/ hires*100,2) AS net_changes_percent
FROM 
     (SELECT YEAR (hire_date) AS year,
     count(*) AS hires,
     SUM(CASE WHEN  termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
      FROM human_resource
	  GROUP BY YEAR(hire_date))
      AS subquery
      ORDER BY YEAR ASC;
      
-- 11 WHAT IS THE TENURE DISTRIBUTION FOR EACH DEPARTMENT??
     
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM human_resource
WHERE termdate <= curdate() 
GROUP BY department;
     
     
     