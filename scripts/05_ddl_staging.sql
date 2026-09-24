/*
===============================================================================
DDL Script: Create Tables in 'staging' Schema
===============================================================================
Script Purpose:
    This script creates tables in the 'staging' schema of the 'healthcare_analytics' database and drops tables if they already
    exist.
===============================================================================
*/
USE healthcare_analytics;
GO
-- =================================================
-- Patients
-- =================================================

IF OBJECT_ID('staging.patients', 'U') IS NOT NULL
    DROP TABLE staging.patients;
GO

CREATE TABLE staging.patients (
    Id                  UNIQUEIDENTIFIER,
    BIRTHDATE           DATE,
    DEATHDATE           DATE,
    FIRST               VARCHAR(50),
    LAST                VARCHAR(50),
    MAIDEN              VARCHAR(50),
    MARITAL             VARCHAR(50),
    RACE                VARCHAR(50),
    ETHNICITY           VARCHAR(50),
    GENDER              VARCHAR(50),
    BIRTHPLACE          VARCHAR(255),
    CITY                VARCHAR(50),
    STATE               VARCHAR(50),
    COUNTY              VARCHAR(50),
    ZIP                 VARCHAR(50),
    LAT                 DECIMAL(10,7),
    LON                 DECIMAL(10,7),
    HEALTHCARE_EXPENSES DECIMAL(18,2),
    HEALTHCARE_COVERAGE DECIMAL(18,2),
    dwh_create_date     DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Encounters
-- =================================================

IF OBJECT_ID('staging.encounters', 'U') IS NOT NULL
    DROP TABLE staging.encounters;
GO

CREATE TABLE staging.encounters (
    Id                  UNIQUEIDENTIFIER,
    PATIENT             UNIQUEIDENTIFIER,
    ORGANIZATION        UNIQUEIDENTIFIER,
    PAYER               UNIQUEIDENTIFIER,
    PROVIDER            UNIQUEIDENTIFIER,
    START               DATETIMEOFFSET(0),
    STOP                DATETIMEOFFSET(0),
    ENCOUNTERCLASS      VARCHAR(50),
    CODE                VARCHAR(50),
    DESCRIPTION         VARCHAR(255),
    BASE_ENCOUNTER_COST DECIMAL(18,2),
    TOTAL_CLAIM_COST    DECIMAL(18,2),
    PAYER_COVERAGE      DECIMAL(18,2),
    REASONCODE          VARCHAR(50),
    REASONDESCRIPTION   VARCHAR(255),
    dwh_create_date     DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Conditions
-- =================================================

IF OBJECT_ID('staging.conditions', 'U') IS NOT NULL
    DROP TABLE staging.conditions;
GO

CREATE TABLE staging.conditions (
    PATIENT       UNIQUEIDENTIFIER,
    ENCOUNTER     UNIQUEIDENTIFIER,
    START         DATE,
    STOP          DATE,
    CODE          VARCHAR(50),
    DESCRIPTION   VARCHAR(255),
    dwh_create_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Providers
-- =================================================

IF OBJECT_ID('staging.providers', 'U') IS NOT NULL
    DROP TABLE staging.providers;
GO

CREATE TABLE staging.providers (
    Id              UNIQUEIDENTIFIER,
    ORGANIZATION    UNIQUEIDENTIFIER,
    NAME            VARCHAR(255),
    GENDER          VARCHAR(20),
    SPECIALITY      VARCHAR(100),
    ADDRESS         VARCHAR(255),
    CITY            VARCHAR(100),
    STATE           VARCHAR(50),
    ZIP             VARCHAR(10),
    LAT             DECIMAL(10,7),
    LON             DECIMAL(10,7),
    UTILIZATION     INT,
    dwh_create_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Organizations
-- =================================================

IF OBJECT_ID('staging.organizations', 'U') IS NOT NULL
    DROP TABLE staging.organizations;
GO

CREATE TABLE staging.organizations (
    Id              UNIQUEIDENTIFIER,
    NAME            VARCHAR(255),
    ADDRESS         VARCHAR(255),
    CITY            VARCHAR(100),
    STATE           VARCHAR(50),
    ZIP             VARCHAR(10),
    LAT             DECIMAL(10,7),
    LON             DECIMAL(10,7),
    PHONE           VARCHAR(50),
    REVENUE         DECIMAL(18,2),
    UTILIZATION     INT,
    dwh_create_date DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- =================================================
-- Payers
-- =================================================

IF OBJECT_ID('staging.payers', 'U') IS NOT NULL
    DROP TABLE staging.payers;
GO

CREATE TABLE staging.payers (
    Id                       UNIQUEIDENTIFIER,
    NAME                     VARCHAR(255),
    ADDRESS                  VARCHAR(255),
    CITY                     VARCHAR(100),
    STATE_HEADQUARTERED      VARCHAR(50),
    ZIP                      VARCHAR(10),
    PHONE                    VARCHAR(50),
    AMOUNT_COVERED           DECIMAL(18,2),
    AMOUNT_UNCOVERED         DECIMAL(18,2),
    REVENUE                  DECIMAL(18,2),
    COVERED_ENCOUNTERS       INT,
    UNCOVERED_ENCOUNTERS     INT,
    COVERED_MEDICATIONS      INT,
    UNCOVERED_MEDICATIONS    INT,
    COVERED_PROCEDURES       INT,
    UNCOVERED_PROCEDURES     INT,
    COVERED_IMMUNIZATIONS    INT,
    UNCOVERED_IMMUNIZATIONS  INT,
    UNIQUE_CUSTOMERS         INT,
    QOLS_AVG                 DECIMAL(18,16),
    MEMBER_MONTHS            INT,
    dwh_create_date          DATETIME2 DEFAULT SYSDATETIME()
);
GO

