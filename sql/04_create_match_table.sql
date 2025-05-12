CREATE TABLE Match (
    matchID               INT AUTO_INCREMENT PRIMARY KEY,
    tournamentID          INT NOT NULL,
    hallID                INT NOT NULL,
    tableNo               INT NOT NULL,
    
    whitePlayerTeamID     INT NOT NULL,
    whitePlayerUsername   VARCHAR(50) NOT NULL,
    blackPlayerTeamID     INT NOT NULL,
    blackPlayerUsername   VARCHAR(50) NOT NULL,

    result                ENUM('white', 'black', 'draw') DEFAULT NULL,
    timeSlot              INT NOT NULL CHECK (timeSlot BETWEEN 1 AND 3),
    date                  DATE NOT NULL,

    assignedArbiter       VARCHAR(50) NOT NULL,
    rating                INT DEFAULT NULL CHECK (rating BETWEEN 1 AND 10),

    -- Foreign Keys
    FOREIGN KEY (tournamentID) REFERENCES Tournament(tournamentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    FOREIGN KEY (hallID, tableNo) REFERENCES HallTable(hallID, tableNo)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (whitePlayerTeamID) REFERENCES Team(teamID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (blackPlayerTeamID) REFERENCES Team(teamID)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (whitePlayerUsername) REFERENCES Player(username)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (blackPlayerUsername) REFERENCES Player(username)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (assignedArbiter) REFERENCES Arbiter(username)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Ensure different teams
    CHECK (whitePlayerTeamID <> blackPlayerTeamID),

    -- Prevent same player on both sides
    CHECK (whitePlayerUsername <> blackPlayerUsername)
);
