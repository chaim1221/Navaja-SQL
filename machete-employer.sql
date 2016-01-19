﻿CREATE SCHEMA IF NOT EXISTS employer;

CREATE TABLE IF NOT EXISTS employer.profile(
    "id" SERIAL PRIMARY KEY
  , "returnCustomer" boolean NOT NULL
  , "receiveUpdates" boolean NOT NULL
  , "name" varchar(50) NOT NULL
  , "email" varchar(254) NOT NULL
  , "password" varchar(250) NOT NULL
  , "active" boolean NOT NULL
);
ALTER TABLE employer.profile
    ADD CONSTRAINT employer_profile_email_key UNIQUE (email);

CREATE TABLE IF NOT EXISTS employer.business(
    "id" SERIAL PRIMARY KEY
  , "profileId" integer NOT NULL REFERENCES employer.profile
  , "name" varchar(50) NOT NULL
  , "federalTaxId" varchar(50) NOT NULL
  , "active" boolean NOT NULL
);

-- an employer must have an address record to hire a worker
CREATE TABLE IF NOT EXISTS employer.address(
    "id" SERIAL PRIMARY KEY
  , "profileId" integer NOT NULL REFERENCES employer.profile
  , "businessId" integer REFERENCES employer.business -- not null = business address
  , "address1" varchar(50) NOT NULL
  , "address2" varchar(50)
  , "city" varchar(50) NOT NULL
  , "state" varchar(2) NOT NULL
  , "phonePrimary" varchar(12) NOT NULL
  , "phoneSecondary" varchar(12)
  , "active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS employer.review(
    "id" SERIAL PRIMARY KEY
  , "profileId" integer NOT NULL REFERENCES employer.profile
  , "rating" smallint NOT NULL
  , "culture" varchar(5) NOT NULL
  , "title" varchar(50) 
  , "message" varchar(200) 
  , "active" boolean NOT NULL
);

