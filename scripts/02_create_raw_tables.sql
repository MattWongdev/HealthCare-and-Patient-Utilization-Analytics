
/*
===============================================================================
DDL Script: Create Tables in 'raw_data' Schema
===============================================================================
Script Purpose:
    This script creates tables in the 'raw_data' schema of the 'healthcare_analytics' database and drops tables if they already
    exist.
===============================================================================
*/

USE healthcare_analytics;
GO

-- =================================================
-- Patients
-- =================================================

IF OBJECT_ID('raw_data.patients', 'U') IS NOT NULL
    DROP TABLE raw_data.patients;
GO

CREATE TABLE raw_data.patients (
    Id                  NVARCHAR(MAX),
    BIRTHDATE           NVARCHAR(MAX),
    DEATHDATE           NVARCHAR(MAX),
    SSN                 NVARCHAR(MAX),
    DRIVERS             NVARCHAR(MAX),
    PASSPORT            NVARCHAR(MAX),
    PREFIX              NVARCHAR(MAX),
    FIRST               NVARCHAR(MAX),
    LAST                NVARCHAR(MAX),
    SUFFIX              NVARCHAR(MAX),
    MAIDEN              NVARCHAR(MAX),
    MARITAL             NVARCHAR(MAX),
    RACE                NVARCHAR(MAX),
    ETHNICITY           NVARCHAR(MAX),
    GENDER              NVARCHAR(MAX),
    BIRTHPLACE          NVARCHAR(MAX),
    ADDRESS             NVARCHAR(MAX),
    CITY                NVARCHAR(MAX),
    STATE               NVARCHAR(MAX),
    COUNTY              NVARCHAR(MAX),
    ZIP                 NVARCHAR(MAX),
    LAT                 NVARCHAR(MAX),
    LON                 NVARCHAR(MAX),
    HEALTHCARE_EXPENSES NVARCHAR(MAX),
    HEALTHCARE_COVERAGE NVARCHAR(MAX)
);
GO

-- =================================================
-- Encounters
-- =================================================

IF OBJECT_ID('raw_data.encounters', 'U') IS NOT NULL
    DROP TABLE raw_data.encounters;
GO

CREATE TABLE raw_data.encounters (
    Id                  NVARCHAR(MAX),
    START               NVARCHAR(MAX),
    STOP                NVARCHAR(MAX),
    PATIENT             NVARCHAR(MAX),
    ORGANIZATION        NVARCHAR(MAX),
    PROVIDER            NVARCHAR(MAX),
    PAYER               NVARCHAR(MAX),
    ENCOUNTERCLASS      NVARCHAR(MAX),
    CODE                NVARCHAR(MAX),
    DESCRIPTION         NVARCHAR(MAX),
    BASE_ENCOUNTER_COST NVARCHAR(MAX),
    TOTAL_CLAIM_COST    NVARCHAR(MAX),
    PAYER_COVERAGE      NVARCHAR(MAX),
    REASONCODE          NVARCHAR(MAX),
    REASONDESCRIPTION   NVARCHAR(MAX)
);
GO

-- =================================================
-- Conditions
-- =================================================

IF OBJECT_ID('raw_data.conditions', 'U') IS NOT NULL
    DROP TABLE raw_data.conditions;
GO

CREATE TABLE raw_data.conditions (
    START         NVARCHAR(MAX),
    STOP          NVARCHAR(MAX),
    PATIENT       NVARCHAR(MAX),
    ENCOUNTER     NVARCHAR(MAX),
    CODE          NVARCHAR(MAX),
    DESCRIPTION   NVARCHAR(MAX)
);
GO

-- =================================================
-- Procedures
-- =================================================

IF OBJECT_ID('raw_data.procedures', 'U') IS NOT NULL
    DROP TABLE raw_data.procedures;
GO

CREATE TABLE raw_data.procedures (
    START             NVARCHAR(MAX),
    STOP              NVARCHAR(MAX),
    PATIENT           NVARCHAR(MAX),
    ENCOUNTER         NVARCHAR(MAX),
    CODE              NVARCHAR(MAX),
    DESCRIPTION       NVARCHAR(MAX),
    BASE_COST         NVARCHAR(MAX),
    REASONCODE        NVARCHAR(MAX),
    REASONDESCRIPTION NVARCHAR(MAX)
);
GO

-- =================================================
-- Medications
-- =================================================

IF OBJECT_ID('raw_data.medications', 'U') IS NOT NULL
    DROP TABLE raw_data.medications;
GO

