-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
-- John Goodale -employee_db ERD
-- Data Engineering -- use ERD and then import CSVs

CREATE TABLE departments (
    dept_no VARCHAR(4)   NOT NULL,
    dept_name VARCHAR(25)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_emp (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(4)   NOT NULL,
    emp_no INTEGER   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE employees (
    emp_no INTEGER   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(20)   NOT NULL,
    last_name VARCHAR(20)   NOT NULL,
    gender VARCHAR(1)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE salaries (
    emp_no INTEGER   NOT NULL,
    salary INTEGER   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE titles (
    emp_no INTEGER   NOT NULL,
    title VARCHAR(20)   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

--=======================================================================

-- Data Analysis Queries

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees as e
join salaries as s
on e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.
select * from employees
where hire_date between '1985-12-31' and '1987-01-01';

--3. List the manager of each department with the following information: 
--   department number, department name, the manager's employee number, last name, first name, 
--   and start and end employment dates.
select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, e.gender, dm.from_date, dm.to_date
from departments as d
inner join dept_manager as dm on
dm.dept_no = d.dept_no
join employees as e on
e.emp_no = dm.emp_no;

-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, dps.dept_name
from employees as e
inner join dept_emp as de on
e.emp_no = de.emp_no
inner join departments as dps on
de.dept_no = dps.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * from employees
WHERE first_name = 'Hercules' and last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, dps.dept_name
from employees as e
inner join dept_emp as de on
e.emp_no = de.emp_no
inner join departments as dps on
de.dept_no = dps.dept_no
WHERE dps.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their 
--    employee number, last name, first name, and department name.
--select * from departments --dbl checking dept naming
select e.emp_no, e.last_name, e.first_name, dps.dept_name
from employees as e
inner join dept_emp as de on
e.emp_no = de.emp_no
inner join departments as dps on
de.dept_no = dps.dept_no
WHERE dps.dept_name = 'Sales' or dps.dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as "Occurences"
from employees
group by last_name
order by "Occurences" desc;
