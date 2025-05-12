-- TOURNAMENT REGISTRY
CREATE TABLE Tournament (
    tournamentID   INT          NOT NULL AUTO_INCREMENT,
    tournamentName VARCHAR(100) NOT NULL,
    startDate      DATE         NOT NULL,
    endDate        DATE         NOT NULL,
    format         VARCHAR(50)  NOT NULL,
    chiefArbiter   VARCHAR(50)  NOT NULL,
    winnerTeamID   INT          DEFAULT NULL,
    PRIMARY KEY (tournamentID),
    UNIQUE (tournamentName),

    FOREIGN KEY (chiefArbiter) REFERENCES Arbiters(username)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (winnerTeamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CHECK (startDate <= endDate)
);

-- HALLS & TABLES
CREATE TABLE Hall (
    hallID       INT         NOT NULL AUTO_INCREMENT,
    hallName     VARCHAR(100) NOT NULL,
    hallCountry  VARCHAR(50)  NOT NULL,
    hallCapacity INT         NOT NULL,
    PRIMARY KEY (hallID)
);

CREATE TABLE HallTable (
    hallID   INT NOT NULL,
    tableNo  INT NOT NULL,
    PRIMARY KEY (hallID, tableNo),
    
    FOREIGN KEY (hallID) REFERENCES Hall(hallID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- TOURNAMENT VENUE ASSIGNMENT
CREATE TABLE PlaceOfTournament (
    tournamentID  INT  NOT NULL,
    hallID        INT  NOT NULL,
    PRIMARY KEY (tournamentID, hallID),

    FOREIGN KEY (tournamentID) REFERENCES Tournament(tournamentID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (hallID) REFERENCES Hall(hallID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- TEAM REGISTRATION FOR TOURNAMENT
CREATE TABLE Participates (
    tournamentID  INT  NOT NULL,
    teamID        INT  NOT NULL,
    PRIMARY KEY (tournamentID, teamID),

    FOREIGN KEY (tournamentID) REFERENCES Tournament(tournamentID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
