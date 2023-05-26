-- liquibase formatted sql

-- changeset klikli:1
CREATE TABLE dog
(
    id            BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name          TEXT NOT NULL,
    age           INTEGER NOT NULL ,
    breed         TEXT NOT NULL
);

CREATE TABLE owner_dog
(
    id            BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    chat_id       BIGINT NOT NULL,
    name          TEXT NOT NULL,
    phone         TEXT NOT NULL,
    age           INTEGER NOT NULL,
    dog_id        BIGINT REFERENCES dog(id)
);

CREATE TABLE shelter
(
    id            BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name          TEXT NOT NULL,
    address       TEXT NOT NULL,
    mail          TEXT NOT NULL,
    phone         TEXT NOT NULL,
    opening_hours TIMESTAMP NOT NULL,
    map           BYTEA
);

-- changeset klikli:2

ALTER TABLE owner_dog ADD COLUMN status TEXT;

ALTER TABLE dog ADD COLUMN status TEXT;

-- changeset klikli:3

ALTER TABLE owner_dog ALTER COLUMN status SET  DEFAULT 'IN_SEARCH';

ALTER TABLE dog ALTER COLUMN status SET DEFAULT 'FREE';

-- changeset klikli:4

ALTER TABLE owner_dog ALTER COLUMN age DROP NOT NULL;

ALTER TABLE shelter ALTER COLUMN opening_hours TYPE TEXT;

-- changeset Alex:1

CREATE TABLE volunteer
(
    id     BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name   TEXT NOT NULL,
    phone  TEXT NOT NULL,
    status TEXT NOT NULL
);
-- changeset MarinaGubina:1
CREATE TABLE report
(
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    photo           BYTEA ,
    animal_diet     TEXT NOT NULL ,
    general_info    TEXT NOT NULL ,
    change_behavior TEXT NOT NULL ,
    status          TEXT DEFAULT 'REPORT_POSTED'
);

-- changeset klikli:5

ALTER TABLE report
    ADD COLUMN chat_id BIGINT,
    ADD COLUMN date_message TIMESTAMP,
    ADD COLUMN days BIGINT;

ALTER TABLE report
    ADD COLUMN file_path VARCHAR,
    ADD COLUMN file_size BIGINT;


-- changeset klikli:6

ALTER TABLE report
    DROP COLUMN days,
    DROP COLUMN file_path,
    DROP COLUMN file_size,
    DROP COLUMN photo,
    ALTER COLUMN date_message TYPE DATE;

-- changeset MarinaGubina:2
ALTER TABLE report ADD COLUMN  photo BYTEA;

-- changeset klikli:7

ALTER TABLE report
    ADD COLUMN owner_dog_id BIGINT REFERENCES owner_dog(id);

ALTER TABLE volunteer
    ADD COLUMN chat_id BIGINT;

-- changeset klikli:8

ALTER TABLE owner_dog
    ADD COLUMN number_of_report_days BIGINT;

-- changeset MarinaGubina:3
CREATE TABLE cat
(
    id            BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name          TEXT NOT NULL,
    age           INTEGER NOT NULL ,
    breed         TEXT NOT NULL,
    status        TEXT DEFAULT 'FREE'
);
CREATE TABLE owner_cat
(
    id            BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    chat_id       BIGINT NOT NULL,
    name          TEXT NOT NULL,
    phone         TEXT NOT NULL,
    age           INTEGER,
    status        TEXT DEFAULT 'IN_SEARCH',
    cat_id        BIGINT REFERENCES cat(id),
    number_of_report_days BIGINT
);
-- changeset IlyaBogomolov:1
CREATE TABLE users
(
    id      BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    name    TEXT NOT NULL,
    is_dog  BOOLEAN NOT NULL
);

-- changeset MarinaGubina:4
alter table report rename to "report_dog";
CREATE TABLE report_cat
(
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    photo           BYTEA ,
    animal_diet     TEXT NOT NULL ,
    general_info    TEXT NOT NULL ,
    change_behavior TEXT NOT NULL ,
    status          TEXT DEFAULT 'REPORT_POSTED',
    chat_id         BIGINT,
    date_message    DATE,
    owner_cat_id    BIGINT REFERENCES owner_cat(id)
);

-- changeset klikli:9

ALTER TABLE dog
    ADD COLUMN shelter_id BIGINT;

ALTER TABLE cat
    ADD COLUMN shelter_id BIGINT;