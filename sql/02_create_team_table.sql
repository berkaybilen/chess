-- SPONSORS
CREATE TABLE Sponsor (
    id    INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name  VARCHAR(50)   NOT NULL UNIQUE,
);

-- TEAMS
CREATE TABLE Team (
    id     INT          NOT NULL AUTO_INCREMENT,
    name   VARCHAR(50)  NOT NULL,
    sponsor_id  INT          NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name),

    FOREIGN KEY (sponsor_id) REFERENCES Sponsor(id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- COACH–TEAM CONTRACTS
CREATE TABLE CoachTeamAgreement (
    coach_user_id   INT          NOT NULL,
    team_id         INT          NOT NULL,
    contract_start  DATE         NOT NULL,
    contract_finish DATE         NOT NULL,
    PRIMARY KEY (coach_user_id, team_id),

    FOREIGN KEY (coach_user_id) REFERENCES Coaches(id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    FOREIGN KEY (team_id) REFERENCES Team(id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (contract_start < contract_finish)
);

CREATE TABLE Plays_in (
    player_user_id  INT         NOT NULL,
    team_id         INT         NOT NULL,
    PRIMARY KEY (player_user_id, team_id),

    FOREIGN KEY (player_user_id) REFERENCES Players(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Team(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);
