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


