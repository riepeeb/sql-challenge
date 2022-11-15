DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

CREATE TABLE employees (
    emp_no INT,
    emp_title VARCHAR(5),
	birth_date date,
    first_name VARCHAR(16),
    last_name VARCHAR(16),
    sex VARCHAR(1),    
    hire_date date
);

SELECT * from employees; 

CREATE TABLE departments (
    dept_no VARCHAR(4),
    dept_name   VARCHAR(40),
    PRIMARY KEY (dept_no),
    UNIQUE (dept_name)
);

SELECT * from departments;

CREATE TABLE dept_manager (
	dept_no VARCHAR(4),
	emp_no INT,
   PRIMARY KEY (emp_no,dept_no)
); 

SELECT * from dept_manager;

CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR(4),
   PRIMARY KEY (emp_no,dept_no)
);

SELECT * from dept_emp;

CREATE TABLE titles (
	title_id VARCHAR(5),
	title VARCHAR(40),
	UNIQUE (title_id, title)
);

SELECT * from titles;

CREATE TABLE salaries (
	emp_no INT,
    salary INT,
    PRIMARY KEY (emp_no)
); 

SELECT * from salaries;

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
	FROM employees
	INNER JOIN salaries 
	ON employees.emp_no = salaries.emp_no 
	ORDER BY emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
	FROM employees
	WHERE
	hire_date BETWEEN '1986-01-01'
	AND '1986-12-31'
	ORDER BY last_name;


-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
	FROM departments
	JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
	JOIN employees ON dept_manager.emp_no = employees.emp_no;


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM dept_emp
	JOIN employees ON dept_emp.emp_no = employees.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
	FROM employees
	WHERE
	first_name = 'Hercules'
	AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM dept_emp
	JOIN employees ON dept_emp.emp_no = employees.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no
	WHERE departments.dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	FROM dept_emp
	JOIN employees ON dept_emp.emp_no = employees.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no
	WHERE departments.dept_name = 'Sales'
	OR departments.dept_name = 'Development';


-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT (last_name) AS "frequency"
	FROM employees
	GROUP BY last_name
	ORDER BY "frequency" DESC;
