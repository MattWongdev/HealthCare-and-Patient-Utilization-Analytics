/*
===============================================================================
Stored Procedure: staging.load_staging
Purpose: Load and clean raw data into the staging layer
===============================================================================
*/

USE healthcare_analytics;
GO

CREATE OR ALTER PROCEDURE staging.load_staging
AS
BEGIN
    DECLARE
        @execution_start_time DATETIME2,
        @start_time DATETIME2,
        @end_time DATETIME2;

    BEGIN TRY
        SET @execution_start_time = SYSDATETIME();

        PRINT '================================================';
        PRINT 'Loading Staging Layer';
        PRINT '================================================';


        /*=====================================================================
          1. PATIENTS
        =====================================================================*/

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: staging.patients';
        TRUNCATE TABLE staging.patients;

        PRINT '>> Inserting Data Into: staging.patients';

        INSERT INTO staging.patients (
            Id,
            BIRTHDATE,
            DEATHDATE,
            FIRST,
            LAST,
            MAIDEN,
            MARITAL,
            RACE,
            ETHNICITY,
            GENDER,
            BIRTHPLACE,
            CITY,
            STATE,
            COUNTY,
            ZIP,
            LAT,
            LON,
            HEALTHCARE_EXPENSES,
            HEALTHCARE_COVERAGE
        )
        SELECT
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(Id), '')),
            TRY_CONVERT(DATE, NULLIF(TRIM(BIRTHDATE), '')),
            TRY_CONVERT(DATE, NULLIF(TRIM(DEATHDATE), '')),
            NULLIF(TRIM(FIRST), ''),
            NULLIF(TRIM(LAST), ''),
            NULLIF(TRIM(MAIDEN), ''),
            CASE
                WHEN UPPER(TRIM(MARITAL)) = 'M' THEN 'Married'
                WHEN UPPER(TRIM(MARITAL)) = 'S' THEN 'Single'
                ELSE NULLIF(TRIM(MARITAL), '')
            END,
            NULLIF(TRIM(RACE), ''),
            CASE
                WHEN LOWER(TRIM(ETHNICITY)) = 'hispanic' THEN 'Hispanic'
                WHEN LOWER(TRIM(ETHNICITY)) = 'nonhispanic' THEN 'Non-Hispanic'
                ELSE NULLIF(TRIM(ETHNICITY), '')
            END,
            CASE
                WHEN UPPER(TRIM(GENDER)) = 'M' THEN 'Male'
                WHEN UPPER(TRIM(GENDER)) = 'F' THEN 'Female'
                ELSE NULLIF(TRIM(GENDER), '')
            END,
            NULLIF(TRIM(BIRTHPLACE), ''),
            NULLIF(TRIM(CITY), ''),
            UPPER(NULLIF(TRIM(STATE), '')),
            NULLIF(TRIM(COUNTY), ''),
            NULLIF(TRIM(ZIP), ''),
            TRY_CONVERT(DECIMAL(10,7), NULLIF(TRIM(LAT), '')),
            TRY_CONVERT(DECIMAL(10,7), NULLIF(TRIM(LON), '')),
            TRY_CONVERT(
                DECIMAL(18,2),
                TRY_CONVERT(FLOAT, NULLIF(TRIM(HEALTHCARE_EXPENSES), ''))
            ),
            TRY_CONVERT(
                DECIMAL(18,2),
                TRY_CONVERT(FLOAT, NULLIF(TRIM(HEALTHCARE_COVERAGE), ''))
            )
        FROM raw_data.patients;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '------------------------------------------------';


        /*=====================================================================
          2. ORGANIZATIONS
        =====================================================================*/

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: staging.organizations';
        TRUNCATE TABLE staging.organizations;

        PRINT '>> Inserting Data Into: staging.organizations';

        INSERT INTO staging.organizations (
            Id,
            NAME,
            ADDRESS,
            CITY,
            STATE,
            ZIP,
            LAT,
            LON,
            PHONE,
            REVENUE,
            UTILIZATION
        )
        SELECT
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(Id), '')),
            NULLIF(TRIM(NAME), ''),
            NULLIF(TRIM(ADDRESS), ''),
            NULLIF(TRIM(CITY), ''),
            UPPER(NULLIF(TRIM(STATE), '')),
            NULLIF(TRIM(ZIP), ''),
            TRY_CONVERT(DECIMAL(10,7), NULLIF(TRIM(LAT), '')),
            TRY_CONVERT(DECIMAL(10,7), NULLIF(TRIM(LON), '')),
            NULLIF(TRIM(PHONE), ''),
            TRY_CONVERT(
                DECIMAL(18,2),
                TRY_CONVERT(FLOAT, NULLIF(TRIM(REVENUE), ''))
            ),
            TRY_CONVERT(INT, NULLIF(TRIM(UTILIZATION), ''))
        FROM raw_data.organizations;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '------------------------------------------------';


        /*=====================================================================
          3. PROVIDERS
        =====================================================================*/

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: staging.providers';
        TRUNCATE TABLE staging.providers;

        PRINT '>> Inserting Data Into: staging.providers';

        INSERT INTO staging.providers (
            Id,
            ORGANIZATION,
            NAME,
            GENDER,
            SPECIALITY,
            ADDRESS,
            CITY,
            STATE,
            ZIP,
            LAT,
            LON,
            UTILIZATION
        )
        SELECT
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(Id), '')),
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(ORGANIZATION), '')),
            NULLIF(TRIM(NAME), ''),
            CASE
                WHEN UPPER(TRIM(GENDER)) IN ('M', 'MALE') THEN 'Male'
                WHEN UPPER(TRIM(GENDER)) IN ('F', 'FEMALE') THEN 'Female'
                ELSE NULLIF(TRIM(GENDER), '')
            END,
            NULLIF(TRIM(SPECIALITY), ''),
            NULLIF(TRIM(ADDRESS), ''),
            NULLIF(TRIM(CITY), ''),
            UPPER(NULLIF(TRIM(STATE), '')),
            NULLIF(TRIM(ZIP), ''),
            TRY_CONVERT(DECIMAL(10,7), NULLIF(TRIM(LAT), '')),
            TRY_CONVERT(DECIMAL(10,7), NULLIF(TRIM(LON), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(UTILIZATION), ''))
        FROM raw_data.providers;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '------------------------------------------------';


        /*=====================================================================
          4. PAYERS
        =====================================================================*/

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: staging.payers';
        TRUNCATE TABLE staging.payers;

        PRINT '>> Inserting Data Into: staging.payers';

        INSERT INTO staging.payers (
            Id,
            NAME,
            ADDRESS,
            CITY,
            STATE_HEADQUARTERED,
            ZIP,
            PHONE,
            AMOUNT_COVERED,
            AMOUNT_UNCOVERED,
            REVENUE,
            COVERED_ENCOUNTERS,
            UNCOVERED_ENCOUNTERS,
            COVERED_MEDICATIONS,
            UNCOVERED_MEDICATIONS,
            COVERED_PROCEDURES,
            UNCOVERED_PROCEDURES,
            COVERED_IMMUNIZATIONS,
            UNCOVERED_IMMUNIZATIONS,
            UNIQUE_CUSTOMERS,
            QOLS_AVG,
            MEMBER_MONTHS
        )
        SELECT
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(Id), '')),
            NULLIF(TRIM(NAME), ''),
            NULLIF(TRIM(ADDRESS), ''),
            NULLIF(TRIM(CITY), ''),
            UPPER(NULLIF(TRIM(STATE_HEADQUARTERED), '')),
            NULLIF(TRIM(ZIP), ''),
            NULLIF(TRIM(PHONE), ''),
            TRY_CONVERT(DECIMAL(18,2), NULLIF(TRIM(AMOUNT_COVERED), '')),
            TRY_CONVERT(DECIMAL(18,2), NULLIF(TRIM(AMOUNT_UNCOVERED), '')),
            TRY_CONVERT(DECIMAL(18,2), NULLIF(TRIM(REVENUE), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(COVERED_ENCOUNTERS), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(UNCOVERED_ENCOUNTERS), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(COVERED_MEDICATIONS), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(UNCOVERED_MEDICATIONS), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(COVERED_PROCEDURES), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(UNCOVERED_PROCEDURES), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(COVERED_IMMUNIZATIONS), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(UNCOVERED_IMMUNIZATIONS), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(UNIQUE_CUSTOMERS), '')),
            TRY_CONVERT(DECIMAL(18,16), NULLIF(TRIM(QOLS_AVG), '')),
            TRY_CONVERT(INT, NULLIF(TRIM(MEMBER_MONTHS), ''))
        FROM raw_data.payers;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '------------------------------------------------';


        /*=====================================================================
          5. ENCOUNTERS
        =====================================================================*/

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: staging.encounters';
        TRUNCATE TABLE staging.encounters;

        PRINT '>> Inserting Data Into: staging.encounters';

        INSERT INTO staging.encounters (
            Id,
            PATIENT,
            ORGANIZATION,
            PROVIDER,
            PAYER,
            START,
            STOP,
            ENCOUNTERCLASS,
            CODE,
            DESCRIPTION,
            BASE_ENCOUNTER_COST,
            TOTAL_CLAIM_COST,
            PAYER_COVERAGE,
            REASONCODE,
            REASONDESCRIPTION
        )
        SELECT
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(Id), '')),
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(PATIENT), '')),
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(ORGANIZATION), '')),
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(PROVIDER), '')),
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(PAYER), '')),
            TRY_CONVERT(
                DATETIMEOFFSET(0),
                REPLACE(NULLIF(TRIM(START), ''), 'Z', '+00:00')
            ),
            TRY_CONVERT(
                DATETIMEOFFSET(0),
                REPLACE(NULLIF(TRIM(STOP), ''), 'Z', '+00:00')
            ),
            NULLIF(TRIM(ENCOUNTERCLASS), ''),
            NULLIF(TRIM(CODE), ''),
            NULLIF(TRIM(DESCRIPTION), ''),
            TRY_CONVERT(
                DECIMAL(18,2),
                TRY_CONVERT(FLOAT, NULLIF(TRIM(BASE_ENCOUNTER_COST), ''))
            ),
            TRY_CONVERT(
                DECIMAL(18,2),
                TRY_CONVERT(FLOAT, NULLIF(TRIM(TOTAL_CLAIM_COST), ''))
            ),
            TRY_CONVERT(
                DECIMAL(18,2),
                TRY_CONVERT(FLOAT, NULLIF(TRIM(PAYER_COVERAGE), ''))
            ),
            NULLIF(TRIM(REASONCODE), ''),
            NULLIF(TRIM(REASONDESCRIPTION), '')
        FROM raw_data.encounters;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '------------------------------------------------';


        /*=====================================================================
          6. CONDITIONS
        =====================================================================*/

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: staging.conditions';
        TRUNCATE TABLE staging.conditions;

        PRINT '>> Inserting Data Into: staging.conditions';

        INSERT INTO staging.conditions (
            PATIENT,
            ENCOUNTER,
            START,
            STOP,
            CODE,
            DESCRIPTION
        )
        SELECT
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(PATIENT), '')),
            TRY_CONVERT(UNIQUEIDENTIFIER, NULLIF(TRIM(ENCOUNTER), '')),
            TRY_CONVERT(DATE, NULLIF(TRIM(START), '')),
            TRY_CONVERT(DATE, NULLIF(TRIM(STOP), '')),
            NULLIF(TRIM(CODE), ''),
            NULLIF(TRIM(DESCRIPTION), '')
        FROM raw_data.conditions;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '------------------------------------------------';


        /*=====================================================================
          LOAD COMPLETE
        =====================================================================*/

        SET @end_time = SYSDATETIME();

        PRINT '================================================';
        PRINT 'Staging load completed successfully';

        PRINT '>> Total Execution Time: '
            + CAST(
                DATEDIFF(SECOND, @execution_start_time, @end_time)
                AS NVARCHAR(20)
            )
            + ' seconds';

        PRINT '================================================';
    END TRY

    BEGIN CATCH
        PRINT '================================================';
        PRINT 'Staging load failed';
        PRINT 'Error: ' + ERROR_MESSAGE();
        PRINT '================================================';

        THROW;
    END CATCH;
END;
GO

EXEC staging.load_staging;
GO
