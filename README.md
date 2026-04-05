The Data Warehouse and Analytics Project

This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. It highlights industry best practices in data engineering and analytics.

 Data Architecture
The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:

Bronze Layer : Stores raw data as it is from the source systems. Data is ingested from CSV Files into SQL Server Database.

Silver Layer : This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.

Gold Layer : This layer have business ready dimensional data model where we finalize the dimension tables and facts based on business rules and process.
