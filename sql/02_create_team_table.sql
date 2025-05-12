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
    coach_username  VARCHAR(50)  NOT NULL,
    teamID         INT          NOT NULL,
    contractStart  DATE         NOT NULL,
    contractFinish DATE         NOT NULL,
    PRIMARY KEY (coach_username, teamID),

    FOREIGN KEY (coach_username) REFERENCES Coaches(username)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (contractStart < contractFinish)
);

CREATE TABLE Plays_in (
    player_username VARCHAR(50) NOT NULL,
    teamID         INT         NOT NULL,
    PRIMARY KEY (player_username, teamID),

    FOREIGN KEY (player_username) REFERENCES Players(username)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
