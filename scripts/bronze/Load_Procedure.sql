/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
Run this script to re-define the DDL structure of 'bronze' Tables

BULK INSERT: It is a method of loading massive amount of data very quickly from files like CSV files or text files directly into a database.
===============================================================================
*/

/*
FIRSTROW=2 WE ARE TELLING SQL THAT SKIP FIRST ROW,BCZ IN SOURCE FILES WHICH IS CSV FIRST ROW IS HEADER.

FILE DELIMETER(Terminator): File Seperator  

Tab lock: It is an option in order to improve the performance where you are locking the entire table 
during loading it so as SQL is loading the data to this table it going to go and lock the whole table

QUALITY CHECK: CHECK THAT DATA IS NOT SHIFTED AND IS IN THE CORRECT COLUMN
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	TRUNCATE TABLE bronze.crm_cust_info;
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	TRUNCATE TABLE bronze.crm_prd_info;
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	TRUNCATE TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	TRUNCATE TABLE bronze.erp_cust_az12;
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	TRUNCATE TABLE bronze.erp_loc_a101;
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
END


