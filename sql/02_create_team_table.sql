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
    coach_user_id   INT          NOT NULL,
    teamID         INT          NOT NULL,
    contractStart  DATE         NOT NULL,
    contractFinish DATE         NOT NULL,
    PRIMARY KEY (coach_user_id, teamID),

    FOREIGN KEY (coach_user_id) REFERENCES Coaches(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (contractStart < contractFinish)
);

CREATE TABLE Plays_in (
    player_user_id  INT         NOT NULL,
    teamID         INT         NOT NULL,
    PRIMARY KEY (player_user_id, teamID),

    FOREIGN KEY (player_user_id) REFERENCES Players(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
