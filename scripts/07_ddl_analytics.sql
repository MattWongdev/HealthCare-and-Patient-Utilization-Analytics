/*
===============================================================================
DDL Script: Create Analytics Layer Tables
===============================================================================

Script Purpose:
    This script creates the dimension and fact tables used in the analytics
    layer of the healthcare data warehouse.
Actions:
    - Drops existing analytics tables if they already exist.
    - Creates patient, provider, organization, payer, and condition dimensions.
    - Creates the encounter fact table.
    - Adds surrogate identity keys to the dimension tables.
    - Defines the appropriate data types and primary keys.

Warning:
    Running this script drops and recreates the analytics tables. Any existing
    data in these tables will be removed.

Execution Order:
    Run this script after the staging tables have been created.
===============================================================================
*/

-- =================================================
-- Dimension: Patient
-- Grain: One row per patient
-- =================================================

USE healthcare_analytics;
GO

IF OBJECT_ID('analytics.dim_patient', 'U') IS NOT NULL
    DROP TABLE analytics.dim_patient;
GO

CREATE TABLE analytics.dim_patient (
    patient_key     INT IDENTITY(1,1) PRIMARY KEY,
    patient_id      UNIQUEIDENTIFIER NOT NULL UNIQUE,
    birth_date      DATE,
    death_date      DATE,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    maiden_name     VARCHAR(50),
    marital_status  VARCHAR(50),
    race            VARCHAR(50),
    ethnicity       VARCHAR(50),
    gender          VARCHAR(50),
    birthplace      VARCHAR(255),
    city            VARCHAR(50),
    state           VARCHAR(50),
    county          VARCHAR(50),
    zip_code        VARCHAR(10),
    latitude        DECIMAL(10,7),
    longitude       DECIMAL(10,7),
    dwh_create_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Dimension: Provider
-- Grain: One row per provider
-- =================================================

IF OBJECT_ID('analytics.dim_provider', 'U') IS NOT NULL
    DROP TABLE analytics.dim_provider;
GO

CREATE TABLE analytics.dim_provider (
    provider_key    INT IDENTITY(1,1) PRIMARY KEY,
    provider_id     UNIQUEIDENTIFIER NOT NULL UNIQUE,
    provider_name   VARCHAR(255),
    gender          VARCHAR(20),
    specialty       VARCHAR(100),
    address         VARCHAR(255),
    city            VARCHAR(100),
    state           VARCHAR(50),
    zip_code        VARCHAR(10),
    latitude        DECIMAL(10,7),
    longitude       DECIMAL(10,7),
    dwh_create_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Dimension: Organization
-- Grain: One row per organization
-- =================================================

IF OBJECT_ID('analytics.dim_organization', 'U') IS NOT NULL
    DROP TABLE analytics.dim_organization;
GO

CREATE TABLE analytics.dim_organization (
    organization_key  INT IDENTITY(1,1) PRIMARY KEY,
    organization_id   UNIQUEIDENTIFIER NOT NULL UNIQUE,
    organization_name VARCHAR(255),
    address           VARCHAR(255),
    city              VARCHAR(100),
    state             VARCHAR(50),
    zip_code          VARCHAR(10),
    latitude          DECIMAL(10,7),
    longitude         DECIMAL(10,7),
    phone             VARCHAR(50),
    dwh_create_date   DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Dimension: Payer
-- Grain: One row per payer
-- =================================================

IF OBJECT_ID('analytics.dim_payer', 'U') IS NOT NULL
    DROP TABLE analytics.dim_payer;
GO

CREATE TABLE analytics.dim_payer (
    payer_key          INT IDENTITY(1,1) PRIMARY KEY,
    payer_id           UNIQUEIDENTIFIER NOT NULL UNIQUE,
    payer_name         VARCHAR(255),
    address            VARCHAR(255),
    city               VARCHAR(100),
    headquarters_state VARCHAR(50),
    zip_code           VARCHAR(10),
    phone              VARCHAR(50),
    dwh_create_date    DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Dimension: Condition
-- Grain: One row per condition code
-- =================================================

IF OBJECT_ID('analytics.dim_condition', 'U') IS NOT NULL
    DROP TABLE analytics.dim_condition;
GO

CREATE TABLE analytics.dim_condition (
    condition_key         INT IDENTITY(1,1) PRIMARY KEY,
    condition_code        VARCHAR(50) NOT NULL UNIQUE,
    condition_description VARCHAR(255),
    dwh_create_date       DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Fact: Encounter
-- Grain: One row per encounter
-- =================================================

IF OBJECT_ID('analytics.fact_encounter', 'U') IS NOT NULL
    DROP TABLE analytics.fact_encounter;
GO

CREATE TABLE analytics.fact_encounter (
    encounter_id             UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,

    patient_key              INT NOT NULL,
    provider_key             INT NOT NULL,
    organization_key         INT NOT NULL,
    payer_key                INT NOT NULL,

    encounter_start          DATETIMEOFFSET(0),
    encounter_stop           DATETIMEOFFSET(0),
    encounter_date           DATE,

    encounter_class          VARCHAR(50),
    encounter_code           VARCHAR(50),
    encounter_description    VARCHAR(255),

    base_encounter_cost      DECIMAL(18,2),
    total_claim_cost         DECIMAL(18,2),
    payer_coverage           DECIMAL(18,2),
    patient_responsibility   DECIMAL(18,2),

    reason_code              VARCHAR(50),
    reason_description       VARCHAR(255),

    dwh_create_date          DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Fact: Condition
-- Grain: One row per condition occurrence
-- =================================================

IF OBJECT_ID('analytics.fact_condition', 'U') IS NOT NULL
    DROP TABLE analytics.fact_condition;
GO

CREATE TABLE analytics.fact_condition (
    condition_occurrence_key INT IDENTITY(1,1) PRIMARY KEY,
    encounter_id             UNIQUEIDENTIFIER NOT NULL,
    patient_key              INT NOT NULL,
    condition_key            INT NOT NULL,
    condition_start_date     DATE NOT NULL,
    condition_stop_date      DATE,
    dwh_create_date          DATETIME2 DEFAULT SYSDATETIME()
);
GO
