# extractinsertupdatedeletemssql
> Microsoft SQL Server project which utilizes a stored procedure to extract, insert, update, and or delete records

## Table of Contents
* [Version](#version)
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Usage](#usage)

### Version
* 0.0.1

### **Important Note**
* This project was written with SQL Server 2012 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Prerequisite Data Types
* nvarchar
* integer (int)
* smallint
* datetime2

### Prerequisite Functions
* nullif
* ltrim
* rtrim
* try_cast
* upper
* getdate
* error_number
* error_line
* error_message

### Prerequisite Conditions
* exists

### Usage
* `dbo.extractInsertUpdateDelete @optionMode = 'extractEntriesColumnOne', @columnOneString = 'String-Example'`
* `dbo.extractInsertUpdateDelete @optionMode = 'extractTableEntriesReport'`
* `dbo.extractInsertUpdateDelete @optionMode = 'insertColumnOneColumnTwoEntry', @userIdentifierString = 'UserIdentifierStringExample', @columnOneString = 'String-One-Example', @columnTwoString = 'String-Two-Example'`
* `dbo.extractInsertUpdateDelete @optionMode = 'updateColumnTwo', @userIdentifierString = 'UserIdentifierStringExample', @columnOneString = 'String-One-Example', @columnTwoString = 'String-Two-Example', @columnTwoStringNew = 'String-Two-Example-New'`
* `dbo.extractInsertUpdateDelete @optionMode = 'deleteColumnOneEntry', @columnOneString = 'String-One-Example'`
