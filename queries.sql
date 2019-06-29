
-- PART 3: Data Analysis --
-- "This is where the fun begins."  

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

    select employees.emp_no, employees.last_name, employees.first_name, employees.gender, cast(salaries.salary as money)
    from employees
    join salaries
    on employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.

    select * from employees
    where hire_date >= '1986-01-01'::date
    and hire_date <=  '1986-12-31'::date;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

    --Note that this lists ALL of the managers for every single department ever. 
    select dept_manager.dept_no as "Department Number",
    departments.dept_name as "Department Name",
    dept_manager.emp_no as "Employee Number",
    employees.last_name as "Last Name",
    employees.first_name as "First Name",
    employees.hire_date as "Start Employment Date",
    dept_manager.to_date as "End employment Date"
    from employees
    inner join dept_manager
    on employees.emp_no = dept_manager.emp_no
    inner join departments
    on dept_manager.dept_no = departments.dept_no;

        --We can add a 
        where dept_manager.to_date = '9999-01-01'::date;
        --To the end of the query above to see all current managers who are currently managers.

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

    -- I'm just going to add the where clause here now. Otherwise there are duplicates everywhere.
    -- I suppose the where clause could be a bit more refined instead of simply relying on 9999-01-01
    -- as indication of currently employed.
    select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
    from employees
    inner join dept_emp
        on dept_emp.emp_no = employees.emp_no
    inner join departments
        on dept_emp.dept_no = departments.dept_no
    where dept_emp.to_date = '9999-01-01'::date;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

    select employees.first_name, employees.last_name
    from employees
    where employees.first_name = 'Hercules'
    and
    employees.last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

    -- select * from departments; 
    -- sales department is d007. Guess we could've also just done the where by dept_name. *shrugs*

    select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
    from employees
    inner join dept_emp
    on dept_emp.emp_no = employees.emp_no
    inner join departments
    on dept_emp.dept_no = departments.dept_no
    where departments.dept_no = 'd007';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

    --Development is d005, sales is d007
    select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
    from employees
    inner join dept_emp
    on dept_emp.emp_no = employees.emp_no
    inner join departments
    on dept_emp.dept_no = departments.dept_no
    where departments.dept_no = 'd007'
    or departments.dept_no = 'd005';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

    select count(last_name), last_name from employees
    group by last_name
    order by last_name asc;
    --Comment: These numbers seem awfully big. And who the heck has "300024" employees besides the US military?
