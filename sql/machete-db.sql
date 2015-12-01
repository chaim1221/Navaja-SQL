-- Database: machetedb

-- DROP DATABASE machetedb;

-- If the database exists, this will just throw an error.

CREATE DATABASE machetedb
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;

