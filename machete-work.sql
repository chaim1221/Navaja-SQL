CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE SCHEMA IF NOT EXISTS work;

CREATE TABLE IF NOT EXISTS work.order(
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid()
  , "englishMasteryRequired" smallint NOT NULL
  , "workerSkillId" integer NOT NULL REFERENCES worker.skill
  , "masteryRequired" smallint NOT NULL
  , "timeNeeded" timestamp NOT NULL
  , "proposedWage" decimal NOT NULL
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS work.offer (
    "id" SERIAL PRIMARY KEY
  , "orderId" uuid REFERENCES work.order
  , "workerProfileId" integer REFERENCES worker.profile
  , "meetsSponsorshipRequirements" boolean NOT NULL
  , "timePromised" timestamp NOT NULL
  , "counterOffer" decimal NOT NULL
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS work.assignment(
    "id" SERIAL PRIMARY KEY
  , "orderId" uuid REFERENCES work.order
  , "workerProfileId" integer REFERENCES worker.profile
  , "distanceFromWorker" decimal NOT NULL
  , "transportationMethodId" integer NOT NULL
  , "acceptedWage" decimal NOT NULL
  , "active" boolean NOT NULL
);

-- demographic information is contained in the report schema

