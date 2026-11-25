SELECT inventory_number,name,commissioned_on
FROM machine
ORDER BY commissioned_on ASC;

SELECT inventory_number,name,operating_hours
FROM machine
WHERE operating_hours>10000;

SELECT count(*)
FROM machine
WHERE location='Halle 2';

SELECT inventory_number
FROM machine
WHERE manufacturer IS NULL ;

SELECT inventory_number
FROM machine
ORDER BY operating_hours DESC
LIMIT 3;

--------------TAG 2

SELECT id,machine_id,status,reported_at
FROM repair
WHERE Status <> 'DONE'
ORDER BY reported_at ASC ;

SELECT count(*)
FROM repair
WHERE technician_id IS NULL;

SELECT count(*)
FROM repair
WHERE reported_at>='2026-01-01'
AND reported_at<'2026-07-01';


------------------Tag 4
SELECT  r.id,r.reported_at,r.status,m.inventory_number,m.name AS machine_name,t.name AS technician_name
FROM repair r
JOIN machine m ON r.machine_id=m.id
JOIN technician t ON t.id=r.technician_id
ORDER BY r.reported_at ASC ;


SELECT m.inventory_number,m.name,r.reported_at,r.description
FROM repair r
JOIN machine m ON r.machine_id=m.id
WHERE r.technician_id =(SELECT r.id FROM technician WHERE email='jonas.weber@example.com')
ORDER BY r.reported_at;

SELECT  r.id,r.reported_at,r.status,m.inventory_number,m.name AS machine_name,t.name AS technician_name
FROM repair r
JOIN machine m ON r.machine_id=m.id
LEFT JOIN technician t ON t.id=r.technician_id
ORDER BY r.reported_at ASC;

SELECT m.inventory_number,m.name,mp.task
FROM machine m
LEFT JOIN maintenance_plan mp on mp.machine_id=m.id
ORDER BY m.inventory_number,mp.task;

SELECT m.inventory_number,m.name
FROM machine m
LEFT JOIN maintenance_plan mp ON mp.machine_id=m.id
WHERE mp.machine_id IS NULL;

SELECT t.name
FROM repair r
LEFT JOIN technician t ON r.technician_id=t.id
WHERE r.technician_id IS NULL;

SELECT m.inventory_number, r.description, r.status
FROM machine m
LEFT JOIN repair r ON r.machine_id = m.id AND  r.status <> 'DONE'
ORDER BY m.inventory_number;

-------------Tag 5
SELECT r.status,count(*) as repair_count
FROM repair r
GROUP BY r.status
ORDER BY r.status;

SELECT m.manufacturer,count(*) as machine_number
FROM machine m
GROUP BY m.manufacturer
ORDER BY  machine_number DESC,m.manufacturer;

SELECT m.location, count(m.id) AS machine_count,
       sum(operating_hours) as total_hours
     ,round(avg(operating_hours)) AS avg_hours
     ,max(operating_hours) AS max_hours
FROM machine m
GROUP BY m.location
ORDER BY m.location;

SELECT m.inventory_number,m.name,count(r.id) as repair_count
FROM machine m
LEFT JOIN repair r on m.id=r.machine_id
GROUP BY m.id,m.name,m.inventory_number
ORDER BY repair_count DESC ,m.inventory_number;

SELECT m.inventory_number,m.name,count(r.id) as repair_count
FROM machine m
LEFT JOIN repair r on m.id=r.machine_id
GROUP BY m.id,m.name,m.inventory_number
ORDER BY repair_count DESC ,m.inventory_number
LIMIT 1;

SELECT t.name,count(r.technician_id) as technician_count
FROM technician t
LEFT JOIN repair r on r.technician_id=t.id
GROUP BY t.name,t.id
ORDER BY technician_count DESC;

SELECT m.inventory_number,count(r.id) as repair_count
FROM machine m
JOIN repair r ON r.machine_id=m.id
GROUP BY m.inventory_number
HAVING count(r.id) >=2
ORDER BY repair_count DESC;

SELECT count(r.id) as repair_as_done,t.name
FROM technician t
LEFT JOIN repair r ON r.technician_id = t.id AND r.status='DONE'
GROUP BY t.name,t.id
ORDER BY repair_as_done DESC;

------------------- Tag 6

SELECT r.description,(r.completed_at-r.reported_at) as duration
FROM repair r
WHERE r.status='DONE'
ORDER BY duration DESC ;

SELECT avg(r.completed_at-r.reported_at),max(r.completed_at-r.reported_at)
FROM repair r
WHERE r.status='DONE';

SELECT r.status,m.inventory_number,r.description,
       (DATE '2026-11-25'-DATE(r.reported_at)) as days_open
FROM repair r
JOIN machine m on r.machine_id=m.id
WHERE r.status<>'DONE'
ORDER BY days_open DESC;

