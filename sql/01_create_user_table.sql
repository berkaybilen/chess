CREATE TABLE Users (
    username VARCHAR(50) PRIMARY KEY,
    password CHAR(60) NOT NULL,
    role ENUM('manager', 'player', 'coach', 'arbiter') NOT NULL
);

CREATE TABLE Title (
    titleID   INT AUTO_INCREMENT PRIMARY KEY,
    titleName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Certification (
    certificationID INT AUTO_INCREMENT PRIMARY KEY,
    certName        VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Players (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    date_of_birth DATE,
    fide_id VARCHAR(20) UNIQUE,
    elo_rating INT NOT NULL CHECK (elo_rating > 1000),
    title_id INT,

    FOREIGN KEY (username) REFERENCES Users(username)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (title_id) REFERENCES Title(titleID)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Coaches (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),

    FOREIGN KEY (username) REFERENCES Users(username)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Arbiters (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    experience_level VARCHAR(20),

    FOREIGN KEY (username) REFERENCES Users(username)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CoachCertifications (
    coach_username VARCHAR(50),
    certification_id INT,
    PRIMARY KEY (coach_username, certification_id),

    FOREIGN KEY (coach_username) REFERENCES Coaches(username)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (certification_id) REFERENCES Certification(certificationID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ArbiterCertifications (
    arbiter_username VARCHAR(50),
    certification_id INT,
    PRIMARY KEY (arbiter_username, certification_id),

    FOREIGN KEY (arbiter_username) REFERENCES Arbiters(username)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (certification_id) REFERENCES Certification(certificationID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
