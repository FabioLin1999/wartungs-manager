DROP TABLE IF EXISTS repair;
DROP TABLE IF EXISTS technician;
DROP TABLE IF EXISTS maintenance_plan;
DROP TABLE IF EXISTS machine;

create table machine(
     id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     inventory_number  VARCHAR(20) NOT NULL UNIQUE ,
     name VARCHAR(100) NOT NULL ,
     manufacturer VARCHAR(100),
     location VARCHAR(50) NOT NULL ,
     commissioned_on Date NOT NULL ,
     operating_hours INT NOT NULL check ( operating_hours>=0 ) default 0,
     active BOOLEAN NOT NULL DEFAULT true
);

create table technician(
     id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
     name   VARCHAR(100) NOT NULL ,
     email  VARCHAR(255) NOT NULL UNIQUE
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

CREATE INDEX idx_repair_machine_id ON repair(machine_id);      -- ← 第 1 个索引写在这里
CREATE INDEX idx_repair_technician_id ON repair(technician_id);      -- ← 第 2 个索引

create table maintenance_plan(
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    machine_id          BIGINT NOT NULL REFERENCES machine(id),
    task                VARCHAR(100) NOT NULL ,
    interval_days       INT check ( interval_days>0 ),
    interval_hours      INT check ( interval_hours>0 ),
    last_done_on        DATE NOT NULL ,
    last_done_at_hours  INT NOT NULL check ( last_done_at_hours>=0 ),
    CHECK ( interval_hours IS NOT NULL or interval_days IS NOT NULL ),
    UNIQUE (machine_id,task)
);




