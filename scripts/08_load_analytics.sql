/*
===============================================================================
Stored Procedure: Load Analytics Layer
===============================================================================

Script Purpose:
    This stored procedure performs the ETL process that loads data from the
    staging schema into the analytics schema.

Actions Performed:
    - Truncates existing analytics tables.
    - Loads patient, provider, organization, payer, and condition dimensions.
    - Generates surrogate identity keys for dimension records.
    - Matches encounter UUIDs to their corresponding dimension keys.
    - Loads one row per encounter into analytics.fact_encounter.
    - Calculates encounter date and patient responsibility.
    - Prints the execution duration for each table.
    - Reports errors through TRY/CATCH error handling.

Usage Example:
    EXEC analytics.load_analytics;
===============================================================================
*/

USE healthcare_analytics;
GO

CREATE OR ALTER PROCEDURE analytics.load_analytics
AS
BEGIN
    DECLARE @start_time DATETIME2,
            @end_time   DATETIME2;

    BEGIN TRY
        PRINT '================================================';
        PRINT 'Loading Analytics Layer';
        PRINT '================================================';

        -- =================================================
        -- Loading analytics.dim_patient
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.dim_patient';
        TRUNCATE TABLE analytics.dim_patient;

        PRINT '>> Inserting Data Into: analytics.dim_patient';

        INSERT INTO analytics.dim_patient (
            patient_id,
            birth_date,
            death_date,
            first_name,
            last_name,
            maiden_name,
            marital_status,
            race,
            ethnicity,
            gender,
            birthplace,
            city,
            state,
            county,
            zip_code,
            latitude,
            longitude
        )
        SELECT
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
            LON
        FROM staging.patients;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        PRINT '>> ---------------------------------------------';

        -- =================================================
        -- Loading analytics.dim_provider
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.dim_provider';
        TRUNCATE TABLE analytics.dim_provider;

        PRINT '>> Inserting Data Into: analytics.dim_provider';

        INSERT INTO analytics.dim_provider (
            provider_id,
            provider_name,
            gender,
            specialty,
            address,
            city,
            state,
            zip_code,
            latitude,
            longitude
        )
        SELECT
            Id,
            NAME,
            GENDER,
            SPECIALITY,
            ADDRESS,
            CITY,
            STATE,
            ZIP,
            LAT,
            LON
        FROM staging.providers;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        PRINT '>> ---------------------------------------------';

        -- =================================================
        -- Loading analytics.dim_organization
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.dim_organization';
        TRUNCATE TABLE analytics.dim_organization;

        PRINT '>> Inserting Data Into: analytics.dim_organization';

        INSERT INTO analytics.dim_organization (
            organization_id,
            organization_name,
            address,
            city,
            state,
            zip_code,
            latitude,
            longitude,
            phone
        )
        SELECT
            Id,
            NAME,
            ADDRESS,
            CITY,
            STATE,
            ZIP,
            LAT,
            LON,
            PHONE
        FROM staging.organizations;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        PRINT '>> ---------------------------------------------';

        -- =================================================
        -- Loading analytics.dim_payer
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.dim_payer';
        TRUNCATE TABLE analytics.dim_payer;

        PRINT '>> Inserting Data Into: analytics.dim_payer';

        INSERT INTO analytics.dim_payer (
            payer_id,
            payer_name,
            address,
            city,
            headquarters_state,
            zip_code,
            phone
        )
        SELECT
            Id,
            NAME,
            ADDRESS,
            CITY,
            STATE_HEADQUARTERED,
            ZIP,
            PHONE
        FROM staging.payers;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        PRINT '>> ---------------------------------------------';

        -- =================================================
        -- Loading analytics.dim_condition
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.dim_condition';
        TRUNCATE TABLE analytics.dim_condition;

        PRINT '>> Inserting Data Into: analytics.dim_condition';

        INSERT INTO analytics.dim_condition (
            condition_code,
            condition_description
        )
        SELECT
            CODE,
            MAX(DESCRIPTION)
        FROM staging.conditions
        GROUP BY CODE;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        PRINT '>> ---------------------------------------------';

        -- =================================================
        -- Loading analytics.fact_encounter
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.fact_encounter';
        TRUNCATE TABLE analytics.fact_encounter;

        PRINT '>> Inserting Data Into: analytics.fact_encounter';

        INSERT INTO analytics.fact_encounter (
            encounter_id,
            patient_key,
            provider_key,
            organization_key,
            payer_key,
            encounter_start,
            encounter_stop,
            encounter_date,
            encounter_class,
            encounter_code,
            encounter_description,
            base_encounter_cost,
            total_claim_cost,
            payer_coverage,
            patient_responsibility,
            reason_code,
            reason_description
        )
        SELECT
            e.Id,
            pat.patient_key,
            prov.provider_key,
            org.organization_key,
            pay.payer_key,
            e.START,
            e.STOP,
            CAST(e.START AS DATE),
            e.ENCOUNTERCLASS,
            e.CODE,
            e.DESCRIPTION,
            e.BASE_ENCOUNTER_COST,
            e.TOTAL_CLAIM_COST,
            e.PAYER_COVERAGE,
            e.TOTAL_CLAIM_COST - e.PAYER_COVERAGE,
            e.REASONCODE,
            e.REASONDESCRIPTION
        FROM staging.encounters e

        LEFT JOIN analytics.dim_patient pat
            ON e.PATIENT = pat.patient_id

        LEFT JOIN analytics.dim_provider prov
            ON e.PROVIDER = prov.provider_id

        LEFT JOIN analytics.dim_organization org
            ON e.ORGANIZATION = org.organization_id

        LEFT JOIN analytics.dim_payer pay
            ON e.PAYER = pay.payer_id;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        -- =================================================
        -- Loading analytics.fact_condition
        -- =================================================

        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: analytics.fact_condition';
        TRUNCATE TABLE analytics.fact_condition;

        PRINT '>> Inserting Data Into: analytics.fact_condition';

        INSERT INTO analytics.fact_condition (
            encounter_id,
            patient_key,
            condition_key,
            condition_start_date,
            condition_stop_date
        )
        SELECT
            enc.encounter_id,
            pat.patient_key,
            cond.condition_key,
            c.START,
            c.STOP
        FROM staging.conditions c

        LEFT JOIN analytics.fact_encounter enc
            ON c.ENCOUNTER = enc.encounter_id

        LEFT JOIN analytics.dim_patient pat
            ON c.PATIENT = pat.patient_id

        LEFT JOIN analytics.dim_condition cond
            ON c.CODE = cond.condition_code;

        SET @end_time = SYSDATETIME();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(20))
            + ' seconds';

        PRINT '>> ---------------------------------------------';
        PRINT '================================================';
        PRINT 'Analytics load completed successfully';
        PRINT '================================================';
    END TRY

    BEGIN CATCH
        PRINT '>> Analytics load failed';
        THROW;
    END CATCH
END;
GO