CREATE TABLE raw_data.medications (
    START             NVARCHAR(MAX),
    STOP              NVARCHAR(MAX),
    PATIENT           NVARCHAR(MAX),
    PAYER             NVARCHAR(MAX),
    ENCOUNTER         NVARCHAR(MAX),
    CODE              NVARCHAR(MAX),
    DESCRIPTION       NVARCHAR(MAX),
    BASE_COST         NVARCHAR(MAX),
    PAYER_COVERAGE    NVARCHAR(MAX),
    DISPENSES         NVARCHAR(MAX),
    TOTALCOST         NVARCHAR(MAX),
    REASONCODE        NVARCHAR(MAX),
    REASONDESCRIPTION NVARCHAR(MAX)
);
GO

-- =================================================
-- Allergies
-- =================================================

IF OBJECT_ID('raw_data.allergies', 'U') IS NOT NULL
    DROP TABLE raw_data.allergies;
GO

CREATE TABLE raw_data.allergies (
    START         NVARCHAR(MAX),
    STOP          NVARCHAR(MAX),
    PATIENT       NVARCHAR(MAX),
    ENCOUNTER     NVARCHAR(MAX),
    CODE          NVARCHAR(MAX),
    SYSTEM        NVARCHAR(MAX),
    DESCRIPTION   NVARCHAR(MAX),
    TYPE          NVARCHAR(MAX),
    CATEGORY      NVARCHAR(MAX),
    REACTION1     NVARCHAR(MAX),
    DESCRIPTION1  NVARCHAR(MAX),
    SEVERITY1     NVARCHAR(MAX),
    REACTION2     NVARCHAR(MAX),
    DESCRIPTION2  NVARCHAR(MAX),
    SEVERITY2     NVARCHAR(MAX)
);
GO

-- =================================================
-- Care Plans
-- =================================================

IF OBJECT_ID('raw_data.careplans', 'U') IS NOT NULL
    DROP TABLE raw_data.careplans;
GO

CREATE TABLE raw_data.careplans (
    Id                NVARCHAR(MAX),
    START             NVARCHAR(MAX),
    STOP              NVARCHAR(MAX),
    PATIENT           NVARCHAR(MAX),
    ENCOUNTER         NVARCHAR(MAX),
    CODE              NVARCHAR(MAX),
    DESCRIPTION       NVARCHAR(MAX),
    REASONCODE        NVARCHAR(MAX),
    REASONDESCRIPTION NVARCHAR(MAX)
);
GO

-- =================================================
-- Observations
-- =================================================

IF OBJECT_ID('raw_data.observations', 'U') IS NOT NULL
    DROP TABLE raw_data.observations;
GO

CREATE TABLE raw_data.observations (
    DATE        NVARCHAR(MAX),
    PATIENT     NVARCHAR(MAX),
    ENCOUNTER   NVARCHAR(MAX),
    CATEGORY    NVARCHAR(MAX),
    CODE        NVARCHAR(MAX),
    DESCRIPTION NVARCHAR(MAX),
    VALUE       NVARCHAR(MAX),
    UNITS       NVARCHAR(MAX),
    TYPE        NVARCHAR(MAX)
);
GO

-- =================================================
-- Immunizations
-- =================================================

IF OBJECT_ID('raw_data.immunizations', 'U') IS NOT NULL
    DROP TABLE raw_data.immunizations;
GO

CREATE TABLE raw_data.immunizations (
    DATE        NVARCHAR(MAX),
    PATIENT     NVARCHAR(MAX),
    ENCOUNTER   NVARCHAR(MAX),
    CODE        NVARCHAR(MAX),
    DESCRIPTION NVARCHAR(MAX),
    BASE_COST   NVARCHAR(MAX)
);
GO

-- =================================================
-- Imaging Studies
-- =================================================

IF OBJECT_ID('raw_data.imaging_studies', 'U') IS NOT NULL
    DROP TABLE raw_data.imaging_studies;
GO

CREATE TABLE raw_data.imaging_studies (
    Id                    NVARCHAR(MAX),
    DATE                  NVARCHAR(MAX),
    PATIENT               NVARCHAR(MAX),
    ENCOUNTER             NVARCHAR(MAX),
    SERIES_UID            NVARCHAR(MAX),
    BODYSITE_CODE         NVARCHAR(MAX),
    BODYSITE_DESCRIPTION  NVARCHAR(MAX),
    MODALITY_CODE         NVARCHAR(MAX),
    MODALITY_DESCRIPTION  NVARCHAR(MAX),
    INSTANCE_UID          NVARCHAR(MAX),
    SOP_CODE              NVARCHAR(MAX),
    SOP_DESCRIPTION       NVARCHAR(MAX),
    PROCEDURE_CODE        NVARCHAR(MAX)
);
GO

-- =================================================
-- Devices
-- =================================================

