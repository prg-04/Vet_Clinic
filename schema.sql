/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	name VARCHAR(40),
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg REAL,
)


