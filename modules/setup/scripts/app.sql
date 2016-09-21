create database app;

\c "app";

CREATE TABLE "group" (
    id 		serial NOT NULL,
    name 	character varying(50),
    active 	boolean
);

CREATE TABLE group_tokens (
    group_id integer NOT NULL,
    token_id integer NOT NULL
);


CREATE TABLE token (
    id 		serial NOT NULL,
    name 	character varying(50),
    active 	boolean
);

CREATE TABLE user_tokens (
    user_id 	integer NOT NULL,
    token_id 	integer NOT NULL
);

CREATE TABLE user_groups
(
  user_id integer NOT NULL,
  group_id integer NOT NULL,
  active boolean DEFAULT true
);

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_id PRIMARY KEY (id);

ALTER TABLE ONLY group_tokens
    ADD CONSTRAINT group_token_id PRIMARY KEY (group_id, token_id);

ALTER TABLE ONLY token
    ADD CONSTRAINT token_id PRIMARY KEY (id);

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT user_token_id PRIMARY KEY (user_id, token_id);

ALTER TABLE public.user_groups
  ADD CONSTRAINT user_group_id PRIMARY KEY(user_id, group_id);

CREATE INDEX fki_token_id ON user_tokens USING btree (token_id);

CREATE INDEX fki_token_token_id ON group_tokens USING btree (token_id);

CREATE INDEX token_name_idx ON token USING btree (name text_pattern_ops);

ALTER TABLE ONLY group_tokens
    ADD CONSTRAINT group_id FOREIGN KEY (group_id) REFERENCES "group"(id);

ALTER TABLE ONLY group_tokens
    ADD CONSTRAINT token_id FOREIGN KEY (token_id) REFERENCES token(id);

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT token_id FOREIGN KEY (token_id) REFERENCES token(id);

ALTER TABLE user_groups
  ADD CONSTRAINT group_id FOREIGN KEY (group_id)
      REFERENCES "group" (id);