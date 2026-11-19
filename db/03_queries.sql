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
