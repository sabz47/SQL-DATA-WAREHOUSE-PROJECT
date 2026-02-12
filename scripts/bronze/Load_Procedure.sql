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

TRUNCATE TABLE bronze.crm_cust_info;

BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

SELECT COUNT(*) FROM bronze.crm_cust_info; 

TRUNCATE TABLE bronze.crm_prd_info;

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\mm354\Downloads\GITHUB PROJECTS\SQL DATAWAREHOUSE\datasets\source_crm\prd_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

SELECT * FROM bronze.crm_prd_info;
