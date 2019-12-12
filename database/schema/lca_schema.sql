--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)

-- Started on 2019-12-12 12:01:41 IST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2912 (class 1262 OID 16384)
-- Name: lca_program; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE lca_program WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_IN' LC_CTYPE = 'en_IN';


ALTER DATABASE lca_program OWNER TO postgres;

\connect lca_program

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16386)
-- Name: lca_group; Type: TABLE; Schema: public; Owner: lca_program
--

CREATE TABLE public.lca_group (
    id bigint NOT NULL,
    name text NOT NULL,
    type character varying(50) NOT NULL,
    title text,
    parent bigint
);


ALTER TABLE public.lca_group OWNER TO lca_program;

--
-- TOC entry 2784 (class 2606 OID 16393)
-- Name: lca_group lca_group_pkey; Type: CONSTRAINT; Schema: public; Owner: lca_program
--

ALTER TABLE ONLY public.lca_group
    ADD CONSTRAINT lca_group_pkey PRIMARY KEY (id);


--
-- TOC entry 2785 (class 2606 OID 16394)
-- Name: lca_group parent; Type: FK CONSTRAINT; Schema: public; Owner: lca_program
--

ALTER TABLE ONLY public.lca_group
    ADD CONSTRAINT parent FOREIGN KEY (parent) REFERENCES public.lca_group(id) NOT VALID;


--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 2912
-- Name: DATABASE lca_program; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE lca_program TO lca_program;


-- Completed on 2019-12-12 12:01:42 IST

--
-- PostgreSQL database dump complete
--

