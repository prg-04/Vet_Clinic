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




-- Who was the last animal seen by William Tatcher?

SELECT animals.*
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT animal_id) as num_animals_seen
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');


-- List all vets and their specialties, including vets with no specialties.

SELECT v.name AS vet_name, COALESCE(spec.name, 'No specialty') AS specialty_name
FROM vets v
LEFT JOIN specializations spec ON v.id = spec.vet_id
LEFT JOIN species s ON spec.species_id = s.id;


-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.*
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
  AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


-- What animal has the most visits to vets?

SELECT animals.name as animal_name, COUNT(*) as num_visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY num_visits DESC
LIMIT 1;


-- Who was Maisy Smith's first visit?

SELECT vets.name as vet_name, visits.date_of_visit
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
JOIN vets as maisy_first_vet ON maisy_first_vet.id = (
    SELECT vet_id
    FROM visits
    JOIN animals ON visits.animal_id = animals.id
    WHERE animals.name = 'Maisy Smith'
    ORDER BY visits.date_of_visit ASC
    LIMIT 1
)
WHERE animals.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;


-- Details for the most recent visit: animal information, vet information, and date of visit.

SELECT animals.*, vets.*, visits.date_of_visit
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) as num_visits_without_specialization
FROM visits
LEFT JOIN specializations ON visits.vet_id = specializations.vet_id AND visits.animal_id = specializations.species_id
WHERE specializations.specialization_id IS NULL;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT specialties.name as suggested_specialty
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN specializations ON visits.animal_id = specializations.species_id
JOIN specialties ON specializations.specialty_id = specialties.id
WHERE animals.name = 'Maisy Smith'
GROUP BY specialties.name
ORDER BY COUNT(*) DESC
LIMIT 1;




