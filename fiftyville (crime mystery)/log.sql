-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT * FROM crime_scene_reports;

SELECT "name", "transcript"
FROM interviews
WHERE "year" = 2023
AND "month" = 7
AND day = 28
AND "transcript" LIKE "%bakery%";



SELECT DISTINCT(caller."id"),
    caller."name" AS "Thief",
    airports."city",
    receiver."name" AS "Accomplice"

FROM
    phone_calls
JOIN
    people AS caller
    ON pc."caller" = caller."phone_number"
JOIN
    people AS receiver
    ON pc."receiver" = receiver."phone_number"

FROM people
JOIN bakery_security_logs
ON people."license_plate" = bakery_security_logs."license_plate"
JOIN bank_accounts
ON bank_accounts."person_id" = people."id"
JOIN atm_transactions
ON bank_accounts."account_number" = atm_transactions."account_number"
JOIN phone_calls
ON phone_calls."caller" = people."phone_number"
JOIN passengers
ON passengers."passport_number" = people."passport_number"
JOIN flights
ON flights."id" = passengers."flight_id"
JOIN airports
ON airports."id" = flights."destination_airport_id"


WHERE people."license_plate" IN (
    SELECT "license_plate"
    FROM bakery_security_logs
    WHERE "year" = 2023
    AND "month" = 7
    AND "day" = 28
    AND "hour" = 10
    AND "minute" BETWEEN 15 and 25
    AND "activity" = 'exit'
)

AND atm_transactions."atm_location" = 'Leggett Street'
AND atm_transactions."transaction_type" = 'withdraw'
AND phone_calls."duration" < 60

AND people."passport_number" IN (
    SELECT "passport_number"
    FROM passengers
    WHERE "flight_id" = (
        SELECT "id"
        FROM "flights"
        WHERE "origin_airport_id" = (
            SELECT "id"
            FROM airports
            WHERE city = 'Fiftyville'
        )
        AND "year" = 2023
        AND "month" = 7
        AND "day" = 29
        ORDER BY "hour", "minute"
    )
)
