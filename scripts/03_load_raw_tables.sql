/*
===============================================================================
Stored Procedure: Load Raw Data into Raw Data Tables
===============================================================================
Usage Example:
    EXEC raw_data.load_raw_data;
===============================================================================
*/

CREATE or ALTER PROCEDURE raw_data.load_raw_data AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
        SET @batch_start_time = SYSDATETIME();
		PRINT '================================================';
		PRINT 'Loading Raw Data';
		PRINT '================================================';

        SET @start_time = SYSDATETIME();
        PRINT '>> Truncating Table: raw_data.patients';

        TRUNCATE TABLE raw_data.patients;
        
        PRINT '>> Loading Data into Table: raw_data.patients';

        BULK INSERT raw_data.patients
        FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\patients.csv'
        WITH (
            FORMAT = 'CSV',
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            FIRSTROW = 2,
            TABLOCK
        );

        SET @end_time = SYSDATETIME();
		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.encounters';

		TRUNCATE TABLE raw_data.encounters;

		PRINT '>> Loading Data into Table: raw_data.encounters';

		BULK INSERT raw_data.encounters
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\encounters.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.conditions';

		TRUNCATE TABLE raw_data.conditions;

		PRINT '>> Loading Data into Table: raw_data.conditions';

		BULK INSERT raw_data.conditions
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\conditions.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.procedures';

		TRUNCATE TABLE raw_data.procedures;

		PRINT '>> Loading Data into Table: raw_data.procedures';

		BULK INSERT raw_data.procedures
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\procedures.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.medications';

		TRUNCATE TABLE raw_data.medications;

		PRINT '>> Loading Data into Table: raw_data.medications';

		BULK INSERT raw_data.medications
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\medications.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.allergies';

		TRUNCATE TABLE raw_data.allergies;

		PRINT '>> Loading Data into Table: raw_data.allergies';

		BULK INSERT raw_data.allergies
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\allergies.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.careplans';

		TRUNCATE TABLE raw_data.careplans;

		PRINT '>> Loading Data into Table: raw_data.careplans';

		BULK INSERT raw_data.careplans
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\careplans.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.observations';

		TRUNCATE TABLE raw_data.observations;

		PRINT '>> Loading Data into Table: raw_data.observations';

		BULK INSERT raw_data.observations
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\observations.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.immunizations';

		TRUNCATE TABLE raw_data.immunizations;

		PRINT '>> Loading Data into Table: raw_data.immunizations';

		BULK INSERT raw_data.immunizations
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\immunizations.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.imaging_studies';

		TRUNCATE TABLE raw_data.imaging_studies;

		PRINT '>> Loading Data into Table: raw_data.imaging_studies';

		BULK INSERT raw_data.imaging_studies
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\imaging_studies.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.devices';

		TRUNCATE TABLE raw_data.devices;

		PRINT '>> Loading Data into Table: raw_data.devices';

		BULK INSERT raw_data.devices
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\devices.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.supplies';

		TRUNCATE TABLE raw_data.supplies;

		PRINT '>> Loading Data into Table: raw_data.supplies';

		BULK INSERT raw_data.supplies
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\supplies.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.providers';

		TRUNCATE TABLE raw_data.providers;

		PRINT '>> Loading Data into Table: raw_data.providers';

		BULK INSERT raw_data.providers
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\providers.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.organizations';

		TRUNCATE TABLE raw_data.organizations;

		PRINT '>> Loading Data into Table: raw_data.organizations';

		BULK INSERT raw_data.organizations
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\organizations.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.payers';

		TRUNCATE TABLE raw_data.payers;

		PRINT '>> Loading Data into Table: raw_data.payers';

		BULK INSERT raw_data.payers
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\payers.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.claims';

		TRUNCATE TABLE raw_data.claims;

		PRINT '>> Loading Data into Table: raw_data.claims';

		BULK INSERT raw_data.claims
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\claims.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.claims_transactions';

		TRUNCATE TABLE raw_data.claims_transactions;

		PRINT '>> Loading Data into Table: raw_data.claims_transactions';

		BULK INSERT raw_data.claims_transactions
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\claims_transactions.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @start_time = SYSDATETIME();
		PRINT '>> Truncating Table: raw_data.payer_transitions';

		TRUNCATE TABLE raw_data.payer_transitions;

		PRINT '>> Loading Data into Table: raw_data.payer_transitions';

		BULK INSERT raw_data.payer_transitions
		FROM 'C:\Users\Matt\Downloads\Healthcare_Claims_Analytics\data\payer_transitions.csv'
		WITH (
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			CODEPAGE = '65001',
			FIRSTROW = 2,
			TABLOCK
		);

		SET @end_time = SYSDATETIME();

		PRINT '>> Load Duration: '
			+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '>> ---------------------------------------------';


		SET @batch_end_time = SYSDATETIME();

		PRINT '================================================';
		PRINT 'Raw Data Load Completed Successfully';
		PRINT 'Total Load Duration: '
			+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR)
			+ ' seconds';
		PRINT '================================================';
	END TRY

	BEGIN CATCH
		PRINT '================================================';
		PRINT 'ERROR OCCURRED DURING RAW DATA LOAD';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
		PRINT '================================================';

		THROW;
	END CATCH
END;
GO


EXEC raw_data.load_raw_data;
GO

USE healthcare_analytics;
GO



