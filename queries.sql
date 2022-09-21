/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND  '2019-12-31';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name='Agumon' OR  name='Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg  >= 10.4 AND weight_kg <= 17.3;

/* transaction update the table col species */

BEGIN;
UPDATE animals
SET species = 'unspicified';

SELECT species FROM animals;

ROLLBACK;

SELECT species FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

SELECT species FROM animals;

UPDATE animals
SET species = 'pokemon' "WHERE" species IS NULL;

SELECT species from animals;

COMMIT;

SELECT * FROM animals;

/* transaction delete all record from the table */

BEGIN;

DELETE FROM animals;

SELECT COUNT(*) FROM animals;

ROLLBACK;

SELECT COUNT(*) FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT milu;

SELECT * FROM animals;

UPDATE animals

SET weight_kg = weight_kg * -1;

ROLLBACK TO milu;

UPDATE animals

SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

SELECT * FROM animals;

/* transaction */

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;

SELECT ROUND(AVG(weight_kg)) FROM animals;

SELECT neutered, ROUND(AVG(escape_attempts)) as attempts FROM animals GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, ROUND(AVG(escape_attempts)) as attempts FROM animals WHERE date_of_birth BETWEEN DATE '1990-01-01' AND '2000-12-31' GROUP BY species;