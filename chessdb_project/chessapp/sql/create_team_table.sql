-- SPONSORS
CREATE TABLE Sponsor (
    sponsorID    INT           NOT NULL AUTO_INCREMENT,
    sponsorName  VARCHAR(50)   NOT NULL,
    PRIMARY KEY (sponsorID),
    UNIQUE (sponsorName)
);

-- TEAMS
CREATE TABLE Team (
    teamID     INT          NOT NULL AUTO_INCREMENT,
    teamName   VARCHAR(50)  NOT NULL,
    sponsorID  INT          NOT NULL,
    PRIMARY KEY (teamID),
    UNIQUE (teamName),

    FOREIGN KEY (sponsorID) REFERENCES Sponsor(sponsorID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- COACH–TEAM CONTRACTS
CREATE TABLE CoachTeamAgreement (
    coachUsername   VARCHAR(50)  NOT NULL,
    teamID          INT          NOT NULL,
    contractStart   DATE         NOT NULL,
    contractFinish  DATE         NOT NULL,
    PRIMARY KEY (coachUsername, teamID),

    FOREIGN KEY (coachUsername) REFERENCES Coach(username)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (contractStart < contractFinish) -- todo : CHECK statements may not work.
);

CREATE TABLE Plays_in (
    playerUsername  VARCHAR(50) NOT NULL,
    teamID          INT         NOT NULL,
    PRIMARY KEY (playerUsername, teamID),
    
    FOREIGN KEY (playerUsername) REFERENCES Player(username)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
