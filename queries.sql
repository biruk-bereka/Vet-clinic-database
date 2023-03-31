/*Queries that provide answers to the questions from all projects.*/

--   Find all animals whose name ends in "mon".
  SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
  SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
   SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
    SELECT date_of_birth FROM animals WHERE name IN ('Agumon' , 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg 
   SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.   
   SELECT * FROM animals WHERE neutered = 'true';

-- Find all animals not named Gabumon.
   SELECT * FROM animals WHERE name NOT IN('Gabumon');

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
    SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

-- TRANSACTION
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- Update species to 'digimon' for name ending with 'mon' and 'pokemon' for the rest name;
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
COMMIT;

-- Delete records from animals table and the ROLLBACK;
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- TRANSACTION ADN SAVEPOINT 
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > 'JAN-01-2022';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Aggregate functions and GROUP BY

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name, escape_attempts from animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT animals.name FROM animals  
INNER JOIN owners
ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals
INNER JOIN species
ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM animals
RIGHT JOIN owners 
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(species_id) AS animals_count FROM animals 
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id 
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
 
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(owner_id) FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name ORDER BY COUNT DESC LIMIT 1;

-- Queries for join table
-- Who was the last animal seen by William Tatcher?
SELECT OWNERS.FULL_NAME, COUNT(ANIMALS.*) FROM ANIMALS 
INNER JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID 
GROUP BY OWNERS.FULL_NAME ORDER BY COUNT DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) FROM VETS 
INNER JOIN VISITS 
ON VETS.ID = VISITS.VETS_ID WHERE VETS.NAME = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT VETS.NAME, SPECIES.NAME FROM VETS 
LEFT JOIN specializations ON VETS.ID = specializations.VETS_ID 
LEFT JOIN SPECIES ON specializations.SPECIES_ID = SPECIES.ID;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT ANIMALS.NAME FROM ANIMALS 
INNER JOIN VISITS ON ANIMALS.ID = VISITS.ANIMALS_ID 
INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID 
WHERE VETS.NAME = 'Stephanie Mendez' AND VISIT_DATE BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT ANIMALS.NAME, COUNT(VISITS.*) FROM ANIMALS 
INNER JOIN VISITS ON ANIMALS.ID = VISITS.ANIMALS_ID 
GROUP BY ANIMALS.NAME ORDER BY COUNT DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT ANIMALS.NAME, VISITS.VISIT_DATE FROM ANIMALS 
INNER JOIN VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID 
INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID 
WHERE VETS.NAME = 'Maisy Smith' ORDER BY VISITS.VISIT_DATE LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT ANIMALS.NAME AS ANIMAL_NAME, ANIMALS.DATE_OF_BIRTH, ANIMALS.WEIGHT_KG, VETS.NAME AS VETS_NAME, VETS.AGE, VISITS.VISIT_DATE 
FROM ANIMALS INNER JOIN  VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID 
INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID ORDER BY VISITS.VISIT_DATE DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM ANIMALS 
INNER JOIN VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID 
INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID 
WHERE ANIMALS.SPECIES_ID NOT IN(SELECT SPECIES_ID FROM specializations WHERE VETS_ID = VETS.ID);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT SPECIES.NAME FROM ANIMALS 
INNER JOIN VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID 
INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID 
INNER JOIN SPECIES ON  SPECIES.ID = ANIMALS.SPECIES_ID 
WHERE VETS.NAME = 'Maisy Smith' GROUP BY SPECIES.NAME ORDER BY COUNT(VISITS.*) DESC  LIMIT 1;