SELECT "Employer"."e_name" AS "e_name", count("Employment"."em_case_number") AS "count"
FROM "public"."employer" "Employer"
LEFT JOIN "public"."employment" "Employment" ON "Employment"."em_employer_name" = "Employer"."e_name"
GROUP BY "Employer"."e_name"
order by count DESC NULLS LAST 
LIMIT 15