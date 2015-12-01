CREATE SCHEMA IF NOT EXISTS worker;

CREATE TABLE IF NOT EXISTS worker.profile(
    "id" SERIAL PRIMARY KEY
  , "returnCustomer" boolean NOT NULL
  , "receiveUpdates" boolean NOT NULL
  , "name" varchar(50) NOT NULL
  , "email" varchar(254) NOT NULL
  , "password" varchar(250) NOT NULL
  , "phonePrimary" varchar(12) NOT NULL
  , "phoneSecondary" varchar(12)
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS worker.business(
    "id" SERIAL PRIMARY KEY
  , "profileId" integer NOT NULL REFERENCES worker.profile
  , "name" varchar(50) NOT NULL
  , "federalTaxId" varchar(50) NOT NULL
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS worker.address(
    "id" SERIAL PRIMARY KEY
  , "profileId" integer NOT NULL REFERENCES worker.profile
  , "businessId" integer REFERENCES worker.business -- not null = business address
  , "address1" varchar(50) NOT NULL
  , "address2" varchar(50)
  , "city" varchar(50) NOT NULL
  , "state" varchar(2) NOT NULL
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS worker.skill(
    "id" SERIAL PRIMARY KEY
  , "name" varchar(50) NOT NULL
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS worker.sponsorship(
    "id" SERIAL PRIMARY KEY
  , "profileId" integer NOT NULL REFERENCES worker.profile
  , "employerProfileId" integer NOT NULL REFERENCES employer.profile
  , "culture" varchar(5) NOT NULL
  , "workerSkillId" integer NOT NULL REFERENCES worker.skill
  , "mastery" smallint NOT NULL
  , "title" varchar(50) NOT NULL
  , "message" varchar(50) NOT NULL
  , "active" boolean NOT NULL
);
