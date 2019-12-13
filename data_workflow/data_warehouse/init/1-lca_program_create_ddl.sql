-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp"
CREATE EXTENSION pgcrypto;
-- Table: naics

-- DROP TABLE naics;

CREATE TABLE naics
(
    naics_id uuid NOT NULL,
    naics_code integer NOT NULL,
    naics_title character varying(60) COLLATE pg_catalog."default",
    CONSTRAINT naics_pkey PRIMARY KEY (naics_id),
    CONSTRAINT naics_code_unique UNIQUE (naics_code)

)

TABLESPACE pg_default;

ALTER TABLE naics
    OWNER to postgres;
COMMENT ON TABLE naics
    IS 'naics ';    

-- Table: employer

-- DROP TABLE employer;

CREATE TABLE employer
(
    e_id uuid NOT NULL DEFAULT gen_random_uuid(),
    e_name character varying(100) COLLATE pg_catalog."default",
    e_address character varying(60) COLLATE pg_catalog."default",
    e_city character varying(60) COLLATE pg_catalog."default",
    e_county character varying(30) COLLATE pg_catalog."default",
    e_state character varying(3) COLLATE pg_catalog."default",
    e_postal real,
    e_province character varying(30) COLLATE pg_catalog."default",
    e_phone character varying(30) COLLATE pg_catalog."default",
    e_phone_ext character varying(30) COLLATE pg_catalog."default",
    e_agent character varying(30) COLLATE pg_catalog."default",
    e_attorney_name character varying(60) COLLATE pg_catalog."default",
    e_attorney_city character varying(30) COLLATE pg_catalog."default",
    e_attorney_state character varying(30) COLLATE pg_catalog."default",
    e_total_workers real,
    e_h1b_dependent boolean,
    e_wilful_violator boolean,

    CONSTRAINT "EMPLOYER_pkey" PRIMARY KEY (e_id)
)

TABLESPACE pg_default;

ALTER TABLE employer
    OWNER to postgres;

-- Table: employment

-- DROP TABLE employment;

CREATE TABLE employment
(
    em_id character varying(30) COLLATE pg_catalog."default" NOT NULL,
    e_id uuid,
    em_start_date date,
    em_end_date date,
    em_job_title character varying(20) COLLATE pg_catalog."default",
    em_soc_code character varying(20) COLLATE pg_catalog."default",
    em_naics_code integer NOT NULL,
    em_decision_date date,
    em_submitted_date date,
    em_year_belongs_to integer,
    em_case_status character varying(15) COLLATE pg_catalog."default",
    em_visa_class character varying(10) COLLATE pg_catalog."default",
    em_fulltime_position boolean,
    CONSTRAINT employment_pkey PRIMARY KEY (em_id),
    CONSTRAINT e_id FOREIGN KEY (e_id)
        REFERENCES employer (e_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT em_naics_code FOREIGN KEY (em_naics_code)
        REFERENCES naics (naics_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE employment
    OWNER to postgres;
COMMENT ON TABLE employment
    IS 'Employment. case_id is mapped to em_id';

COMMENT ON CONSTRAINT e_id ON employment
    IS 'employer id ';
COMMENT ON CONSTRAINT em_naics_code ON employment
    IS 'naics code';


-- Table: employment_address

-- DROP TABLE employment_address;

CREATE TABLE employment_address
(
    ema_id uuid NOT NULL,
    em_id character varying(20) COLLATE pg_catalog."default",
    e_id uuid,
    ema_city character varying(20) COLLATE pg_catalog."default",
    ema_state character varying(15) COLLATE pg_catalog."default",
    ema_postal_code integer,
    CONSTRAINT employment_address_pkey PRIMARY KEY (ema_id),
    CONSTRAINT e_id FOREIGN KEY (e_id)
        REFERENCES employer (e_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT em_id FOREIGN KEY (em_id)
        REFERENCES employment (em_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE employment_address
    OWNER to postgres;
COMMENT ON TABLE employment_address
    IS 'employment or worksite address';

COMMENT ON CONSTRAINT e_id ON employment_address
    IS 'employer id';
COMMENT ON CONSTRAINT em_id ON employment_address
    IS 'employment id';



-- Table: employment_wage

-- DROP TABLE employment_wage;

CREATE TABLE employment_wage
(
    ew_id uuid NOT NULL,
    em_id character varying COLLATE pg_catalog."default",
    ew_prevailing_wage real,
    ew_prevailing_wage_unit_pay character varying(10) COLLATE pg_catalog."default",
    ew_wage_pay_from real,
    ew_wage_pay_from_unit character varying(10) COLLATE pg_catalog."default",
    ew_wage_pay_to real,
    ew_wage_pay_to_unit character varying(10) COLLATE pg_catalog."default",
    ew_normalized_wage real,
    CONSTRAINT employment_wage_pkey PRIMARY KEY (ew_id),
    CONSTRAINT em_id FOREIGN KEY (em_id)
        REFERENCES employment (em_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE employment_wage
    OWNER to postgres;

COMMENT ON CONSTRAINT em_id ON employment_wage
    IS 'employment id';

