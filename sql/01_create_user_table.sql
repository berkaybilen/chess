CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password CHAR(128) NOT NULL,
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
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    date_of_birth DATE,
    fide_id VARCHAR(20) UNIQUE,
    elo_rating INT NOT NULL CHECK (elo_rating > 1000),
    title_id INT,

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES Users(username)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (title_id) REFERENCES Title(titleID)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Coaches (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES Users(username)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Arbiters (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    experience_level VARCHAR(20),

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES Users(username)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CoachCertifications (
    coach_user_id INT,
    certification_id INT,
    PRIMARY KEY (coach_user_id, certification_id),

    FOREIGN KEY (coach_user_id) REFERENCES Coaches(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (certification_id) REFERENCES Certification(certificationID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ArbiterCertifications (
    arbiter_user_id INT,
    certification_id INT,
    PRIMARY KEY (arbiter_user_id, certification_id),

    FOREIGN KEY (arbiter_user_id) REFERENCES Arbiters(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (certification_id) REFERENCES Certification(certificationID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
