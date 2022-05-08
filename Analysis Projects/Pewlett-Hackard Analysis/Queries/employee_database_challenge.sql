-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE dept_emps (
  dept_no VARCHAR NOT NULL,
  	emp_no INT NOT NULL,
  	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT count(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT  first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

--Create Retirement Info table based on birth and hire dates
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- SELECT * FROM retirement_info;

-- Join departments and dept_manager tables
SELECT d.dept_name,
	 dm.emp_no,
	 dm.from_date,
	 dm.to_date,
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
       retirement_info.first_name,
	   retirement_info.last_name,
       dept_emps.to_date
FROM retirement_info
LEFT JOIN dept_emps
ON retirement_info.emp_no = dept_emps.emp_no;

-- Use aliases for cleaner code
SELECT ri.emp_no,
       ri.first_name,
	   ri.last_name,
       de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emps as de
ON ri.emp_no = de.emp_no;

-- save as new table, Current Employees
SELECT ri.emp_no,
       ri.first_name,
	   ri.last_name,
       de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emps as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- SELECT * FROM current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO employees_by_dept
FROM current_emp as ce
LEFT JOIN dept_emps as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM employees_by_dept;


-- List 1. unique employee number, last name, first name, gender, and salary

SELECT e.emp_no, 
	e.last_name,
	e.first_name, 
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emps as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND(de.to_date = '9999-01-01');


-- List 2. A list of managers for each department, including the department number, name, and the manager's employee number, 
-- last name, first name, and the starting and ending employment dates

SELECT dm.dept_no, 
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
--INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);
		
		
-- List 3. Department Retirees: An updated current_emp list that includes everything it currently has, but also the 
-- employee's departments. ** Need the dept_name from the departments table

SELECT ce.emp_no, 
	ce.first_name,
	ce.last_name,
	ce.to_date,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emps AS de
		ON (de.emp_no = ce.emp_no)
	INNER JOIN departments AS d
		ON (d.dept_no = de.dept_no);
		
-- List 4. Employee #, Fname, LName, Dept Name for Sales only

SELECT di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
INTO sales_emps
FROM dept_info as di
WHERE di.dept_name = ('Sales');


-- List 4. Employee #, Fname, LName, Dept Name for Sales and Development Depts

SELECT di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
INTO sales_dev_emps
FROM dept_info as di
WHERE di.dept_name IN ('Sales', 'Development');


-- Start of Challenge Code.

-- Deliverable 1.1 Get employee names, no, titles, from and to date
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	ti.title, 
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name, 
	rt.last_name,
	rt.title
--INTO unique_titles	
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- Get a count of the number of employees who are retiring

SELECT COUNT(ut.title), ut.title 
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;







	








