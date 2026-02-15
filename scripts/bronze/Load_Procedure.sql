/*
FIRSTROW=2 WE ARE TELLING SQL THAT SKIP FIRST ROW,BCZ IN SOURCE FILES WHICH IS CSV FIRST ROW IS HEADER.

FILE DELIMETER(Terminator): File Seperator  

Tab lock: It is an option in order to improve the performance where you are locking the entire table 
during loading it so as SQL is loading the data to this table it going to go and lock the whole table

QUALITY CHECK: CHECK THAT DATA IS NOT SHIFTED AND IS IN THE CORRECT COLUMN
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
SET @batch_start_time = GETDATE();
print '=========================================================================';
print 'Loading Bronze Layer';
print '=========================================================================';

print '-------------------------------------------------------------------------';
print 'Loading CRM Tables';
print '-------------------------------------------------------------------------';
SET @start_time = GETDATE();
print 'Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;
print 'Inserting Data into: bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
SET @end_time = GETDATE();
print '---------------------------------------------------------------------------';
PRINT '>>Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
print '<<------------------------------------->>';
SET @start_time = GETDATE();
print 'Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;
print 'Inserting Data into: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
SET @end_time = GETDATE();
print '---------------------------------------------------------------------------';
PRINT 'Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
print '<<------------------------------------->>';
SET @start_time = GETDATE();
print 'Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
print 'Inserting Data into: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
SET @end_time = GETDATE()
print '---------------------------------------------------------------------------';
PRINT 'Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
print '<<------------------------------------->>';
print 'Loading ERP Tables';

print '-------------------------------------------------------------------------';
SET @start_time = GETDATE();
print '-------------------------------------------------------------------------';
print '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
print '>> Inserting Data into: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
SET @end_time = GETDATE();

print '---------------------------------------------------------------------------';
PRINT 'Load Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
print '<<------------------------------------->>';

SET @start_time = GETDATE();
print '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
print '>> Inserting Data into: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
SET @end_time = GETDATE();

PRINT '---------------------------------------------------------------------------------';
PRINT 'Loading Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
print '<<------------------------------------->>';
SET @start_time = GETDATE();
print '>> Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
print '>> Inserting Data into: bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
print '---------------------------------------------------------------------------';
print 'Loading Duration ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
print '<<------------------------------------->>';
SET @batch_end_time = GETDATE();
PRINT '=================================================';
PRINT 'Loading Bronze Layer is completed';
PRINT '- Total Load Duration : ' + CAST(DATEDIFF(second, @batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
PRINT '=================================================';
	END TRY
	BEGIN CATCH
	PRINT '======================================================';
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'Error Message' + ERROR_MESSAGE();	
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '======================================================';
	END CATCH
END

EXEC bronze.load_bronze;

