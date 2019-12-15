SELECT "public"."employment"."em_case_status" AS "em_case_status", count(*) AS "count"
FROM "public"."employment"
GROUP BY "public"."employment"."em_case_status"
ORDER BY "public"."employment"."em_case_status" ASC