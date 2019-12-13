#!/bin/bash
set -e
sleep 5
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command "\\copy employer (e_name, e_address, e_city, e_county, e_state, e_postal, e_province, e_phone, e_phone_ext, e_agent, e_attorney_name, e_attorney_city, e_attorney_state, e_total_workers, e_h1b_dependent, e_wilful_violator) FROM '/seed/employer_unique.psv' DELIMITER '|' CSV HEADER";
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command "\\copy naics (naics_code, naics_title) FROM '/seed/naics_master.psv' DELIMITER '|' CSV HEADER";
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command "\\copy employment (em_case_number, em_year_belongs_to, em_case_status, em_submitted_date, em_decision_date, em_visa_class, em_start_date, em_end_date, em_employer_name, em_job_title, em_soc_code, em_soc_name, em_naics_code, em_fulltime_position) FROM '/seed/employment.psv' DELIMITER '|' CSV HEADER";
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command "\\copy employment_address (ema_case_number, ema_city, ema_county, ema_state, ema_postal_code, ema_county_fips_code) FROM '/seed/employment_address.psv' DELIMITER '|' CSV HEADER ";
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command "\\copy employment_wage (ew_case_number, ew_prevailing_wage, ew_prevailing_wage_unit_pay, ew_wage_pay_from, ew_wage_pay_to, ew_wage_pay_from_unit, ew_wage_pay_to_unit, ew_normalized_wage) FROM '/seed/employment_wage.psv' DELIMITER '|' CSV HEADER";



