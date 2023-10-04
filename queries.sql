/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%_mon';

SELECT * from animals WHERE neutered = true AND escape_attempts < 3;

SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name NOT IN ('Gabumon');

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;



BEGIN;
UPDATE animals
SET species = 'Unspecified';
ROLLBACK;

SELECT species FROM animals;  --verify that change was made before commit
COMMIT;
SELECT species FROM animals;   --verify that change was made after commit



BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%_mon';

UPDATE animals
SET species = 'pokemon'
WHERE species = 'Unspecified';

SELECT * FROM animals; --verify that change was made before commit
COMMIT;
SELECT * FROM animals; --verify that change was made after commit


BEGIN;
DELETE FROM animals;

SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;



BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;

BEGIN;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
SELECT * FROM animals ORDER BY weight_kg DESC;



BEGIN;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * FROM animals; --verify that change was made before commit
COMMIT;
SELECT * FROM animals; --verify that change was made after commit



-- How many animals are there?

SELECT COUNT(*) AS animals_available 
FROM animals;


-- How many animals have never tried to escape?

SELECT COUNT(*) AS animals_that_never_escaped
FROM animals
WHERE escape_attempts = 0;



--  What is the average weight of animals?

SELECT AVG(weight_kg)
AS animals_average_weight 
FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT name, neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY name, neutered
ORDER BY max_escape_attempts DESC;



-- What is the minimum and maximum weight of each type of animal?

SELECT neutered,
       MIN(weight_kg) AS min_weight,
       MAX(weight_kg) AS max_weight
FROM animals
GROUP BY neutered;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT neutered,
       AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY neutered;


BEGIN;

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%_mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

SELECT * FROM animals;
COMMIT;


-- What animals belong to Melody Pond?
SELECT a.name AS animal_name, s.name AS species_name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are Pokemon (their type is Pokemon).

SELECT a.name AS animal_name, s.name AS species_name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animals.

SELECT o.full_name AS owner_name, a.name AS animal_name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?

SELECT s.name AS species_name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.


SELECT a.name AS animal_name, s.name AS species_name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name AS animal_name, s.name AS species_name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.tried_to_escape = false;


-- Who owns the most animals?

SELECT o.full_name AS owner_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;



