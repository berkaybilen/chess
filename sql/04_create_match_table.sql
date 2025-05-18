CREATE TABLE Matches (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    hall_id                INT NOT NULL,
    table_no               INT NOT NULL,
    
    team_white              INT NOT NULL,
    team_black               INT NOT NULL,

    time_slot              INT NOT NULL,
    date                  DATE NOT NULL,

    arbiter_user_id       INT NOT NULL,
    ratings               VARCHAR(10) DEFAULT NULL,

    -- Foreign Keys
    FOREIGN KEY (hall_id, table_no) REFERENCES HallTable(hall_id, table_no)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (team_black) REFERENCES Team(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (team_white) REFERENCES Team(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (arbiter_user_id) REFERENCES Arbiters(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE MatchResults (
    id INT NOT NULL,
    white_player_id INT NOT NULL,
    black_player_id INT NOT NULL,
    result ENUM('draw', 'black wins', 'white wins'),

    PRIMARY KEY id,

    FOREIGN KEY (white_player_id) REFERENCES Players(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (black_player_id) REFERENCES Players(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
