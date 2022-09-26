/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOL,
    weight_kg DECIMAL
);

/* Add new column species */
ALTER TABLE animals ADD species VARCHAR(100);

/* Create new table owners */

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

/* Create new table species */

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

/* Modify animals table */

ALTER TABLE animals ALTER COLUMN id SET NOT NULL;

ALTER TABLE animals
ALTER id 
ADD GENERATED ALWAYS  AS IDENTITY (START WITH 11 INCREMENT BY 1),
ADD PRIMARY KEY(id);

/* Remove column species */

ALTER TABLE animals DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);

/* Add column owner_id which is a foreign key referencing the owners table */

ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

/* Create vets table */

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    age INT,
    date_of_graduation DATE
);

/* Create specializations table */

CREATE TABLE specializations (
    species_id INT NOT NULL  REFERENCES species(id),
    vet_id INT NOT NULL  REFERENCES vets(id),
    PRIMARY KEY( species_id,vet_id )  UNIQUE
);

/* Create visits table */

CREATE TABLE visits (
    animal_id INT NOT NULL   REFERENCES animals(id),
    vet_id INT NOT NULL  REFERENCES vets(id),
    visit_date DATE NOT NULL   
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
