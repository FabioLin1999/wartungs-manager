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