IF OBJECT_ID('raw_data.devices', 'U') IS NOT NULL
    DROP TABLE raw_data.devices;
GO

CREATE TABLE raw_data.devices (
    START       NVARCHAR(MAX),
    STOP        NVARCHAR(MAX),
    PATIENT     NVARCHAR(MAX),
    ENCOUNTER   NVARCHAR(MAX),
    CODE        NVARCHAR(MAX),
    DESCRIPTION NVARCHAR(MAX),
    UDI         NVARCHAR(MAX)
);
GO

-- =================================================
-- Supplies
-- =================================================

IF OBJECT_ID('raw_data.supplies', 'U') IS NOT NULL
    DROP TABLE raw_data.supplies;
GO

CREATE TABLE raw_data.supplies (
    DATE        NVARCHAR(MAX),
    PATIENT     NVARCHAR(MAX),
    ENCOUNTER   NVARCHAR(MAX),
    CODE        NVARCHAR(MAX),
    DESCRIPTION NVARCHAR(MAX),
    QUANTITY    NVARCHAR(MAX)
);
GO

-- =================================================
-- Providers
-- =================================================

IF OBJECT_ID('raw_data.providers', 'U') IS NOT NULL
    DROP TABLE raw_data.providers;
GO

CREATE TABLE raw_data.providers (
    Id          NVARCHAR(MAX),
    ORGANIZATION NVARCHAR(MAX),
    NAME        NVARCHAR(MAX),
    GENDER      NVARCHAR(MAX),
    SPECIALITY  NVARCHAR(MAX),
    ADDRESS     NVARCHAR(MAX),
    CITY        NVARCHAR(MAX),
    STATE       NVARCHAR(MAX),
    ZIP         NVARCHAR(MAX),
    LAT         NVARCHAR(MAX),
    LON         NVARCHAR(MAX),
    UTILIZATION NVARCHAR(MAX)
);
GO

-- =================================================
-- Organizations
-- =================================================

IF OBJECT_ID('raw_data.organizations', 'U') IS NOT NULL
    DROP TABLE raw_data.organizations;
GO

CREATE TABLE raw_data.organizations (
    Id          NVARCHAR(MAX),
    NAME        NVARCHAR(MAX),
    ADDRESS     NVARCHAR(MAX),
    CITY        NVARCHAR(MAX),
    STATE       NVARCHAR(MAX),
    ZIP         NVARCHAR(MAX),
    LAT         NVARCHAR(MAX),
    LON         NVARCHAR(MAX),
    PHONE       NVARCHAR(MAX),
    REVENUE     NVARCHAR(MAX),
    UTILIZATION NVARCHAR(MAX)
);
GO

-- =================================================
-- Payers
-- =================================================

IF OBJECT_ID('raw_data.payers', 'U') IS NOT NULL
    DROP TABLE raw_data.payers;
GO

CREATE TABLE raw_data.payers (
    Id                     NVARCHAR(MAX),
    NAME                   NVARCHAR(MAX),
    ADDRESS                NVARCHAR(MAX),
    CITY                   NVARCHAR(MAX),
    STATE_HEADQUARTERED    NVARCHAR(MAX),
    ZIP                    NVARCHAR(MAX),
    PHONE                  NVARCHAR(MAX),
    AMOUNT_COVERED         NVARCHAR(MAX),
    AMOUNT_UNCOVERED       NVARCHAR(MAX),
    REVENUE                NVARCHAR(MAX),
    COVERED_ENCOUNTERS     NVARCHAR(MAX),
    UNCOVERED_ENCOUNTERS   NVARCHAR(MAX),
    COVERED_MEDICATIONS    NVARCHAR(MAX),
    UNCOVERED_MEDICATIONS  NVARCHAR(MAX),
    COVERED_PROCEDURES     NVARCHAR(MAX),
    UNCOVERED_PROCEDURES   NVARCHAR(MAX),
    COVERED_IMMUNIZATIONS  NVARCHAR(MAX),
    UNCOVERED_IMMUNIZATIONS NVARCHAR(MAX),
    UNIQUE_CUSTOMERS       NVARCHAR(MAX),
    QOLS_AVG               NVARCHAR(MAX),
    MEMBER_MONTHS          NVARCHAR(MAX)
);
GO

-- =================================================
-- Claims
-- =================================================

IF OBJECT_ID('raw_data.claims', 'U') IS NOT NULL
    DROP TABLE raw_data.claims;
GO

