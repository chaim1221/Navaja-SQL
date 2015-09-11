CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA IF NOT EXISTS work;

CREATE TABLE IF NOT EXISTS work.order(
    id uuid PRIMARY KEY
  , englishMasteryRequired smallint NOT NULL
  , workerSkillId integer NOT NULL REFERENCES worker.skill
  , masteryRequired smallint NOT NULL
  , timeNeeded timestamp NOT NULL
  , proposedWage decimal NOT NULL
  , active boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS work.offer (
    id integer PRIMARY KEY
  , orderId uuid REFERENCES work.order
  , workerProfileId integer REFERENCES worker.profile
  , meetsSponsorshipRequirements boolean NOT NULL
  , timePromised timestamp NOT NULL
  , counterOffer decimal NOT NULL
  , active boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS work.assignment(
    id integer PRIMARY KEY
  , orderId uuid REFERENCES work.order
  , workerProfileId integer REFERENCES worker.profile
  , distanceFromWorker decimal NOT NULL
  , transportationMethodId integer NOT NULL
  , acceptedWage decimal NOT NULL
  , active boolean NOT NULL
);

-- demographic information is contained in the report schema

