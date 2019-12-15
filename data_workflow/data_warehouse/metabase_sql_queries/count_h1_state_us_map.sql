SELECT "public"."employment_address"."ema_state" AS "ema_state", count(*) AS "count"
FROM "public"."employment_address"
GROUP BY "public"."employment_address"."ema_state"
ORDER BY "public"."employment_address"."ema_state" ASC