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