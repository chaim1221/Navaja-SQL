CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE SCHEMA IF NOT EXISTS work;

CREATE TABLE IF NOT EXISTS work.order(
    "id" SERIAL PRIMARY KEY
    --uuid PRIMARY KEY DEFAULT gen_random_uuid()
    --TODO: Get the above working.
  , "employerProfileId" integer NOT NULL REFERENCES employer.profile
  , "englishMasteryRequired" smallint NOT NULL
  , "workerSkillId" integer NOT NULL REFERENCES worker.skill
  , "masteryRequired" smallint NOT NULL
  , "timeNeeded" timestamptz NOT NULL
  , "proposedWage" decimal NOT NULL
  , "active" boolean NOT NULL
);

-- option: use postGIS for location f(x)s
CREATE TABLE IF NOT EXISTS work.offer (
    "id" SERIAL PRIMARY KEY
  , "orderId" integer REFERENCES work.order
  , "workerProfileId" integer REFERENCES worker.profile
  , "meetsSponsorshipRequirements" boolean NOT NULL
  , "location" point NOT NULL
  , "transportationMethodId" integer NOT NULL
  , "timePromised" timestamptz NOT NULL
  , "counterOffer" decimal NOT NULL
  , "active" boolean NOT NULL
);

-- seriously wondering if active should be even allowed here--this is final acceptance
CREATE TABLE IF NOT EXISTS work.assignment(
    "id" SERIAL PRIMARY KEY
  , "offerId" integer REFERENCES work.offer
  , "acceptedWage" decimal NOT NULL
  , "active" boolean NOT NULL
);
