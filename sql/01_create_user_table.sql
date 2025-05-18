CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password CHAR(128) NOT NULL,
    role ENUM('manager', 'player', 'coach', 'arbiter') NOT NULL
);

CREATE TABLE Title (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Players (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    fide_id VARCHAR(20) UNIQUE NOT NULL,
    elo_rating INT NOT NULL CHECK (elo_rating > 1000),
    title_id INT NOT NULL,

    FOREIGN KEY (id) REFERENCES Users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (title_id) REFERENCES Title(id)
        ON UPDATE CASCADE ON DELETE SET NULL
);


CREATE TABLE Coaches (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),

    FOREIGN KEY (id) REFERENCES Users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Arbiters (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    experience_level VARCHAR(20),

    FOREIGN KEY (id) REFERENCES Users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Certification (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE CertificationArbiter (
    certification_id INT,
    arbiter_id       INT,
    PRIMARY KEY (certification_id, arbiter_id),
    FOREIGN KEY (certification_id) REFERENCES Certification(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (arbiter_id) REFERENCES Arbiters(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CertificationCoach (
    certification_id INT,
    coach_id         INT,
    PRIMARY KEY (certification_id, coach_id),
    FOREIGN KEY (certification_id) REFERENCES Certification(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (coach_id) REFERENCES Coaches(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);