CREATE TABLE Matches (
    matchID               INT AUTO_INCREMENT PRIMARY KEY,
    tournamentID          INT NOT NULL,
    hallID                INT NOT NULL,
    tableNo               INT NOT NULL,
    
    team1ID               INT NOT NULL,
    team2ID               INT NOT NULL,
    whitePlayerUsername   VARCHAR(50),
    blackPlayerUsername   VARCHAR(50),

    result                ENUM('white', 'black', 'draw') DEFAULT NULL,
    timeSlot              INT NOT NULL CHECK (timeSlot BETWEEN 1 AND 7),
    date                  DATE NOT NULL,

    arbiter_username      VARCHAR(50) NOT NULL,
    rating                INT DEFAULT NULL CHECK (rating BETWEEN 1 AND 10),

    -- Foreign Keys
    FOREIGN KEY (tournamentID) REFERENCES Tournament(tournamentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    FOREIGN KEY (hallID, tableNo) REFERENCES HallTable(hallID, tableNo)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (team1ID) REFERENCES Team(teamID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (team2ID) REFERENCES Team(teamID)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (whitePlayerUsername) REFERENCES Players(username)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (blackPlayerUsername) REFERENCES Players(username)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (arbiter_username) REFERENCES Arbiters(username)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
