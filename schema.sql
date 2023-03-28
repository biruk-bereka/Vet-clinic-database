/* Database schema to keep the structure of entire database. */

-- create animals table
CREATE TABLE animals (
    id int primary key not null,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);
