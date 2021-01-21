-- Join employee and title tables to create new table "retirement by title"
SELECT e.emp_no, e.first_name, e.last_name,
    ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti 
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Use unique titles table to create new table "retiring titles"
SELECT COUNT(emp_no), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY count(emp_no) DESC;

-- Join employee, dept_emp, and title tables to create eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name, e.last_name,e.birth_date,
    de.from_date, de.to_date,
    ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;