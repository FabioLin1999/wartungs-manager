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
ORDER BY repair_as_done DESC