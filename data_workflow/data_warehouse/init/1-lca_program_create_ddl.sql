-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp"
CREATE EXTENSION pgcrypto;
-- Table: naics

-- DROP TABLE naics;

CREATE TABLE naics
(
    naics_code integer NOT NULL,
    naics_title character varying(130) COLLATE pg_catalog."default",
    CONSTRAINT naics_pkey PRIMARY KEY (naics_code)
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

    CONSTRAINT "EMPLOYER_pkey" PRIMARY KEY (e_id),
    CONSTRAINT "EMPLOYER_unique" UNIQUE (e_name)
)

TABLESPACE pg_default;

ALTER TABLE employer
    OWNER to postgres;

-- Table: employment

-- DROP TABLE employment;

CREATE TABLE employment
(
    em_case_number character varying(30) COLLATE pg_catalog."default" NOT NULL,
    em_year_belongs_to integer,
    em_case_status character varying(25) COLLATE pg_catalog."default",
    em_submitted_date date,
    em_decision_date date,
    em_visa_class character varying(30) COLLATE pg_catalog."default",
    em_start_date date,
    em_end_date date,
    em_employer_name character varying(100) COLLATE pg_catalog."default",
    em_job_title character varying(80) COLLATE pg_catalog."default",
    em_soc_code character varying(20) COLLATE pg_catalog."default",
    em_soc_name character varying(100) COLLATE pg_catalog."default",
    em_naics_code integer,
    em_fulltime_position boolean,
    CONSTRAINT em_employer_name FOREIGN KEY (em_employer_name)
        REFERENCES employer (e_name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "EMPLOYMENT_pkey" PRIMARY KEY (em_case_number)
)

TABLESPACE pg_default;

ALTER TABLE employment
    OWNER to postgres;
COMMENT ON CONSTRAINT em_employer_name ON employment
    IS 'employer name ';

-- Table: employment_address

-- DROP TABLE employment_address;

CREATE TABLE employment_address
(
    ema_case_number character varying(30) COLLATE pg_catalog."default" NOT NULL,
    ema_city character varying(50) COLLATE pg_catalog."default",
    ema_county character varying(50) COLLATE pg_catalog."default",
    ema_state character varying(30) COLLATE pg_catalog."default",
    ema_postal_code real,
    ema_county_fips_code character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT ema_case_number FOREIGN KEY (ema_case_number)
        REFERENCES employment (em_case_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE employment_address
    OWNER to postgres;
COMMENT ON TABLE employment_address
    IS 'employment or worksite address';

COMMENT ON CONSTRAINT ema_case_number ON employment_address
    IS 'employment case number';



-- Table: employment_wage

-- DROP TABLE employment_wage;

CREATE TABLE employment_wage
(
    ew_case_number character varying(30) COLLATE pg_catalog."default" NOT NULL,
    ew_prevailing_wage real,
    ew_prevailing_wage_unit_pay character varying(10) COLLATE pg_catalog."default",
    ew_wage_pay_from real,
    ew_wage_pay_to real,
    ew_wage_pay_from_unit character varying(10) COLLATE pg_catalog."default",
    ew_wage_pay_to_unit character varying(10) COLLATE pg_catalog."default",
    ew_normalized_wage real,
    CONSTRAINT ew_case_number FOREIGN KEY (ew_case_number)
        REFERENCES employment (em_case_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE employment_wage
    OWNER to postgres;

COMMENT ON CONSTRAINT ew_case_number ON employment_wage
    IS 'employment case number ';

