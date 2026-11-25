DROP TABLE IF EXISTS hour_reading;

create table hour_reading(
    id BIGINT generated always as IDENTITY primary key ,
    machine_id BIGINT NOT NULL ,
   read_at TIMESTAMP NOT NULL,
    hours INT NOT NULL
);

INSERT INTO hour_reading(machine_id, read_at, hours)
SELECT i % 6 + 1,
       TIMESTAMP '2020-01-01' + i * INTERVAL '10 minutes',
       i / 6
FROM generate_series(1, 300000) AS i;

ANALYZE hour_reading;

EXPLAIN ANALYZE
SELECT * FROM hour_reading
WHERE (read_at >= TIMESTAMP '2024-03-01')
  AND (read_at< TIMESTAMP '2024-03-02');

CREATE INDEX idx_hour_reading_read_at ON hour_reading(read_at);

EXPLAIN ANALYZE
SELECT * FROM hour_reading
WHERE (read_at >= TIMESTAMP '2024-03-01')
  AND (read_at< TIMESTAMP '2024-03-02');

EXPLAIN SELECT * FROM hour_reading WHERE read_at::date = DATE '2024-03-01';

DROP TABLE hour_reading;

