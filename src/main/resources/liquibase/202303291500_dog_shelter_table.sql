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
)