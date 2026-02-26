DROP TABLE IF EXISTS gold.dim_item;
CREATE TABLE gold.dim_item (
    itemean CHAR(13) NOT NULL PRIMARY KEY,
    arabic_name NVARCHAR(50) NOT NULL,
    latin_name NVARCHAR(50) NOT NULL,
    sub_group SMALLINT NOT NULL,
    supplier INT NOT NULL,
    last_update datetime NOT NULL
);
