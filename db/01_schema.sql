DROP TABLE IF EXISTS repair;
DROP TABLE IF EXISTS technician;
DROP TABLE IF EXISTS machine;

create table machine(
     id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     inventory_number  VARCHAR(20) NOT NULL UNIQUE ,
     name VARCHAR(100) NOT NULL ,
     manufacturer VARCHAR(100),
     location VARCHAR(50) NOT NULL ,
     commissioned_on Date NOT NULL ,
     operating_hours INT check ( operating_hours>=0 ) default 0
);

create table technician(
     id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
     name   VARCHAR(100) NOT NULL ,
     email  VARCHAR(225) NOT NULL UNIQUE
);

create table repair(
     id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
     machine_id     BIGINT NOT NULL REFERENCES machine(id),
     technician_id  BIGINT REFERENCES technician(id),
     reported_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
     description    TEXT NOT NULL,
     status         VARCHAR(20) NOT NULL DEFAULT 'OPEN' CHECK ( status IN ('OPEN','DONE','IN_PROGRESS') ),
     completed_at   TIMESTAMP ,
     CHECK ( completed_at>=reported_at )
);




