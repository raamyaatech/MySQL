CREATE DATABASE human_resource;

USE human_resource;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;

UPDATE hr
SET termdate = date(str_to_date(substring(termdate,1,10), '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND trim(termdate) != ''; 

UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate is NULL;

SELECT DISTiNCT termdate FROM hr;
--- SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

DESCRIBE hr;

--- EDA
-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS gender_count
FROM hr
WHERE age >= 18 and termdate ='0000-00-00'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race,COUNT(*) AS race_count
FROM hr
WHERE gender >= 18 AND termdate = "0000:00:00"
GROUP BY race
ORDER BY race_count DESC;

-- 3. What is the age distribution of employees in the company?
SELECT MIN(age) AS youngest, MAX(age) AS oldest
FROM hr
WHERE gender >= 18 AND termdate = "0000:00:00";

SELECT CASE WHEN age BETWEEN 18 AND 24 THEN "18-24"
            WHEN age BETWEEN 25 AND 34 THEN "25-24"
            WHEN age BETWEEN 35 AND 44 THEN "35-44"
            WHEN age BETWEEN 45 AND 54 THEN "45-54"
            ELSE "65+"
        END AS age_group, COUNT(*) AS count
 FROM hr
 WHERE gender >= 18 AND termdate = "0000:00:00"
 GROUP BY age_group,gender
 ORDER BY age_group,gender;
			
-- 4. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) AS count
FROM hr
WHERE gender >= 18 AND termdate = "0000:00:00"
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate,hire_date))/365,2) AS avg_len_employment
FROM hr
WHERE age >= 18 AND termdate <= CURDATE() AND termdate <> "0000:00:00";

-- 6. How does the gender distribution vary across departments and job titles?


-- 7. What is the distribution of job titles across the company?


-- 8. Which department has the highest turnover rate?


-- 9. What is the distribution of employees across locations by city and state?


-- 10. How has the company's employee count changed over time based on hire and term dates?

-- 11. What is the tenure distribution for each department?

