BEGIN ;

UPDATE repair
SET status='DONE',
    technician_id=(SELECT id FROM technician WHERE email = 'murat.yilmaz@example.com'),
    completed_at=TIMESTAMP '2026-11-25 14:00'
WHERE description='Ungewöhnliche Geräusche an der Pumpe';


UPDATE maintenance_plan
SET last_done_on=DATE '2026-11-25',
    last_done_at_hours=
        (SELECT operating_hours FROM machine WHERE inventory_number='M-0003')
WHERE task='Hydrauliköl wechseln'
;

COMMIT ;