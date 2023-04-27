select employee_id, first_name || last_name as "Name",
    salary, job_id, hire_date, manager_id
from employees;

select * from employees;

select first_name||last_name, job_id as "Job", salary, (salary*12)+100 as "Increased Ann_Salary" , salary+100 as "Increased Salary"
from employees;

select last_name || ': 1 Year Salary = $' ||salary*12 as "1 Year Salary"
from employees;

select distinct department_id, job_id
from employees;

select first_name || ' ' || last_name, salary
from employees
where salary not between 7000 and 10000
order by salary;

select last_name as "e and o Name"
from employees
where last_name like '%e%' and last_name like '%o%';

select first_name ||' '|| last_name as Name, job_id, hire_date
from employees
where hire_date between '06/05/20' and '07/05/20'
order by hire_date;

select first_name ||' '|| last_name as Name, salary, job_id, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

select employee_id, last_name ||' '|| first_name as "Name", salary,
        round(salary*1.123, 0) "Increased Salary"
from employees
where department_id = 60;

select INITCAP(first_name || ' ' || last_name) || ' is a ' || UPPER(job_id) "Employee JOBs"
from Employees
where substr(last_name, -1) = 's';

select first_name || ' ' || last_name as "Name", salary,
salary+(salary*commission_pct) as "Salary + Commission",
case when commission_pct is null then 'Salary Only'
    when commission_pct is not null then 'Salary+Commission'
else 'Unknown' end
from employees
order by salary desc;

select first_name || ' ' || last_name as "Name", hire_date,
    TO_CHAR(hire_date, 'day') "Day of the week"
from Employees
order by to_char(hire_date,'d');

select count(distinct manager_id) "Count Managers"
from employees;

select department_id, TO_CHAR(SUM(salary), '$999,999.00') "Sum Salary", 
    TO_CHAR(AVG(salary), '$999,999.00') "Avg Salary" , 
    TO_CHAR(MAX(salary), '$999,999.00') "Max Salary",
    TO_CHAR(MIN(salary), '$999,999.00') "Min SAlary"
from Employees
where department_id is not null
group by department_id
order by department_id asc;

select job_id, AVG(salary) "Avg Salary"
from Employees
where job_id not in('clerk')
group by job_id
having AVG(salary) > 10000 
order by AVG(salary) desc;

desc employees;
desc departments;
desc locations;

select 'BOWSTRINGHERO', e.first_name || ' ' || e.last_name as "Name", e.job_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Oxford';

select d.department_name, COUNT(e.department_id)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_name
having COUNT(e.department_id) >= 5
order by COUNT(e.department_id) desc;

create table job_grades ( grade_level varchar2(3), lowest_sal number, highest_sal number );

insert into job_grades values('A', 1000, 2999);
insert into job_grades values('B', 3000, 5999);
insert into job_grades values('C', 6000, 9999);
insert into job_grades values('D', 10000, 14999);
insert into job_grades values('E', 15000, 24999);
insert into job_grades values('F', 25000, 40000);
commit;

select * from job_grades;

select e.first_name || ' ' || e.last_name "Name", e.job_id, 
     d.department_name, e.hire_date, e.salary, j.grade_level
from employees e, departments d, job_grades j
where e.department_id = d.department_id
    and e.salary between j.lowest_sal and j.highest_sal
order by j.grade_level;

select e.first_name || ' ' || e.last_name || ' report to ' || m.first_name || ' ' || m.last_name
as "Employee vs Manager"
from employees e left outer join employees m
on e.manager_id = m.employee_id;

select first_name ||' '|| last_name, job_id, salary
from employees
where salary > (select salary from employees where last_name = 'Tucker');

select first_name || ' ' || last_name "Name", job_id, salary, hire_date from employees
where (job_id, salary) in(select job_id, min(salary)
                          from employees
                          group by job_id)
order by salary desc; 

select CONCAT(CONCAT(e.first_name, ' '), e.last_name) "Name", e.salary, e.department_id, e.job_id
from employees e
where salary > (select AVG(salary)
                from employees
                where department_id = e.department_id
                group by e.department_id);
                
select e.employee_id, CONCAT(CONCAT(e.first_name, ' '), e.last_name) "Name", e.job_id, e.hire_date
from employees e
where e.department_id = (select department_id
                         from departments
                         where location_id = (select location_id
                                              from locations
                                              where city like 'O%'));
                                              

select e.first_name || ' ' || e.last_name "Name", e.job_id, e.salary, e.department_id,
        (select ROUND(AVG(salary)) "Department Avg Salary"
         from employees
         where department_id = e.department_id) average
from employees e;

select employee_id, job_id
from employees
union
select employee_id, job_id
from job_history;

select employee_id, job_id, department_id
from employees
union all
select employee_id, job_id, department_id
from job_history
order by employee_id;

select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history; 

select employee_id, job_id, to_date(null) "Start Date", to_date(null) "End Date"
from employees
 intersect
select employee_id, job_id, to_date(null) "Start Date", to_date(null) "End Date"
from job_history
where employee_id = 176
 union all
select employee_id, job_id, start_date, end_date
from job_history
where employee_id = 176
order by job_id, "Start Date";

select employee_id
from employees
minus
select employee_id
from job_history;