CREATE TABLE raw_data.claims (
    Id                         NVARCHAR(MAX),
    PATIENTID                  NVARCHAR(MAX),
    PROVIDERID                 NVARCHAR(MAX),
    PRIMARYPATIENTINSURANCEID  NVARCHAR(MAX),
    SECONDARYPATIENTINSURANCEID NVARCHAR(MAX),
    DEPARTMENTID              NVARCHAR(MAX),
    PATIENTDEPARTMENTID       NVARCHAR(MAX),
    DIAGNOSIS1                NVARCHAR(MAX),
    DIAGNOSIS2                NVARCHAR(MAX),
    DIAGNOSIS3                NVARCHAR(MAX),
    DIAGNOSIS4                NVARCHAR(MAX),
    DIAGNOSIS5                NVARCHAR(MAX),
    DIAGNOSIS6                NVARCHAR(MAX),
    DIAGNOSIS7                NVARCHAR(MAX),
    DIAGNOSIS8                NVARCHAR(MAX),
    REFERRINGPROVIDERID       NVARCHAR(MAX),
    APPOINTMENTID             NVARCHAR(MAX),
    CURRENTILLNESSDATE        NVARCHAR(MAX),
    SERVICEDATE               NVARCHAR(MAX),
    SUPERVISINGPROVIDERID     NVARCHAR(MAX),
    STATUS1                   NVARCHAR(MAX),
    STATUS2                   NVARCHAR(MAX),
    STATUSP                   NVARCHAR(MAX),
    OUTSTANDING1              NVARCHAR(MAX),
    OUTSTANDING2              NVARCHAR(MAX),
    OUTSTANDINGP              NVARCHAR(MAX),
    LASTBILLEDDATE1           NVARCHAR(MAX),
    LASTBILLEDDATE2           NVARCHAR(MAX),
    LASTBILLEDDATEP           NVARCHAR(MAX),
    HEALTHCARECLAIMTYPEID1    NVARCHAR(MAX),
    HEALTHCARECLAIMTYPEID2    NVARCHAR(MAX)
);
GO

-- =================================================
-- Claims Transactions
-- =================================================

IF OBJECT_ID('raw_data.claims_transactions', 'U') IS NOT NULL
    DROP TABLE raw_data.claims_transactions;
GO

CREATE TABLE raw_data.claims_transactions (
    ID                    NVARCHAR(MAX),
    CLAIMID               NVARCHAR(MAX),
    CHARGEID              NVARCHAR(MAX),
    PATIENTID             NVARCHAR(MAX),
    TYPE                  NVARCHAR(MAX),
    AMOUNT                NVARCHAR(MAX),
    METHOD                NVARCHAR(MAX),
    FROMDATE              NVARCHAR(MAX),
    TODATE                NVARCHAR(MAX),
    PLACEOFSERVICE        NVARCHAR(MAX),
    PROCEDURECODE         NVARCHAR(MAX),
    MODIFIER1             NVARCHAR(MAX),
    MODIFIER2             NVARCHAR(MAX),
    DIAGNOSISREF1         NVARCHAR(MAX),
    DIAGNOSISREF2         NVARCHAR(MAX),
    DIAGNOSISREF3         NVARCHAR(MAX),
    DIAGNOSISREF4         NVARCHAR(MAX),
    UNITS                 NVARCHAR(MAX),
    DEPARTMENTID          NVARCHAR(MAX),
    NOTES                 NVARCHAR(MAX),
    UNITAMOUNT            NVARCHAR(MAX),
    TRANSFEROUTID         NVARCHAR(MAX),
    TRANSFERTYPE          NVARCHAR(MAX),
    PAYMENTS              NVARCHAR(MAX),
    ADJUSTMENTS           NVARCHAR(MAX),
    TRANSFERS             NVARCHAR(MAX),
    OUTSTANDING           NVARCHAR(MAX),
    APPOINTMENTID         NVARCHAR(MAX),
    LINENOTE              NVARCHAR(MAX),
    PATIENTINSURANCEID    NVARCHAR(MAX),
    FEESCHEDULEID         NVARCHAR(MAX),
    PROVIDERID            NVARCHAR(MAX),
    SUPERVISINGPROVIDERID NVARCHAR(MAX)
);
GO

-- =================================================
-- Payer Transitions
-- =================================================

IF OBJECT_ID('raw_data.payer_transitions', 'U') IS NOT NULL
    DROP TABLE raw_data.payer_transitions;
GO

CREATE TABLE raw_data.payer_transitions (
    PATIENT          NVARCHAR(MAX),
    MEMBERID         NVARCHAR(MAX),
    START_YEAR       NVARCHAR(MAX),
    END_YEAR         NVARCHAR(MAX),
    PAYER            NVARCHAR(MAX),
    SECONDARY_PAYER  NVARCHAR(MAX),
    OWNERSHIP        NVARCHAR(MAX),
    OWNERNAME        NVARCHAR(MAX)
);
GO


