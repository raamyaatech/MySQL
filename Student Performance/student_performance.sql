CREATE DATABASE IF NOT EXISTS stuents;

USE students;

SHOW TABLES;
-----------------------------------------------------------------
--- Understanding the Datset-------------------------------------
-----------------------------------------------------------------

--- Number of Rows
SELECT COUNT(*) AS NUM_OF_ROWS FROM studentsperformance;

--- Number of Columns
SELECT COUNT(*)	AS NUM_OF_COLUMN 
FROM INFORMATION_SCHEMA.columns WHERE table_name ='studentsperformance';

--- First 10 Rows
SELECT * 
FROM studentsperformance LIMIT 10;

--- Feature Engineering ---

--- Change the course name
ALTER TABLE studentsperformance
RENAME COLUMN `test preparation course` TO course;

--- Change the `race/ethnicity` to ethnicity
ALTER TABLE studentsperformance
RENAME COLUMN `race/ethnicity` TO ethnicity;

--- Change `parental level of education` column to level
ALTER TABLE studentsperformance 
RENAME COLUMN `parental level of education` TO level;

--- Change the 'math score' column to math_score
ALTER TABLE studentsperformance
RENAME COLUMN `math score` TO  math_score;

--- Change the 'reading score' column to reading_score
ALTER TABLE studentsperformance
RENAME COLUMN `reading score` TO  read_score;

---- Change the 'writing score' column to writing_score
ALTER TABLE studentsperformance
RENAME COLUMN `writing score` TO writing_score;

--- Show columns from studentsperformance
SHOW COLUMNS FROM studentsperformance;

--- Show the columns names and data types from studentsperformance 
SHOW COLUMNS FROM `studentsperformance` FROM `students`; 

--- Unique courses
SELECT DISTINCT "test preparation course" AS COURSES 
FROM studentsperformance;

--- Gender Distribution
SELECT gender, COUNT(*) AS Count
FROM studentsperformance
GROUP BY gender
ORDER BY Count DESC;

--- Parental level Distribution
SELECT level, COUNT(*) AS Count
FROM studentsperformance
GROUP BY level
ORDER BY Count DESC;

--- Lunch Distribution
SELECT lunch, COUNT(*) AS Count
FROM studentsperformance
GROUP BY lunch
ORDER BY Count DESC;

--- Ethnicity Distribution
SELECT ethnicity, COUNT(*) AS Count
FROM studentsperformance
GROUP BY ethnicity 
ORDER BY Count DESC;

--- course Distribution
SELECT course, COUNT(*) AS Count
FROM studentsperformance
GROUP BY course
ORDER BY Count DESC;

--- Min and Max scores
SELECT gender, ethnicity,course,MIN(read_score) AS Minimum_Reading, MAX(read_score) AS Maximum_Reading,
MIN(math_score) AS Minimum_Math , MAX(math_score) AS Maximum_Math,
MIN(writing_score) AS Minimum_Writing, MAX(writing_score) AS Maximum_Writing
FROM studentsperformance
GROUP BY gender,ethnicity,course;

--- Add Column total
ALTER TABLE studentsperformance
ADD COLUMN total INT;

SHOW COLUMNS FROM studentsperformance FROM students;

--- Update values into total column
UPDATE studentsperformance
SET total = (math_score + read_score + writing_score);

SELECT gender,ethnicity,course,GREATEST(read_score,math_score,writing_score) AS Higest_score,
LEAST(read_score,math_score,writing_score) AS Lowest_score
FROM studentsperformance;

--- Top 10 Marks scored by female based on total 
SELECT gender,total,
ROW_NUMBER() OVER() AS Row_num
FROM studentsperformance
WHERE gender = "female"
ORDER BY total DESC
LIMIT 10;

--- Top 10 Marks based on total Male
SELECT gender,total,
ROW_NUMBER() OVER() AS Row_num
FROM studentsperformance
WHERE gender = "female"
ORDER BY total DESC
LIMIT 10;







--- 


SELECT * FROM studentsperformance LIMIT 1;