select employee_id, last_name ||' '|| first_name as "Name", job_id, salary,
    case job_id when 'HR_REP' then 1.10 * salary
                when 'MK_REP' then 1.12 * salary
                when 'PR_REP' then 1.15 * salary
                when 'SA_REP' then 1.18 * salary
                when 'IT_PROG' then 1.20 * salary
    else salary
    end "New Salary"
from employees;

select employee_id, last_name ||' '|| first_name as "Name", hire_date, salary,
    case when hire_date < to_date('2002-01-01', 'yyyy-mm-dd')
        then salary*1.05
        when hire_date < to_date('2003-01-01', 'yyyy-mm-dd')
        then salary*1.03
        when hire_date < to_date('2004-01-01', 'yyyy-mm-dd')
        then salary*1.01
    else salary
        end "New Salary"
from employees
order by hire_date;

select department_id, SUM(salary) "SUM_SAL",
    CASE when SUM(salary) > 100000 then 'Excellent'
         when SUM(salary) > 50000 then 'Good'
         when SUM(salary) > 10000 then 'Medium'
         when SUM(salary) <= 10000 then 'well'
         end "Department Grade Salary"
from employees
group by department_id;

select employee_id, last_name ||' '|| first_name as "Name", job_id, hire_date, salary,
    case when job_id like 'MGR'
         then salary * 1.15
         when job_id like 'MAN'
         then salary * 1.20
         when hire_date < to_date('2005-01-01', 'yyyy-mm-dd') and job_id like 'MGR'
         then salary * 1.25
    else salary
         end "Department Grade Salary"
from employees;

select COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '01', 1)) "1 Month",
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '02', 1)) "2 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '03', 1)) "3 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '04', 1)) "4 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '05', 1)) "5 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '06', 1)) "6 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '07', 1)) "7 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '08', 1)) "8 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '09', 1)) "9 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '10', 1)) "10 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '11', 1)) "11 Month", 
                COUNT(DECODE(TO_CHAR(hire_date, 'MM'), '12', 1)) "12 Month"
from employees
where TO_CHAR(hire_date, 'MM') >= '01' and TO_CHAR(hire_date, 'MM') <='12';

select department_id, job_id, 
    to_char(sum(salary), '$999,999.00') as "Salary SUM",
    count(employee_id) as "COUNT EMPs"
from employees
group by department_id, job_id
order by department_id;

select department_id, job_id,
    to_char(sum(salary), '$999,999.00') as "Salary SUM",
    count(employee_id) as "COUNT EMPs"
from employees
group by rollup(department_id, job_id)
order by department_id;

SELECT department_id, job_id
    , TO_CHAR(SUM(salary),'$999,999.00') as "Salary SUM"
    , COUNT(employee_id) as "COUNT EMPs"
FROM Employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;

SELECT DECODE(GROUPING(department_id),  1, '(ALL-DEPTS)', 0, department_id) "Dept#"
    , DECODE(GROUPING(job_id), 1, '(ALL_JOBS)', 0, job_id) "Jobs"
    , COUNT(employee_id) as "COUNT EMPs", ROUND(AVG(salary*12)) "Avg Ann_sal"
FROM Employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id;

select department_id, sum(salary) as "Sum Salary",
    ntile(4) over (order by sum(salary) desc) as "Bucket#"
from employees
group by department_id
order by 3;

select employee_id, last_name, salary, department_id, Rank() over (partition by department_id order by salary) "Rank",
    DENSE_RANK() over (partition by department_id order by salary) "DENSE_RANK", 
    ROW_NUMBER() over (partition by department_id order by salary) "Row_Number"
from Employees
order by department_id;

select employee_id, last_name, salary, LAG(salary, 1, 0) OVER (order by salary) "Prev_Sal", 
        LEAD(salary, 1, 0) OVER (order by salary) "Next_Sal"
from employees
where department_id = 50
order by salary desc;

select department_id, COUNT(*), Max(last_name) keep ( DENSE_RANK FIRST order by salary) "Max_Emp_Name", 
        Min(last_name) keep (DENSE_RANK LAST order by salary)"Min_Emp_Name"
from employees
group by department_id;

select last_name || ' reports to ' || prior last_name "Walk"
from employees
start with last_name = 'King'
connect by prior employee_id = manager_id;

select PRIOR last_name || ' reports to ' || last_name "Walk"
from employees
start with last_name like 'Olson'
connect by PRIOR manager_id = employee_id;

select level, LPAD('______', 3*(level-1)) || last_name "Hierarchical Query"
from employees
start with last_name like 'King'
connect by prior employee_id = manager_id;

select level, LPAD('______', 3*(level-1)) || last_name "Hierarchical Query"
from employees
start with last_name like 'King'
connect by prior employee_id = manager_id;

select level, LPAD('*********', (level)) || last_name || ' ' || 'job is ' || job_id || 
            ', department name is ' || department_name
from (select e.last_name, e.job_id, d.department_name, e.employee_id, e.manager_id 
      from employees e, departments d
      where e.department_id = d.department_id)
start with last_name like 'King'
connect by prior employee_id = manager_id; 

select SUBSTR(sys_connect_by_path(last_name, '-'), 2) "Name_Path"
from employees
start with manager_id is null
connect by prior employee_id = manager_id;























