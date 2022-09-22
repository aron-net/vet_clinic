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
