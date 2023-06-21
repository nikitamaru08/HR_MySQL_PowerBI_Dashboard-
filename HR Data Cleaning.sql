USE new_schema;

SELECT * FROM human_resource;

-- change column name
ALTER TABLE human_resource
CHANGE COLUMN ï»¿id emp_id varchar(20);

DESCRIBE human_resource;

-- Modify birthdate columns data.
SET sql_safe_updates = 0;
UPDATE human_resource
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
-- Modify birthdate column datatype.
ALTER TABLE human_resource
MODIFY COLUMN birthdate DATE;

-- Modity hiredate column data.
UPDATE human_resource
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Change hiredate column datatype.
ALTER TABLE human_resource
MODIFY COLUMN hire_date DATE;
-- Modify termdate column data.
UPDATE human_resource
SET termdate = IF(termdate IS NOT NULL AND termdate != '', 
date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), 
'0000-00-00')
WHERE true;

SET sql_mode = 'ALLOW_INVALID_DATES';

-- Modify termdate column datatype.
ALTER TABLE human_resource
MODIFY COLUMN termdate DATE;

-- Insert new column.
ALTER TABLE human_resource 
ADD COLUMN age INT;

-- Modify Age column.

UPDATE human_resource
SET age = ABS(age);

SELECT 
min(AGE)AS youngest,
max(AGE) AS oldest
FROM human_resource;








