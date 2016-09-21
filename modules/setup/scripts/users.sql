create database users;

\c "users";

CREATE EXTENSION pgcrypto;

CREATE TABLE "group" (
    id 		serial NOT NULL,
    name 	character varying(50),
    active 	boolean DEFAULT true,
    PRIMARY KEY (id)
);

CREATE TABLE "token" (
    id 		serial NOT NULL,
    name 	character varying(50),
    active 	boolean DEFAULT true,
    PRIMARY KEY (id)
);

CREATE TABLE "user" (
    id 		serial NOT NULL,
    first_name 	character varying(50),
    last_name 	character varying(50),
    email 	character varying(50),
    password 	character varying(10),
    active 	boolean DEFAULT true,
    PRIMARY KEY (id)
);

CREATE TABLE "application" (
    id 		serial NOT NULL,
    name 	character varying(50),
    active 	boolean DEFAULT true,
    PRIMARY KEY (id)
);

CREATE TABLE "group_tokens" (
    group_id 	integer NOT NULL references "group" (id),
    token_id 	integer NOT NULL references "token" (id),
    active 	boolean DEFAULT true,
    PRIMARY KEY (group_id, token_id)
);

CREATE TABLE "user_tokens" (
    user_id 	integer NOT NULL references "user" (id),
    token_id 	integer NOT NULL references "token" (id),
    active 	boolean DEFAULT true,
    PRIMARY KEY (user_id, token_id)
);

CREATE TABLE "user_groups"
(
    user_id  	integer NOT NULL references "user" (id),
    group_id 	integer NOT NULL references "group" (id),
    active 	boolean DEFAULT true,
    PRIMARY KEY (user_id, group_id)
);

CREATE TABLE "application_users" (
    application_id  integer references "application" (id),
    user_id 	    integer references "user" (id),
    active 	    boolean DEFAULT true,
    PRIMARY KEY (application_id, user_id)
);

CREATE TABLE "connected_apps" (
    owner_id	    integer references "user" (id),
    application_id  integer references "application" (id),
    client_id	    character varying(50),
    client_secret   character varying(50),
    active 	    boolean DEFAULT true,
    PRIMARY KEY (owner_id, application_id)
);

CREATE TABLE "access_token" (
    token 	    character varying(50),
    user_id	    integer,
    application_id  integer,
    active 	    boolean DEFAULT true,
    PRIMARY KEY (token)
);