
CREATE DATABASE lca_program;

\connect lca_program;

CREATE TABLE public.lca_group (
    id bigint NOT NULL,
    name text NOT NULL,
    type character varying(50) NOT NULL,
    title text,
    parent bigint
);

ALTER TABLE public.lca_group OWNER TO lca_program;

ALTER TABLE ONLY public.lca_group
    ADD CONSTRAINT lca_group_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.lca_group
    ADD CONSTRAINT parent FOREIGN KEY (parent) REFERENCES public.lca_group(id) NOT VALID;

GRANT ALL ON DATABASE lca_program TO lca_program;

