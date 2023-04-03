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

-- Insert data into vets:
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, 'APR-23-2000'),
       ('Maisy Smith', 26, 'JAN-17-2019'),
       ('Stephanie Mendez', 64, 'MAY-04-1981'),
       ('Jack Harkness', 38, 'JUN-08-2008');

-- Insert data into specialties:
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations (species_id, vets_id) 
SELECT species.id, vets.id FROM species 
INNER JOIN vets 
ON species.name = 'Pokemon' AND vets.name = 'William Tatcher'; 

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations (species_id, vets_id) 
SELECT species.id, vets.id FROM species
INNER JOIN vets
ON species.name IN ('Digimon', 'Pokemon') AND vets.name = 'Stephanie Mendez';

-- Vet Jack Harkness is specialized in Digimo
INSERT INTO specializations (species_id, vets_id) 
SELECT species.id, vets.id FROM species
INNER JOIN vets
ON species.name = 'Digimon' AND vets.name = 'Jack Harkness';

-- Insert data into visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'MAY-24-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Agumon' AND vets.name = 'William Tatcher';

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'JUL-22-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Agumon' AND vets.name = 'Stephanie Mendez';

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'FEB-02-2021' FROM animals
INNER JOIN vets
ON animals.name = 'Gabumon' AND vets.name = 'Jack Harkness';

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'JAN-05-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Pikachu' AND vets.name = 'Maisy Smith';

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'MAR-08-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Pikachu' AND vets.name = 'Maisy Smith';

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'MAY-14-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Pikachu' AND vets.name = 'Maisy Smith';

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'MAY-04-2021' FROM animals
INNER JOIN vets
ON animals.name = 'Devimon' AND vets.name = 'Stephanie Mendez';

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'FEB-24-2021' FROM animals
INNER JOIN vets
ON animals.name = 'Charmander' AND vets.name = 'Jack Harkness';

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'DEC-21-2019' FROM animals
INNER JOIN vets
ON animals.name = 'Plantmon' AND vets.name = 'Maisy Smith';

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'AUG-10-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Plantmon' AND vets.name = 'Maisy Smith';

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'APR-07-2021' FROM animals
INNER JOIN vets
ON animals.name = 'Plantmon' AND vets.name = 'Maisy Smith';

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'SEP-29-2019' FROM animals
INNER JOIN vets
ON animals.name = 'Squirtle' AND vets.name = 'Stephanie Mendez';

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'OCT-03-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Angemon' AND vets.name = 'Jack Harkness';

-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'NOV-04-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Angemon' AND vets.name = 'Jack Harkness';

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'JAN-24-2019' FROM animals
INNER JOIN vets
ON animals.name = 'Boarmon' AND vets.name = 'Maisy Smith';

-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'MAY-15-2019' FROM animals
INNER JOIN vets
ON animals.name = 'Boarmon' AND vets.name = 'Maisy Smith';

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'FEB-27-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Boarmon' AND vets.name = 'Maisy Smith';

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'AUG-03-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Boarmon' AND vets.name = 'Maisy Smith';

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'MAY-24-2020' FROM animals
INNER JOIN vets
ON animals.name = 'Blossom' AND vets.name = 'Stephanie Mendez';

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animals_id, vets_id, visit_date)
SELECT animals.id, vets.id, 'JAN-11-2021' FROM animals
INNER JOIN vets
ON animals.name = 'Boarmon' AND vets.name = 'Stephanie Mendez';


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';