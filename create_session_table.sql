-- Script to create Django session table
-- Run this if Django migrations aren't working

CREATE TABLE IF NOT EXISTS django_session (
    session_key varchar(40) NOT NULL PRIMARY KEY,
    session_data longtext NOT NULL,
    expire_date datetime(6) NOT NULL
);

CREATE INDEX IF NOT EXISTS django_session_expire_date_idx ON django_session (expire_date); 