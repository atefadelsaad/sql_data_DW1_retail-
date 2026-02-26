 DROP TABLE IF EXISTS silver.erp_sys_item;
CREATE TABLE silver.erp_sys_item(
    itemean CHAR(13) NOT NULL PRIMARY KEY,
    arabic_name VARCHAR(50) NOT NULL,
    latin_name VARCHAR(50) NOT NULL,
    sub_group SMALLINT NOT NULL,
    supplier INT NOT NULL
);
