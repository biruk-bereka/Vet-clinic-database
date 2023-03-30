/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', 'FEB-03-2020', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', 'NOV-15-2018', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', 'JAN-07-2021', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES  (4, 'Devimon', 'MAY-12-2017', 5, true, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES (5, 'Charmander', 'FEB-08-2020', 0, false, -11),
       (6, 'Plantmon', 'NOV-15-2021', 2, true, -5.7),
       (7, 'Squirtle', 'APR-02-1993', 3, false, -12.13),
	   (8, 'Angemon', 'JUN-12-2005', 1, true, -45),
	   (9, 'Boarmon', 'JUN-07-2005', 7, true, 20.4),
       (10, 'Blossom', 'OCT-13-1998', 3, true, 17),
       (11, 'Ditto', 'MAY-14-2022', 4, true, 22);

-- Insert data into the owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

-- Modify inserted animals so it includes the species_id value

-- If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name='Digimon') WHERE name LIKE '%mon';
-- All other animals are Pokemon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name='Pokemon') WHERE name NOT LIKE '%mon';

-- Modifyinserted animals to include owner information (owner_id)

-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon'; 

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu'); 

-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon'); 

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle','Blossom'); 

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon'); 

