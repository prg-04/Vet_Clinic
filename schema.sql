/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id integer GENERATED ALWAYS AS IDENTITY, 
	name VARCHAR(40),
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg REAL,
	PRIMARY KEY(id)
)

BEGIN;

ALTER TABLE
ADD COLUMN species VARCHAR(100);



BEGIN;

UPDATE animals
SET species = 'Unspecified';


BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%_mon';

UPDATE animals
SET species = 'pokemon'
WHERE species = 'Unspecified';

COMMIT;
