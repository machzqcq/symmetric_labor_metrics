SELECT "Employer"."e_name" AS "e_name", avg("Employment Wage"."ew_normalized_wage") AS "avg"
FROM "public"."employment_wage" "Employment Wage"
LEFT JOIN "public"."employment" "Employment" ON "Employment"."em_case_number" = "Employment Wage"."ew_case_number" LEFT JOIN "public"."employer" "Employer" ON "Employment"."em_employer_name" = "Employer"."e_name"
GROUP BY "Employer"."e_name"
order by avg DESC NULLS LAST 
LIMIT 15