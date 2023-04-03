/* Database schema to keep the structure of entire database. */

-- create animals table
CREATE TABLE animals (
    id int primary key not null,
    name varchar(255),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
);

-- Add a column species of type  string to animals table 
ALTER TABLE animals ADD species varchar(255);

-- create owners table
CREATE TABLE owners (
    id int GENERATED ALWAYS AS IDENTITY,
    full_name varchar(255) NOT NULL,
    age int NOT NULL,
    PRIMARY KEY(id)
);

-- create species table
CREATE TABLE species (
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(255) NOT NULL,
    PRIMARY KEY(id)
);

-- Modifying animals table 
ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

-- Remove column species from animals table 
ALTER TABLE animals DROP COLUMN  species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id int;

ALTER TABLE animals  
ADD CONSTRAINT species_fk
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id int;

ALTER TABLE animals
ADD CONSTRAINT owners_fk
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;


-- Create a vets table
CREATE TABLE vets(
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(255) NOT NULL,
    age int NOT NULL,
    date_of_graduation date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE specializations(
    id int GENERATED ALWAYS AS IDENTITY,
    species_id int, 
    vets_id int, 

    CONSTRAINT species_fk
    FOREIGN KEY (species_id)
    REFERENCES species(id), 

    CONSTRAINT vets_fk
    FOREIGN KEY (vets_id)
    REFERENCES vets(id)
);

CREATE TABLE VISITS (
    id INT GENERATED ALWAYS AS IDENTITY, 
    animals_id INT, 
    vets_id INT, 
    visit_date DATE, 

    CONSTRAINT animals_fk 
    FOREIGN KEY (animals_id)
    REFERENCES animals(id), 

    CONSTRAINT vets_fk 
    FOREIGN KEY (vets_id)
    REFERENCES vets(id)
); 

-- Add an email column to owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE owners ALTER COLUMN age INT NULL;

-- Create a non claustered index database
CREATE INDEX visits_asc ON visits(animals_id ASC);
