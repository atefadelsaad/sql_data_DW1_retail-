DROP TABLE IF EXISTS silver.dim_sys_itemclass
CREATE TABLE silver.dim_sys_itemclass(
class INT NOT NULL PRIMARY KEY,
arabic_name NVARCHAR(50) NOT NULL,
latin_name NVARCHAR(50) NOT NULL

)

