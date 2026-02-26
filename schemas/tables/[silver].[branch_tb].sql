    DROP TABLE IF EXISTS silver.erp_sys_branch;
CREATE TABLE silver.erp_sys_branch(
    branch int NOT NULL,
    arabic_name char(50) NOT NULL,
    latin_name char(50) NOT NULL,
    branchtype smallint NOT NULL
    CONSTRAINT pk_erp_sys_branch PRIMARY KEY NONCLUSTERED (branch ASC)
);
