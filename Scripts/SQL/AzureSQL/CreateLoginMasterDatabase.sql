/******* Run This code on the MASTER Database ******/

-- Create login,

CREATE LOGIN user
WITH PASSWORD = 'password' 
GO


-- Create user in master database (so the user can connect using ssms or ADS)
CREATE USER user
FOR LOGIN user
WITH DEFAULT_SCHEMA = dbo
GO