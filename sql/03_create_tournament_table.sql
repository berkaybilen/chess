-- HALLS & TABLES
CREATE TABLE Hall (
    id       INT         NOT NULL AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    country  VARCHAR(50)  NOT NULL,
    capacity INT         NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE HallTable (
    hall_id   INT NOT NULL,
    table_no  INT NOT NULL,
    PRIMARY KEY (hall_id, table_no),

    FOREIGN KEY (hall_id) REFERENCES Hall(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);