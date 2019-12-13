#!/bin/bash
set -e
sleep 10
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command "\\copy employer (e_name, e_address, e_city, e_county, e_state, e_postal, e_province, e_phone, e_phone_ext, e_agent, e_attorney_name, e_attorney_city, e_attorney_state, e_total_workers, e_h1b_dependent, e_wilful_violator) FROM '/seed/employer.psv' DELIMITER '|' CSV HEADER";