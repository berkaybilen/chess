CREATE TABLE Matches (
    matchID               INT AUTO_INCREMENT PRIMARY KEY,
    hallID                INT NOT NULL,
    tableNo               INT NOT NULL,
    
    team1ID               INT NOT NULL,
    team2ID               INT NOT NULL,
    whitePlayerUserID     INT,
    blackPlayerUserID     INT,

    result                ENUM('white wins', 'black wins', 'draw') DEFAULT NULL,
    timeSlot              INT NOT NULL CHECK (timeSlot BETWEEN 1 AND 7),
    date                  DATE NOT NULL,

    arbiter_user_id       INT NOT NULL,
    ratings               VARCHAR(10) DEFAULT NULL,

    -- Foreign Keys
    FOREIGN KEY (hallID, tableNo) REFERENCES HallTable(hallID, tableNo)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (team1ID) REFERENCES Team(teamID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (team2ID) REFERENCES Team(teamID)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (whitePlayerUserID) REFERENCES Players(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (blackPlayerUserID) REFERENCES Players(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (arbiter_user_id) REFERENCES Arbiters(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
