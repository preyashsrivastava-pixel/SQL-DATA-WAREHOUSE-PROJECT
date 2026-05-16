/*Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
		SET @batch_start_time=GETDATE();
			SET @start_time=GETDATE();
			PRINT 'TRUNCATING TABLE bronze.crm_cust_info';
			PRINT 'INSERTING DATA INTO bronze.crm_cust_info'
			TRUNCATE TABLE bronze.crm_cust_info
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\preya\OneDrive\Desktop\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK
			);
			SET @end_time=GETDATE();
			PRINT '<<LOAD DURATION:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'SECONDS';

			SET @start_time=GETDATE();
			PRINT 'TRUNCATING TABLE [bronze].[crm_prd_info]';
			PRINT 'INSERTING Data INTO [bronze].[crm_prd_info]'
			TRUNCATE TABLE [bronze].[crm_prd_info]
			BULK INSERT [bronze].[crm_prd_info]
			FROM 'C:\Users\preya\OneDrive\Desktop\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK
			);
			SET @end_time=GETDATE();
			PRINT '<<LOAD DURATION:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'SECONDS';


			SET @start_time=GETDATE();
			PRINT 'TRUNCATING TABLE [bronze].[crm_sales_details]';
			PRINT 'INSERTING Data INTO [bronze].[crm_sales_details]'
			TRUNCATE TABLE [bronze].[crm_sales_details]
			BULK INSERT [bronze].[crm_sales_details]
			FROM 'C:\Users\preya\OneDrive\Desktop\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH(
					FIRSTROW=2,
					FIELDTERMINATOR=',',
					TABLOCK
					);
			SET @end_time=GETDATE();
			PRINT '<<LOAD DURATION:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'SECONDS';

			SET @start_time=GETDATE();
			PRINT 'TRUNCATING TABLE [bronze].[erp_cust_az12]';
			PRINT 'INSERTING Data INTO [bronze].[erp_cust_az12]'
			TRUNCATE TABLE [bronze].[erp_cust_az12]
			BULK INSERT [bronze].[erp_cust_az12]
			FROM 'C:\Users\preya\OneDrive\Desktop\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK
			);
			SET @end_time=GETDATE();
			PRINT '<<LOAD DURATION:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'SECONDS';

			SET @start_time=GETDATE();
			PRINT 'TRUNCATING TABLE [bronze].[erp_loc_a101]';
			PRINT 'INSERTING Data INTO [bronze].[erp_loc_a101]';
			TRUNCATE TABLE [bronze].[erp_loc_a101]
			BULK INSERT [bronze].[erp_loc_a101]
			FROM 'C:\Users\preya\OneDrive\Desktop\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK
			);
			SET @end_time=GETDATE();
			PRINT '<<LOAD DURATION:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'SECONDS';

			SET @start_time=GETDATE();
			PRINT 'TRUNCATING TABLE [bronze].[erp_px_cat_g1v2]';
			PRINT 'INSERTING Data INTO [bronze].[erp_px_cat_g1v2]';
			TRUNCATE TABLE [bronze].[erp_px_cat_g1v2]
			BULK INSERT [bronze].[erp_px_cat_g1v2]
			FROM 'C:\Users\preya\OneDrive\Desktop\DATA_WAREHOUSE_PROJECT\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH(
				FIRSTROW=2,
				FIELDTERMINATOR=',',
				TABLOCK
		    );
			SET @end_time=GETDATE();
			PRINT '<<LOAD DURATION:erp_px_cat_g1v2 ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
			SET @batch_end_time=GETDATE();
			PRINT '================================='
			PRINT '================================='
			PRINT 'BRONZE LAYER LOAD DURATION ' +CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' SECONDS';
	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE()
		PRINT 'ERROR STATE' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END

