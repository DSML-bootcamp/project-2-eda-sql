USE DATABASE DSS;

--Q1
---- What is the median salaries and salary distributions of a Data Scientists with different experience levels>

SELECT 
    s.level,
    AVG(s.salary_in_usd) AS average_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s.salary_in_usd) AS median_salary,
   
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
GROUP BY 
    s.level
ORDER BY 
    AVG(s.salary_in_usd) DESC;

---

UPDATE salaries
SET level = 'Executive'
WHERE level = 'Experienced';


--- Q2

SELECT 
    s.level,
    s.country,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s.salary_in_usd) AS median_salary
FROM
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
WHERE 
    s.country IN (
        SELECT 
            country
        FROM 
            salaries
        GROUP BY 
            country
        ORDER BY 
            COUNT(*) DESC
        LIMIT 10
    )
GROUP BY 
    s.level, s.country
    
Order by s.country desc;


---Q3 


SELECT 
    s.level,
    c.company_size,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s.salary_in_usd) AS median_salary
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
GROUP BY 
    s.level, c.company_size
order by company_size;


-- Q4


SELECT 
    s.level,
    c.remote_ratio,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s.salary_in_usd) AS median_salary
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
GROUP BY 
    s.level, c.remote_ratio
order by remote_ratio desc;



---Q5 


SELECT 
    c.company_country,
    s.remote_ratio,
    AVG(s.salary_in_usd) AS average_salary
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
WHERE 
    c.company_country IN ('Germany', 'United Kingdom', 'Spain', 'Netherlands', 'Portugal')


GROUP BY 
    c.company_country,
    s.remote_ratio
order by c.company_country 

---Q6

WITH RankedSalaries AS (
    SELECT 
        s.level,
        s.job_title,
        AVG(s.salary_in_usd) AS average_salary,
        RANK() OVER (PARTITION BY s.level ORDER BY AVG(s.salary_in_usd) DESC) AS salary_rank
    FROM 
        salaries s
    JOIN 
        companies c ON s.row_number = c.row_number
    GROUP BY 
        s.level, s.job_title
)
SELECT 
    level,
    job_title,
    average_salary
FROM 
    RankedSalaries
WHERE 
    salary_rank <= 5


    ---Q7


SELECT 
    s.level,
    s.gender,
    AVG(s.salary_in_usd) AS average_salary
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
GROUP BY 
    s.level, s.gender;


---Q8
    
 
SELECT 
    c.company_size,
    s.gender,
    AVG(s.salary_in_usd) AS average_salary
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
GROUP BY 
    c.company_size, s.gender
order by company_size;


---Q9

SELECT 
    company_country,
    AVG(s.salary_in_usd) AS average_salary,
    Count(s.row_number) as emp_number
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
WHERE 
    c.remote_ratio = 100
GROUP BY 
    company_country
ORDER BY 
    average_salary DESC
LIMIT 10;


---Q10

SELECT 
    s.level,
    c.company_size,
    s.job_title,
    AVG(s.salary_in_usd) AS average_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s.salary_in_usd) AS median_salary,
    MIN(s.salary_in_usd) AS min_salary,
    MAX(s.salary_in_usd) AS max_salary,
    COUNT(*) AS employee_count
FROM 
    salaries s
JOIN 
    companies c ON s.row_number = c.row_number
GROUP BY 
    s.level, c.company_size, s.job_title

order by level asc;
