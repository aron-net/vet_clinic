CREATE TABLE "animals" (
  "id" integer PRIMARY KEY,
  "name" varchar(100),
  "date_of_birth" date,
  "escape_attempts" integer,
  "neutered" boolean,
  "weight_kg" decimal,
  "species_id" integer,
  "owners_id" integer
);

CREATE TABLE "owners" (
  "id" integer PRIMARY KEY,
  "full_name" varchar(100),
  "age" integer
);

CREATE TABLE "species" (
  "id" integer PRIMARY KEY,
  "name" varchar(100)
);

CREATE TABLE "vets" (
  "id" integer,
  "name" varchar(150),
  "age" integer,
  "date_of_graduation" date
);

CREATE TABLE "specializations" (
  "species_id" integer,
  "vet_id" integer
);

CREATE TABLE "visits" (
  "animal_id" integer,
  "vet_id" integer,
  "visit_date" date
);

ALTER TABLE "visits" ADD FOREIGN KEY ("animal_id") REFERENCES "animals" ("id");

ALTER TABLE "vets" ADD FOREIGN KEY ("id") REFERENCES "visits" ("vet_id");

ALTER TABLE "species" ADD FOREIGN KEY ("id") REFERENCES "animals" ("species_id");

ALTER TABLE "specializations" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "specializations" ADD FOREIGN KEY ("vet_id") REFERENCES "vets" ("id");

ALTER TABLE "animals" ADD FOREIGN KEY ("owners_id") REFERENCES "owners" ("id");
