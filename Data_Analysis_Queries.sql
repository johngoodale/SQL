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

