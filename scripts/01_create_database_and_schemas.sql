/*
====================================================
Script: 01_create_database_and_schemas.sql
Purpose: Create the project database and schemas
====================================================
*/

-- =================================================
-- Create Database
-- =================================================
USE master;
GO

CREATE DATABASE healthcare_analytics;
GO

-- =================================================
-- Select Project Database
-- =================================================

USE healthcare_analytics;
GO

-- =================================================
-- Create Schemas
-- =================================================

CREATE SCHEMA raw_data;
GO

CREATE SCHEMA staging;
GO

CREATE SCHEMA analytics;
GO
