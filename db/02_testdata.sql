INSERT INTO machine(inventory_number,name,manufacturer,location,commissioned_on,operating_hours)
VALUES ('M-0001','CNC-Fräsmaschine',	'DMG',	'Halle 1',	'2015-03-10	','18450'),
       ('M-0002','CNC-Drehmaschine',	'DMG',	'Halle 1',	'2017-06-01	','12030'),
       ('M-0003','Hydraulikpresse',	NULL,	'Halle 2',	'2012-09-15	','25600'),
       ('M-0004','Schweißroboter',	'KUKA',	'Halle 2',	'2020-01-20	','6400'),
       ('M-0005','Schraubenkompressor',	'Atlas Copco',	'Halle 3',	'2019-11-05	','9800'),
       ('M-0006','Laserschneidanlage',	'TRUMPF',	'Halle 3',	'2023-04-12',default)
;

INSERT INTO technician(name,email)
VALUES ('Jonas Weber','jonas.weber@example.com'),
       ('Lena Fischer','lena.fischer@example.com'),
       ('Murat Yilmaz','murat.yilmaz@example.com'),
       ('Sophie Wagner','sophie.wagner@example.com')
;

INSERT INTO repair(machine_id ,technician_id ,reported_at,completed_at,status,description)
VALUES ((SELECT id FROM machine WHERE inventory_number = 'M-0003'), (SELECT id FROM technician WHERE email = 'jonas.weber@example.com'), '2026-01-12 07:30', '2026-01-12 15:00', 'DONE', 'Hydrauliköl tritt am Zylinder aus'),
       ((SELECT id FROM machine WHERE inventory_number='M-0003'),(SELECT id FROM technician WHERE email='murat.yilmaz@example.com'),'2026-03-03 10:15','2026-03-04 11:00','DONE','Druck baut sich nicht auf'),
       ((SELECT id FROM machine WHERE inventory_number='M-0003'),(SELECT id FROM technician WHERE email='jonas.weber@example.com'),'2026-06-30 14:45','2026-06-30 17:30','DONE','Not-Aus-Schalter defekt'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0003'), NULL, '2026-11-16 08:00', NULL, 'OPEN', 'Ungewöhnliche Geräusche an der Pumpe'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0001'), (SELECT  id FROM  technician WHERE email='lena.fischer@example.com'), '2026-02-20 13:00', '2026-02-21 10:00', 'DONE', 'Spindel läuft unrund'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0001'), (SELECT  id FROM  technician WHERE email='lena.fischer@example.com'), '2026-08-05 09:20', '2026-08-05 12:40', 'DONE', 'Kühlmittelpumpe ausgefallen'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0001'), (SELECT  id FROM  technician WHERE email='murat.yilmaz@example.com'), '2026-11-10 14:00', NULL, 'IN_PROGRESS', 'Werkzeugwechsler klemmt'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0004'), (SELECT  id FROM  technician WHERE email='jonas.weber@example.com'), '2026-04-02 11:30', '2026-04-02 16:00', 'DONE', 'Drahtvorschub blockiert'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0004'),NULL, '2026-11-18 07:10', NULL, 'OPEN', 'Roboterarm stoppt mit Fehlermeldung'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0001'), (SELECT  id FROM  technician WHERE email='lena.fischer@example.com'), '2026-05-14 08:00', '2026-05-14 10:30', 'DONE', 'Spannfutter öffnet nicht'),
       ((SELECT id FROM machine WHERE inventory_number = 'M-0005'), (SELECT  id FROM  technician WHERE email='jonas.weber@example.com'), '2026-09-22 15:45', '2026-09-23 08:00', 'DONE', 'Öldruck zu niedrig')
;
