/* Populate database with sample data. */

INSERT INTO animals(
    name, 
    date_of_birth, 
    weight_kg, 
    neutered, 
    escape_attempts
    ) VALUES
    ('Agumon', '2020-02-03', 10.23, true,0),
    ('Gabumon','2018-11-15', 8,true, 2),
    ('Pikachu', '2021-01-07', 15.04, false, 1),
    ('Devimon', '2017-05-12', 11, true,5);
    
    
INSERT INTO animals(
    name, 
    date_of_birth, 
    weight_kg,
    neutered,
    escape_attempts
    ) VALUES
    ('Charmander', '2020-02-08', 11,false,0),
    ('Plantmon', '2021-11-15', 5.7, true, 2),
    ('Squirtle', '1993-04-02', 12.13, false, 3),
    ('Angemon','2005-06-12', 45, true,1),
    ('Boarmon','2005-06-07', 20.4, true ,7 ),
    ('Blossom', '1998-10-13', 17, true, 3),
    ('Ditto', '2022-05-14',  22, true, 4);

INSERT INTO owners(
    full_name,
    age
    ) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38),
    ('Professor Oak', 60);
    
INSERT INTO species(
    name
    ) VALUES
    ('Digimon'),
    ('Pokemon');    




INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts, owner_id, species_id)
VALUES
    ('Charmander', '2020-02-08', 11, false, 0, (SELECT id FROM owners WHERE full_name = 'Melody Pond'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ('Plantmon', '2021-11-15', 5.7, true, 2, (SELECT id FROM owners WHERE full_name = 'Bob'), (SELECT id FROM species WHERE name = 'Digimon')),
    ('Squirtle', '1993-04-02', 12.13, false, 3, (SELECT id FROM owners WHERE full_name = 'Melody Pond'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ('Angemon', '2005-06-12', 45, true, 1, (SELECT id FROM owners WHERE full_name = 'Dean Winchester'), (SELECT id FROM species WHERE name = 'Digimon')),
    ('Boarmon', '2005-06-07', 20.4, true, 7, (SELECT id FROM owners WHERE full_name = 'Dean Winchester'), (SELECT id FROM species WHERE name = 'Digimon')),
    ('Blossom', '1998-10-13', 17, true, 3, (SELECT id FROM owners WHERE full_name = 'Melody Pond'), (SELECT id FROM species WHERE name = 'Digimon')),
    ('Ditto', '2022-05-14', 22, true, 4, (SELECT id FROM species WHERE name = 'Pokemon'), NULL); 
    
INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts, owner_id, species_id)
VALUES
    ('Gabumon', NULL, NULL, NULL, NULL, (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'), (SELECT id FROM species WHERE name = 'Digimon')),
    ('Pikachu', NULL, NULL, NULL, NULL, (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'), (SELECT id FROM species WHERE name = 'Pokemon'));


INSERT INTO vets(
	name,
	age,
	date_of_graduation
) Values
("William Tatcher",	45,	"2000-04-23"),
("Maisy Smith"	,26,	"2019-01-17"),
("Stephanie Mendez",64	,"1981-05-04"),
("Jack Harkness",38,	"2008-06-08");




INSERT INTO specializations(
	vet_id,
    species_id
) Values
( (SELECT id FROM vets WHERE name ='William Tatcher') ,(SELECT id FROM species WHERE name ='Pokemon')),
( (SELECT id FROM vets WHERE name ='Stephanie Mendez') ,(SELECT id FROM species WHERE name ='Digimon' AND name = 'Pokemon')),
( (SELECT id FROM vets WHERE name ='Jack Harkness') ,(SELECT id FROM species WHERE name ='Digimon'));



-- Gabumon's visit to Jack Harkness on Feb 2nd, 2021
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02');

-- Pikachu's visits to Maisy Smith
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14');

-- Devimon's visit to Stephanie Mendez on May 4th, 2021
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04');

-- Charmander's visit to Jack Harkness on Feb 24th, 2021
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24');

-- Plantmon's visits
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07');

-- Squirtle's visit to Stephanie Mendez on Sep 29th, 2019
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29');

-- Angemon's visits to Jack Harkness
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04');

-- Boarmon's visits to Maisy Smith
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03');

-- Blossom's visits
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');




