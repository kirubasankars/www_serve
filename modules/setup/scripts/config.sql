create database config;

\c "config";

CREATE TABLE app (
  id 			integer NOT NULL,
  name  		character varying(20),
  active 		boolean,
  owner 		integer,
  schema_name 	character varying(20),
  login 		character varying(20),
  CONSTRAINT app_id PRIMARY KEY (id)
);

CREATE TABLE site
(
  id 		integer NOT NULL,
  name 		character varying(10),
  active 	boolean,
  parent_id integer,
  CONSTRAINT site_id PRIMARY KEY (id)
);

CREATE TABLE "module"
(
  id 	integer NOT NULL,
  name 	character varying(20),
  CONSTRAINT module_id PRIMARY KEY (id)
);