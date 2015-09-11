-- Role: machetedb_app_user

-- DROP ROLE machetedb_app_user;

CREATE ROLE machetedb_app_user LOGIN
  PASSWORD 'replace_me'
  SUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION;

