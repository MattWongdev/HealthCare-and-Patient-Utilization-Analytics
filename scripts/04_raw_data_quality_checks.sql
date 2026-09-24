/*
===============================================================================
RAW DATA QUALITY CHECKS
===============================================================================
*/

USE healthcare_analytics;
GO


/*=============================================================================
  1. PATIENTS
=============================================================================*/

-- Check for missing primary keys
SELECT *
FROM raw_data.patients
WHERE NULLIF(TRIM(Id), '') IS NULL;


-- Check for duplicate primary keys
SELECT
    Id,
    COUNT(*) AS duplicate_count
FROM raw_data.patients
GROUP BY Id
HAVING COUNT(*) > 1;


-- Check for death dates before birth dates
SELECT *
FROM raw_data.patients
WHERE TRY_CONVERT(DATE, DEATHDATE)
    < TRY_CONVERT(DATE, BIRTHDATE);


-- Check for invalid latitude or longitude
SELECT *
FROM raw_data.patients
WHERE TRY_CONVERT(DECIMAL(10,7), LAT) NOT BETWEEN -90 AND 90
   OR TRY_CONVERT(DECIMAL(10,7), LON) NOT BETWEEN -180 AND 180;


-- Check for negative healthcare expenses or coverage
SELECT *
FROM raw_data.patients
WHERE TRY_CONVERT(FLOAT, HEALTHCARE_EXPENSES) < 0
   OR TRY_CONVERT(FLOAT, HEALTHCARE_COVERAGE) < 0;


/*=============================================================================
  2. ENCOUNTERS
=============================================================================*/

-- Preview encounter data
SELECT TOP (10) *
FROM raw_data.encounters;


-- Check for missing primary keys
SELECT *
FROM raw_data.encounters
WHERE NULLIF(TRIM(Id), '') IS NULL;


-- Check for duplicate encounter IDs
SELECT
    Id,
    COUNT(*) AS duplicate_count
FROM raw_data.encounters
GROUP BY Id
HAVING COUNT(*) > 1;


-- Check for stop times before start times
SELECT *
FROM raw_data.encounters
WHERE TRY_CONVERT(DATETIMEOFFSET(0), [STOP])
    < TRY_CONVERT(DATETIMEOFFSET(0), [START]);


-- Check for negative costs
SELECT *
FROM raw_data.encounters
WHERE TRY_CONVERT(FLOAT, BASE_ENCOUNTER_COST) < 0
   OR TRY_CONVERT(FLOAT, TOTAL_CLAIM_COST) < 0
   OR TRY_CONVERT(FLOAT, PAYER_COVERAGE) < 0;


-- Review reason codes and descriptions
SELECT DISTINCT
    REASONCODE,
    REASONDESCRIPTION
FROM raw_data.encounters;


/*=============================================================================
  3. CONDITIONS
=============================================================================*/

-- Review condition descriptions
SELECT DISTINCT
    DESCRIPTION
FROM raw_data.conditions;


-- Check for missing required values
SELECT *
FROM raw_data.conditions
WHERE NULLIF(TRIM(PATIENT), '') IS NULL
   OR NULLIF(TRIM(ENCOUNTER), '') IS NULL
   OR NULLIF(TRIM(CODE), '') IS NULL
   OR NULLIF(TRIM([START]), '') IS NULL;


-- Check for conditions ending before they started
SELECT *
FROM raw_data.conditions
WHERE TRY_CONVERT(DATE, [STOP])
    < TRY_CONVERT(DATE, [START]);


/*=============================================================================
  4. PROVIDERS
=============================================================================*/

-- Preview provider data
SELECT TOP (10) *
FROM raw_data.providers;


-- Check for missing primary keys
SELECT *
FROM raw_data.providers
WHERE NULLIF(TRIM(Id), '') IS NULL;


-- Check for duplicate provider IDs
SELECT
    Id,
    COUNT(*) AS duplicate_count
FROM raw_data.providers
GROUP BY Id
HAVING COUNT(*) > 1;


-- Check for invalid latitude or longitude
SELECT *
FROM raw_data.providers
WHERE TRY_CONVERT(DECIMAL(10,7), LAT) NOT BETWEEN -90 AND 90
   OR TRY_CONVERT(DECIMAL(10,7), LON) NOT BETWEEN -180 AND 180;


-- Check for negative utilization
SELECT *
FROM raw_data.providers
WHERE TRY_CONVERT(INT, UTILIZATION) < 0;


/*=============================================================================
  5. ORGANIZATIONS
=============================================================================*/

-- Preview organization data
SELECT TOP (10) *
FROM raw_data.organizations;


-- Check for duplicate organization IDs
SELECT
    Id,
    COUNT(*) AS duplicate_count
FROM raw_data.organizations
GROUP BY Id
HAVING COUNT(*) > 1;


-- Check for missing or invalid IDs and names
SELECT *
FROM raw_data.organizations
WHERE TRY_CONVERT(
          UNIQUEIDENTIFIER,
          NULLIF(TRIM(Id), '')
      ) IS NULL
   OR NULLIF(TRIM(NAME), '') IS NULL;


-- Check for invalid latitude or longitude
SELECT *
FROM raw_data.organizations
WHERE TRY_CONVERT(DECIMAL(10,7), LAT) NOT BETWEEN -90 AND 90
   OR TRY_CONVERT(DECIMAL(10,7), LON) NOT BETWEEN -180 AND 180;


-- Check for negative revenue or utilization
SELECT *
FROM raw_data.organizations
WHERE TRY_CONVERT(FLOAT, REVENUE) < 0
   OR TRY_CONVERT(INT, UTILIZATION) < 0;


/*=============================================================================
  6. PAYERS
=============================================================================*/

-- Preview payer data
SELECT TOP (10) *
FROM raw_data.payers;


-- Check for missing primary keys
SELECT *
FROM raw_data.payers
WHERE NULLIF(TRIM(Id), '') IS NULL;


-- Check for duplicate payer IDs
SELECT
    Id,
    COUNT(*) AS duplicate_count
FROM raw_data.payers
GROUP BY Id
HAVING COUNT(*) > 1;


-- Check for negative numeric values
SELECT *
FROM raw_data.payers
WHERE TRY_CONVERT(FLOAT, AMOUNT_COVERED) < 0
   OR TRY_CONVERT(FLOAT, AMOUNT_UNCOVERED) < 0
   OR TRY_CONVERT(FLOAT, REVENUE) < 0
   OR TRY_CONVERT(INT, COVERED_ENCOUNTERS) < 0
   OR TRY_CONVERT(INT, UNCOVERED_ENCOUNTERS) < 0
   OR TRY_CONVERT(INT, UNIQUE_CUSTOMERS) < 0
   OR TRY_CONVERT(INT, MEMBER_MONTHS) < 0;
