/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%_mon';

SELECT * from animals WHERE neutered = true AND escape_attempts < 3;

SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name NOT IN ('Gabumon');

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
