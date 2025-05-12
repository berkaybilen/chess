CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
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
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    date_of_birth DATE,
    fide_id VARCHAR(20) UNIQUE,
    elo_rating INT NOT NULL CHECK (elo_rating > 1000),
    title_id INT,

    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (title_id) REFERENCES Title(titleID)
);

CREATE TABLE Coaches (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),

    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Arbiters (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    experience_level VARCHAR(20),

    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE CoachCertifications (
    coach_id INT,
    certification VARCHAR(100),
    PRIMARY KEY (coach_id, certification),

    FOREIGN KEY (coach_id) REFERENCES Coaches(user_id)
);

CREATE TABLE ArbiterCertifications (
    arbiter_id INT,
    certification VARCHAR(100),
    PRIMARY KEY (arbiter_id, certification),

    FOREIGN KEY (arbiter_id) REFERENCES Arbiters(user_id)
);
