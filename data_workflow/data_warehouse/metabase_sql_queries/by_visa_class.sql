SELECT "public"."employment"."em_visa_class" AS "em_visa_class", count(*) AS "count"
FROM "public"."employment"
GROUP BY "public"."employment"."em_visa_class"
ORDER BY "public"."employment"."em_visa_class" ASC