SELECT count(*),EXTRACT(MONTH FROM DATE (r.reported_at)) as month
FROM repair r
WHERE EXTRACT(YEAR FROM r.reported_at) = 2026
GROUP BY month
ORDER BY month ASC ;

SELECT m.inventory_number,
       mp.task,
       (mp.last_done_on + mp.interval_days)                            as next_due_on,
       (mp.last_done_on + mp.interval_days - DATE '2026-11-25')        as days_left,
       (mp.last_done_at_hours + mp.interval_hours - m.operating_hours) as hours_left
FROM maintenance_plan mp
JOIN machine m on mp.machine_id = m.id
ORDER BY m.inventory_number ASC, mp.task;


SELECT m.inventory_number,mp.task,
       (mp.last_done_on+mp.interval_days) as next_due_on,
       (mp.last_done_on+mp.interval_days -DATE '2026-11-25') as days_left,
       (mp.last_done_at_hours+mp.interval_hours-m.operating_hours) as hours_left
FROM maintenance_plan mp
JOIN machine m on mp.machine_id = m.id
WHERE (mp.last_done_on+mp.interval_days -DATE '2026-11-25')<=30
OR  (mp.last_done_at_hours+mp.interval_hours-m.operating_hours)<=200
ORDER BY m.inventory_number ASC,mp.task;

--task 7
SELECT m.inventory_number,mp.task,
 case
     WHEN (mp.last_done_on+mp.interval_days) < DATE '2026-11-25'or
          (mp.last_done_at_hours+mp.interval_hours-m.operating_hours)< 0 THEN 'OVERDUE'
     WHEN (mp.last_done_on+mp.interval_days -DATE '2026-11-25')<=30
         OR  (mp.last_done_at_hours+mp.interval_hours-m.operating_hours)<=200 THEN 'DUE_SOON'
     ELSE 'OK'
     END as Status
FROM maintenance_plan mp
         JOIN machine m on mp.machine_id = m.id
ORDER BY m.inventory_number,mp.task;


SELECT m.inventory_number,
       mp.task,
       (mp.last_done_on + mp.interval_days)                            as next_due_on,
       (mp.last_done_on + mp.interval_days - current_date)             as days_left,
       (mp.last_done_at_hours + mp.interval_hours - m.operating_hours) as hours_left
FROM maintenance_plan mp
         JOIN machine m on mp.machine_id = m.id
ORDER BY m.inventory_number ASC, mp.task;

---------------------------TAG 7

SELECT m.inventory_number,m.name,
       m.operating_hours
FROM machine m
WHERE m.operating_hours > (SELECT avg(operating_hours) FROM machine)
ORDER BY m.operating_hours DESC;

SELECT m.inventory_number,m.name
FROM machine m
WHERE m.id IN (SELECT machine_id FROM repair WHERE status<>'DONE')
ORDER BY  m.inventory_number;

SELECT t.name
FROM technician t
WHERE t.id NOT IN
      (SELECT technician_id FROM repair WHERE repair.technician_id is NOT NULL)
ORDER BY t.name;


WITH plan_due as (
SELECT  (mp.last_done_on + mp.interval_days)  as next_due_on,
        (mp.last_done_at_hours+mp.interval_hours-m.operating_hours) as hours_left,
        m.inventory_number as inventory_number,
        mp.task as task
FROM maintenance_plan mp
JOIN machine m on m.id=mp.machine_id
)
SELECT next_due_on,hours_left,inventory_number,task
FROM  plan_due
WHERE next_due_on<=DATE '2026-11-25'+30 OR hours_left<=200
ORDER BY inventory_number, task;


WITH plan_due as (
    SELECT  (mp.last_done_on + mp.interval_days)  as next_due_on,
            (mp.last_done_at_hours+mp.interval_hours-m.operating_hours) as hours_left,
            m.inventory_number as inventory_number,
            mp.task as task
    FROM maintenance_plan mp
             JOIN machine m on m.id=mp.machine_id
)
SELECT next_due_on,hours_left,inventory_number,task,
    case
     WHEN next_due_on < DATE '2026-11-25'or
          hours_left< 0 THEN 'OVERDUE'
     WHEN next_due_on -DATE '2026-11-25'<=30
         OR  hours_left<=200 THEN 'DUE_SOON'
     ELSE 'OK'
END as Status
FROM  plan_due
ORDER BY inventory_number, task;

WITH repair_count as (SELECT count(r.machine_id) as RCE, r.machine_id
                      FROM repair r
                      group by r.machine_id)
SELECT m.inventory_number, m.name, rc.RCE
FROM repair_count rc
         JOIN machine m on m.id = rc.machine_id
WHERE rc.RCE = (SELECT max(RCE) FROM repair_count)
ORDER BY rc.RCE;