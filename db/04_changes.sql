UPDATE repair
SET status='DONE',completed_at='2026-11-19 16:30'
WHERE description='Werkzeugwechsler klemmt';

------------
UPDATE repair
SET status='IN_PROGRESS',technician_id=(SELECT id FROM technician WHERE email='sophie.wagner@example.com')
WHERE description='Roboterarm stoppt mit Fehlermeldung';

------------------------------
UPDATE machine
SET operating_hours=operating_hours+120
WHERE location='Halle 3';

-----------------------------
UPDATE maintenance_plan
SET last_done_at_hours = 9920 ,last_done_on='2026-11-19'
WHERE machine_id=(SELECT id FROM machine WHERE inventory_number='M-0005')AND task='Ölwechsel';

------------------------------
DELETE FROM maintenance_plan
WHERE task='Spannfutter reinigen' AND machine_id=(SELECT id FROM machine WHERE inventory_number='M-0002');

------------------------------
UPDATE machine
SET active=false
WHERE inventory_number='M-0006';
