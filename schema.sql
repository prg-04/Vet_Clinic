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

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

ALTER TABLE animals
DROP CONSTRAINT IF EXISTS animals_pkey;

ALTER TABLE animals
ADD COLUMN id_new SERIAL PRIMARY KEY;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
    FOREIGN KEY(species_id)
    REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
    FOREIGN KEY(owner_id)
    REFERENCES owners(id);


