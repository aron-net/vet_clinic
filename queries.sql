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

/* animals belong to Melody Pond */

SELECT name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';

/* List of all animals pokemon (their type is Pokemon) */

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal.*/

SELECT owners.full_name,animals.name as animals_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

/* animals are there per species */

SELECT species.name, COUNT(*) FROM animals LEFT JOIN species ON animals.species_id = species.id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name FROM animals LEFT JOIN species ON animals.species_id = species.id LEFT JOIN owners ON owner_id = owners.id WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT animals.name FROM animals LEFT JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

/* owns the most animals */

SELECT full_name, COUNT(*) FROM animals LEFT JOIN owners ON owner_id = owners.id GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;

/* Query animals seen by William Tatcher */

SELECT animals.name FROM animals LEFT JOIN visits ON visits.vet_id = animal_id LEFT JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visit_date DESC LIMIT 1;

/* Query different animals Stephanie Mendez see */

SELECT COUNT(animals.name) FROM animals LEFT JOIN visits ON visits.animal_id = animals.id LEFT JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez';

/* Query all vets and their specialties, including vets with no specialties. */

SELECT vets.name as vet_name, species.name as specie_name FROM vets FULL JOIN specializations ON specializations.vet_id = vets.id FULL JOIN species ON species.id = specializations.species_id; 

/* Query all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */

SELECT animals.name FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';

/* Query animal has the most visits to vets */

SELECT animals.name FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;

/* Query was Maisy Smith's first visit */

SELECT animals.name FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' ORDER BY visit_date LIMIT 1;

/* Query details for most recent visit: animal information, vet information, and date of visit. */

SELECT animals.*, vets.*, visit_date FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON vets.id = visits.vet_id ORDER BY visit_date DESC LIMIT 1;

/* Query visits were with a vet that did not specialize in that animal's species */

SELECT COUNT (*) FROM visits FULL JOIN animals ON animals.id = visits.animal_id FULL JOIN vets ON vets.id = visits.vet_id FULL JOIN specializations ON specializations.vet_id = vets.id WHERE specializations.species_id is NULL;

/* Query Maisy Smith species get the most */

SELECT species.name, COUNT(*) FROM visits JOIN animals ON animals.id = visits.animal_id JOIN species ON species.id = animals.species_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(*) DESC LIMIT 1;
