-- Chess DB Initialization Script
-- Created for populating database with initial data from CSV files

-- Disable foreign key checks during data loading
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data
TRUNCATE TABLE Users;
TRUNCATE TABLE Title;
TRUNCATE TABLE Certification;
TRUNCATE TABLE CertificationArbiter;
TRUNCATE TABLE CertificationCoach;
TRUNCATE TABLE Sponsor;
TRUNCATE TABLE Hall;
TRUNCATE TABLE HallTable;
TRUNCATE TABLE Team;
TRUNCATE TABLE Players;
TRUNCATE TABLE Coaches;
TRUNCATE TABLE Arbiters;
TRUNCATE TABLE Plays_in;
TRUNCATE TABLE CoachTeamAgreement;
TRUNCATE TABLE Matches;
TRUNCATE TABLE MatchResults;

-- Populate Title table
INSERT INTO Title (id, name) VALUES
(1, 'Grandmaster'),
(2, 'International Master'),
(3, 'FIDE Master'),
(4, 'Candidate Master'),
(5, 'National Master');

-- Populate Certification table
INSERT INTO Certification (id, name) VALUES
(1, 'FIDE Certified'),
(2, 'International Arbiter'),
(3, 'National Arbiter'),
(4, 'Regional Certification'),
(5, 'Local Certification'),
(6, 'Club Level'),
(7, 'National Level'),
(8, 'Regional Certified');

-- Populate Sponsor table
INSERT INTO Sponsor (id, name) VALUES
(100, 'ChessVision'),
(101, 'Grandmaster Corp'),
(102, 'Queen''s Gambit Ltd.'),
(103, 'MateMate Inc.'),
(104, 'RookTech'),
(105, 'PawnPower Solutions'),
(106, 'CheckSecure AG'),
(107, 'Endgame Enterprises'),
(108, 'King''s Arena Foundation');

-- Populate Hall table
INSERT INTO Hall (id, name, country, capacity) VALUES
(1, 'Grandmaster Arena', 'USA', 10),
(2, 'Royal Chess Hall', 'UK', 8),
(3, 'FIDE Dome', 'Germany', 12),
(4, 'Masters Pavilion', 'Turkey', 6),
(5, 'Checkmate Center', 'France', 9),
(6, 'ELO Stadium', 'Spain', 10),
(7, 'Tactical Grounds', 'Italy', 7),
(8, 'Endgame Hall', 'India', 8),
(9, 'Strategic Square', 'Canada', 6),
(10, 'Opening Hall', 'Japan', 5);

-- Populate HallTable table
INSERT INTO HallTable (hall_id, table_no) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7), (3, 8),
(4, 9),
(5, 10),
(6, 11), (6, 12),
(7, 13),
(8, 14),
(9, 15),
(10, 16);

-- Populate Team table
INSERT INTO Team (id, name, sponsor_id) VALUES
(1, 'Knights', 100),
(2, 'Rooks', 101),
(3, 'Bishops', 102),
(4, 'Pawns', 100),
(5, 'Queens', 103),
(6, 'Kings', 104),
(7, 'Castles', 101),
(8, 'Checkmates', 105),
(9, 'En Passants', 106),
(10, 'Blitz Masters', 107);

-- Insert Users (all types in one table now)
INSERT INTO Users (username, password, role) VALUES
-- Managers
('kevin', 'K3v!n#2024', 'manager'),
('bob', 'Bob@Secure88', 'manager'),
('admin1', '326593', 'manager'),
('jessica', 'secretpw.33#', 'manager'),
('admin2', 'admin2pw', 'manager'),
('fatima', 'F4tima!DBmngr', 'manager'),
('yusuf', 'Yu$ufSecure1', 'manager'),
('maria', 'M@r1a321', 'manager'),

-- Players
('alice', 'Pass@123', 'player'),
('bob1', 'Bob@2023', 'player'),
('clara', 'Clara#21', 'player'),
('david', 'D@vid2024', 'player'),
('emma', 'Emm@9win', 'player'),
('felix', 'F3lix$88', 'player'),
('grace', 'Gr@ce2025', 'player'),
('henry', 'Hen!ry777', 'player'),
('isabel', 'Isa#Blue', 'player'),
('jack', 'Jack@321', 'player'),
('kara', 'Kara$99', 'player'),
('liam', 'Li@mChess', 'player'),
('mia', 'M!a2020', 'player'),
('noah', 'Noah#44', 'player'),
('olivia', 'Oliv@99', 'player'),
('peter', 'P3ter!1', 'player'),
('quinn', 'Quinn%x', 'player'),
('rachel', 'Rach3l@', 'player'),
('sam', 'S@mWise', 'player'),
('tina', 'T!naChess', 'player'),
('umar', 'Umar$22', 'player'),
('vera', 'V3ra#21', 'player'),
('will', 'Will@321', 'player'),
('xena', 'Xena$!', 'player'),
('yusuff', 'Yusuf88@', 'player'),
('zoe', 'Zo3!pass', 'player'),
('hakan', 'H@kan44', 'player'),
('julia', 'J!ulia77', 'player'),
('mehmet', 'Mehmet#1', 'player'),
('elena', 'El3na@pw', 'player'),
('nina', 'Nina@2024', 'player'),
('louis', 'Louis#88', 'player'),
('sofia', 'Sofia$22', 'player'),
('ryan', 'Ryan@77', 'player'),
('claire', 'Claire#01', 'player'),
('jacob', 'Jacob!pass', 'player'),
('ava', 'Ava@Chess', 'player'),
('ethan', 'Ethan$win', 'player'),
('isabella', 'Isabella#77', 'player'),
('logan', 'Logan@55', 'player'),
('sophia', 'Sophia$12', 'player'),
('lucas', 'Lucas!88', 'player'),
('harper', 'Harper@pw', 'player'),
('james_player', 'James!44', 'player'),
('amelia', 'Amelia#99', 'player'),
('benjamin', 'Ben@2023', 'player'),
('ella', 'Ella@pw', 'player'),
('alex', 'Alex$88', 'player'),
('lily', 'Lily@sun', 'player'),

-- Coaches
('carol', 'coachpw', 'coach'),
('david_b', 'dPass!99', 'coach'),
('emma_green', 'E@mma77', 'coach'),
('fatih', 'FatihC21', 'coach'),
('hana', 'Hana$45', 'coach'),
('lucaas', 'Lucas#1', 'coach'),
('mia_rose', 'Mia!888', 'coach'),
('onur', 'onUr@32', 'coach'),
('sofia_lop', 'S0fia#', 'coach'),
('arslan_yusuf', 'Yusuf199', 'coach'),

-- Arbiters
('erin', 'arbpw', 'arbiter'),
('mark', 'refpass', 'arbiter'),
('lucy', 'arb123', 'arbiter'),
('ahmet', 'pass2024', 'arbiter'),
('ana', 'secretpw', 'arbiter'),
('james', 'secure1', 'arbiter'),
('sara', 'sara!2024', 'arbiter'),
('mohamed', 'mpass', 'arbiter');

-- Insert into Players table
INSERT INTO Players SELECT id, username, 'Alice', 'Smith', 'USA', STR_TO_DATE('10-05-2000', '%d-%m-%Y'), 'FIDE001', 2200, 1 FROM Users WHERE username = 'alice';
INSERT INTO Players SELECT id, username, 'Bob', 'Jones', 'UK', STR_TO_DATE('21-07-1998', '%d-%m-%Y'), 'FIDE002', 2100, 5 FROM Users WHERE username = 'bob1';
INSERT INTO Players SELECT id, username, 'Clara', 'Kim', 'KOR', STR_TO_DATE('15-03-2001', '%d-%m-%Y'), 'FIDE003', 2300, 2 FROM Users WHERE username = 'clara';
INSERT INTO Players SELECT id, username, 'David', 'Chen', 'CAN', STR_TO_DATE('02-12-1997', '%d-%m-%Y'), 'FIDE004', 2050, 3 FROM Users WHERE username = 'david';
INSERT INTO Players SELECT id, username, 'Emma', 'Rossi', 'ITA', STR_TO_DATE('19-06-1999', '%d-%m-%Y'), 'FIDE005', 2250, 2 FROM Users WHERE username = 'emma';
INSERT INTO Players SELECT id, username, 'Felix', 'Novak', 'GER', STR_TO_DATE('04-09-2002', '%d-%m-%Y'), 'FIDE006', 2180, 4 FROM Users WHERE username = 'felix';
INSERT INTO Players SELECT id, username, 'Grace', 'Ali', 'TUR', STR_TO_DATE('12-08-2000', '%d-%m-%Y'), 'FIDE007', 2320, 1 FROM Users WHERE username = 'grace';
INSERT INTO Players SELECT id, username, 'Henry', 'Patel', 'IND', STR_TO_DATE('25-04-1998', '%d-%m-%Y'), 'FIDE008', 2150, 3 FROM Users WHERE username = 'henry';
INSERT INTO Players SELECT id, username, 'Isabel', 'Lopez', 'MEX', STR_TO_DATE('17-02-2001', '%d-%m-%Y'), 'FIDE009', 2240, 3 FROM Users WHERE username = 'isabel';
INSERT INTO Players SELECT id, username, 'Jack', 'Brown', 'USA', STR_TO_DATE('30-11-1997', '%d-%m-%Y'), 'FIDE010', 2000, 4 FROM Users WHERE username = 'jack';
INSERT INTO Players SELECT id, username, 'Kara', 'Singh', 'IND', STR_TO_DATE('07-01-2003', '%d-%m-%Y'), 'FIDE011', 2350, 5 FROM Users WHERE username = 'kara';
INSERT INTO Players SELECT id, username, 'Liam', 'Müller', 'GER', STR_TO_DATE('23-05-1999', '%d-%m-%Y'), 'FIDE012', 2200, 2 FROM Users WHERE username = 'liam';
INSERT INTO Players SELECT id, username, 'Mia', 'Wang', 'CHN', STR_TO_DATE('14-12-2002', '%d-%m-%Y'), 'FIDE013', 2125, 4 FROM Users WHERE username = 'mia';
INSERT INTO Players SELECT id, username, 'Noah', 'Evans', 'CAN', STR_TO_DATE('08-08-1996', '%d-%m-%Y'), 'FIDE014', 2400, 1 FROM Users WHERE username = 'noah';
INSERT INTO Players SELECT id, username, 'Olivia', 'Taylor', 'UK', STR_TO_DATE('03-06-2001', '%d-%m-%Y'), 'FIDE015', 2280, 2 FROM Users WHERE username = 'olivia';
INSERT INTO Players SELECT id, username, 'Peter', 'Dubois', 'FRA', STR_TO_DATE('11-10-2000', '%d-%m-%Y'), 'FIDE016', 2140, 3 FROM Users WHERE username = 'peter';
INSERT INTO Players SELECT id, username, 'Quinn', 'Ma', 'CHN', STR_TO_DATE('16-09-1998', '%d-%m-%Y'), 'FIDE017', 2210, 4 FROM Users WHERE username = 'quinn';
INSERT INTO Players SELECT id, username, 'Rachel', 'Silva', 'BRA', STR_TO_DATE('06-07-1999', '%d-%m-%Y'), 'FIDE018', 2290, 2 FROM Users WHERE username = 'rachel';
INSERT INTO Players SELECT id, username, 'Sam', 'O’Neill', 'IRE', STR_TO_DATE('29-01-2002', '%d-%m-%Y'), 'FIDE019', 2100, 3 FROM Users WHERE username = 'sam';
INSERT INTO Players SELECT id, username, 'Tina', 'Zhou', 'KOR', STR_TO_DATE('13-03-2003', '%d-%m-%Y'), 'FIDE020', 2230, 3 FROM Users WHERE username = 'tina';
INSERT INTO Players SELECT id, username, 'Umar', 'Haddad', 'UAE', STR_TO_DATE('01-11-1997', '%d-%m-%Y'), 'FIDE021', 2165, 4 FROM Users WHERE username = 'umar';
INSERT INTO Players SELECT id, username, 'Vera', 'Nowak', 'POL', STR_TO_DATE('22-04-2001', '%d-%m-%Y'), 'FIDE022', 2260, 2 FROM Users WHERE username = 'vera';
INSERT INTO Players SELECT id, username, 'Will', 'Johnson', 'AUS', STR_TO_DATE('18-06-2000', '%d-%m-%Y'), 'FIDE023', 2195, 3 FROM Users WHERE username = 'will';
INSERT INTO Players SELECT id, username, 'Xena', 'Popov', 'RUS', STR_TO_DATE('09-02-1998', '%d-%m-%Y'), 'FIDE024', 2330, 1 FROM Users WHERE username = 'xena';
INSERT INTO Players SELECT id, username, 'Yusuf', 'Demir', 'TUR', STR_TO_DATE('26-12-1999', '%d-%m-%Y'), 'FIDE025', 2170, 4 FROM Users WHERE username = 'yusuff';
INSERT INTO Players SELECT id, username, 'Zoe', 'Tanaka', 'JPN', STR_TO_DATE('05-05-2001', '%d-%m-%Y'), 'FIDE026', 2220, 2 FROM Users WHERE username = 'zoe';
INSERT INTO Players SELECT id, username, 'Hakan', 'Şimşek', 'TUR', STR_TO_DATE('14-10-1997', '%d-%m-%Y'), 'FIDE027', 2110, 4 FROM Users WHERE username = 'hakan';
INSERT INTO Players SELECT id, username, 'Julia', 'Nilsen', 'SWE', STR_TO_DATE('02-03-2002', '%d-%m-%Y'), 'FIDE028', 2300, 1 FROM Users WHERE username = 'julia';
INSERT INTO Players SELECT id, username, 'Mehmet', 'Yıldız', 'TUR', STR_TO_DATE('31-07-1998', '%d-%m-%Y'), 'FIDE029', 2080, 3 FROM Users WHERE username = 'mehmet';
INSERT INTO Players SELECT id, username, 'Elena', 'Kuznetsova', 'RUS', STR_TO_DATE('24-09-2000', '%d-%m-%Y'), 'FIDE030', 2345, 1 FROM Users WHERE username = 'elena';
INSERT INTO Players SELECT id, username, 'Nina', 'Martinez', 'ESP', STR_TO_DATE('12-07-2001', '%d-%m-%Y'), 'FIDE031', 2150, 3 FROM Users WHERE username = 'nina';
INSERT INTO Players SELECT id, username, 'Louis', 'Schneider', 'GER', STR_TO_DATE('08-11-1998', '%d-%m-%Y'), 'FIDE032', 2100, 4 FROM Users WHERE username = 'louis';
INSERT INTO Players SELECT id, username, 'Sofia', 'Russo', 'ITA', STR_TO_DATE('17-02-2000', '%d-%m-%Y'), 'FIDE033', 2250, 2 FROM Users WHERE username = 'sofia';
INSERT INTO Players SELECT id, username, 'Ryan', 'Edwards', 'USA', STR_TO_DATE('02-09-1997', '%d-%m-%Y'), 'FIDE034', 2170, 3 FROM Users WHERE username = 'ryan';
INSERT INTO Players SELECT id, username, 'Claire', 'Dupont', 'FRA', STR_TO_DATE('11-01-2002', '%d-%m-%Y'), 'FIDE035', 2225, 2 FROM Users WHERE username = 'claire';
INSERT INTO Players SELECT id, username, 'Jacob', 'Green', 'AUS', STR_TO_DATE('20-10-1999', '%d-%m-%Y'), 'FIDE036', 2120, 4 FROM Users WHERE username = 'jacob';
INSERT INTO Players SELECT id, username, 'Ava', 'Kowalski', 'POL', STR_TO_DATE('04-05-2003', '%d-%m-%Y'), 'FIDE037', 2300, 2 FROM Users WHERE username = 'ava';
INSERT INTO Players SELECT id, username, 'Ethan', 'Yamamoto', 'JPN', STR_TO_DATE('25-03-1998', '%d-%m-%Y'), 'FIDE038', 2190, 3 FROM Users WHERE username = 'ethan';
INSERT INTO Players SELECT id, username, 'Isabella', 'Moretti', 'ITA', STR_TO_DATE('19-08-2001', '%d-%m-%Y'), 'FIDE039', 2240, 2 FROM Users WHERE username = 'isabella';
INSERT INTO Players SELECT id, username, 'Logan', 'O''Connor', 'IRL', STR_TO_DATE('14-04-1997', '%d-%m-%Y'), 'FIDE040', 2115, 4 FROM Users WHERE username = 'logan';
INSERT INTO Players SELECT id, username, 'Sophia', 'Weber', 'GER', STR_TO_DATE('01-06-2000', '%d-%m-%Y'), 'FIDE041', 2280, 2 FROM Users WHERE username = 'sophia';
INSERT INTO Players SELECT id, username, 'Lucas', 'Novak', 'CZE', STR_TO_DATE('30-12-1999', '%d-%m-%Y'), 'FIDE042', 2145, 4 FROM Users WHERE username = 'lucas';
INSERT INTO Players SELECT id, username, 'Harper', 'Clarke', 'UK', STR_TO_DATE('06-07-2002', '%d-%m-%Y'), 'FIDE043', 2200, 2 FROM Users WHERE username = 'harper';
INSERT INTO Players SELECT id, username, 'James', 'Silva', 'BRA', STR_TO_DATE('21-03-1998', '%d-%m-%Y'), 'FIDE044', 2155, 3 FROM Users WHERE username = 'james';
INSERT INTO Players SELECT id, username, 'Amelia', 'Zhang', 'CHN', STR_TO_DATE('09-09-2001', '%d-%m-%Y'), 'FIDE045', 2275, 2 FROM Users WHERE username = 'amelia';
INSERT INTO Players SELECT id, username, 'Benjamin', 'Fischer', 'GER', STR_TO_DATE('27-01-1997', '%d-%m-%Y'), 'FIDE046', 2095, 4 FROM Users WHERE username = 'benjamin';
INSERT INTO Players SELECT id, username, 'Ella', 'Svensson', 'SWE', STR_TO_DATE('03-11-2000', '%d-%m-%Y'), 'FIDE047', 2235, 2 FROM Users WHERE username = 'ella';
INSERT INTO Players SELECT id, username, 'Alex', 'Dimitrov', 'BUL', STR_TO_DATE('22-05-1999', '%d-%m-%Y'), 'FIDE048', 2180, 3 FROM Users WHERE username = 'alex';
INSERT INTO Players SELECT id, username, 'Lily', 'Nakamura', 'USA', STR_TO_DATE('12-02-2003', '%d-%m-%Y'), 'FIDE049', 2310, 2 FROM Users WHERE username = 'lily';

-- Insert into Coaches (after corresponding Users exist)

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Carol', 'White', 'Canada'
FROM Users WHERE username = 'carol';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'David', 'Brown', 'USA'
FROM Users WHERE username = 'david_b';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Emma', 'Green', 'UK'
FROM Users WHERE username = 'emma_green';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Fatih', 'Ceylan', 'Turkey'
FROM Users WHERE username = 'fatih';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Hana', 'Yamada', 'Japan'
FROM Users WHERE username = 'hana';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Lucas', 'Müller', 'Germany'
FROM Users WHERE username = 'lucaas';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Mia', 'Rossi', 'Italy'
FROM Users WHERE username = 'mia_rose';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Onur', 'Kaya', 'Turkey'
FROM Users WHERE username = 'onur';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Sofia', 'López', 'Spain'
FROM Users WHERE username = 'sofia_lop';

INSERT INTO Coaches (id, username, name, surname, nationality)
SELECT id, username, 'Yusuf', 'Arslan', 'Turkey'
FROM Users WHERE username = 'arslan_yusuf';


-- Insert into Arbiters table

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Erin', 'Gray', 'Germany', 'Advanced'
FROM Users WHERE username = 'erin';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Mark', 'Blake', 'USA', 'Intermediate'
FROM Users WHERE username = 'mark';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Lucy', 'Wang', 'China', 'Expert'
FROM Users WHERE username = 'lucy';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Ahmet', 'Yılmaz', 'Turkey', 'Beginner'
FROM Users WHERE username = 'ahmet';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Ana', 'Costa', 'Brazil', 'Advanced'
FROM Users WHERE username = 'ana';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'James', 'Taylor', 'UK', 'Intermediate'
FROM Users WHERE username = 'james';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Sara', 'Kim', 'South Korea', 'Expert'
FROM Users WHERE username = 'sara';

INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level)
SELECT id, username, 'Mohamed', 'Farouk', 'Egypt', 'Advanced'
FROM Users WHERE username = 'mohamed';

-- Insert into CertificationArbiter using Arbiters.username

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'erin'
WHERE c.name = 'FIDE Certified';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'mark'
WHERE c.name = 'National Arbiter';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'lucy'
WHERE c.name = 'International Arbiter';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'ahmet'
WHERE c.name = 'Local Certification';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'ana'
WHERE c.name = 'FIDE Certified';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'james'
WHERE c.name = 'Regional Certification';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'sara'
WHERE c.name = 'International Arbiter';

INSERT INTO CertificationArbiter (certification_id, arbiter_id)
SELECT c.id, a.id
FROM Certification c
JOIN Arbiters a ON a.username = 'mohamed'
WHERE c.name = 'National Arbiter';

-- Insert into CertificationCoach using Coaches.username

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'carol'
WHERE c.name = 'FIDE Certified';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'carol'
WHERE c.name = 'National Level';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'david_b'
WHERE c.name = 'National Level';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'emma_green'
WHERE c.name = 'FIDE Certified';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'fatih'
WHERE c.name = 'National Level';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'hana'
WHERE c.name = 'Regional Certified';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'lucaas'
WHERE c.name = 'Club Level';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'lucaas'
WHERE c.name = 'Regional Certified';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'mia_rose'
WHERE c.name = 'FIDE Certified';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'onur'
WHERE c.name = 'National Level';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'sofia_lop'
WHERE c.name = 'Regional Certified';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'arslan_yusuf'
WHERE c.name = 'Club Level';

INSERT INTO CertificationCoach (certification_id, coach_id)
SELECT c.id, ch.id
FROM Certification c
JOIN Coaches ch ON ch.username = 'arslan_yusuf'
WHERE c.name = 'National Level';


-- Insert into Plays_in table
-- Insert into Plays_in using Players.username to get player_user_id

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 1 FROM Players WHERE username = 'alice';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 2 FROM Players WHERE username = 'bob1';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 3 FROM Players WHERE username = 'clara';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 4 FROM Players WHERE username = 'david';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 5 FROM Players WHERE username = 'emma';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 6 FROM Players WHERE username = 'felix';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 7 FROM Players WHERE username = 'grace';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 8 FROM Players WHERE username = 'henry';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 9 FROM Players WHERE username = 'isabel';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 10 FROM Players WHERE username = 'jack';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 1 FROM Players WHERE username = 'kara';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 2 FROM Players WHERE username = 'liam';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 3 FROM Players WHERE username = 'mia';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 4 FROM Players WHERE username = 'noah';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 5 FROM Players WHERE username = 'olivia';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 6 FROM Players WHERE username = 'peter';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 7 FROM Players WHERE username = 'quinn';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 8 FROM Players WHERE username = 'rachel';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 9 FROM Players WHERE username = 'sam';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 10 FROM Players WHERE username = 'tina';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 1 FROM Players WHERE username = 'umar';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 2 FROM Players WHERE username = 'vera';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 3 FROM Players WHERE username = 'will';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 4 FROM Players WHERE username = 'xena';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 5 FROM Players WHERE username = 'yusuff';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 6 FROM Players WHERE username = 'zoe';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 7 FROM Players WHERE username = 'hakan';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 8 FROM Players WHERE username = 'julia';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 9 FROM Players WHERE username = 'mehmet';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 10 FROM Players WHERE username = 'elena';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 1 FROM Players WHERE username = 'nina';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 2 FROM Players WHERE username = 'louis';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 3 FROM Players WHERE username = 'sofia';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 4 FROM Players WHERE username = 'ryan';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 5 FROM Players WHERE username = 'claire';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 6 FROM Players WHERE username = 'jacob';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 7 FROM Players WHERE username = 'ava';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 8 FROM Players WHERE username = 'ethan';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 9 FROM Players WHERE username = 'isabella';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 10 FROM Players WHERE username = 'logan';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 1 FROM Players WHERE username = 'sophia';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 2 FROM Players WHERE username = 'lucas';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 3 FROM Players WHERE username = 'harper';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 4 FROM Players WHERE username = 'james_player';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 5 FROM Players WHERE username = 'amelia';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 6 FROM Players WHERE username = 'benjamin';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 7 FROM Players WHERE username = 'ella';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 8 FROM Players WHERE username = 'alex';

INSERT INTO Plays_in (player_user_id, team_id)
SELECT id, 9 FROM Players WHERE username = 'lily';


-- Insert into Matches and MatchResults tables
-- MATCHES INSERT
INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 1, STR_TO_DATE('01-02-2025', '%d-%m-%Y'), 1, 1, 1, 1, 2, a.id, '8,2'
FROM Arbiters a WHERE a.username = 'erin';
INSERT INTO MatchResults (id, white_player_id, black_player_id, result)
SELECT 1, p1.id, p2.id, 'draw'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'alice' AND p2.username = 'bob1';


INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 2, STR_TO_DATE('01-02-2025', '%d-%m-%Y'), 3, 1, 2, 3, 4, a.id, '7,9'
FROM Arbiters a WHERE a.username = 'lucy';
INSERT INTO MatchResults SELECT 2, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'clara' AND p2.username = 'david';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 3, STR_TO_DATE('02-02-2025', '%d-%m-%Y'), 1, 2, 1, 5, 6, a.id, NULL
FROM Arbiters a WHERE a.username = 'mark';
INSERT INTO MatchResults SELECT 3, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'emma' AND p2.username = 'felix';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 4, STR_TO_DATE('02-02-2025', '%d-%m-%Y'), 3, 2, 2, 7, 8, a.id, '8,5'
FROM Arbiters a WHERE a.username = 'erin';
INSERT INTO MatchResults SELECT 4, p1.id, p2.id, 'draw'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'grace' AND p2.username = 'henry';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 5, STR_TO_DATE('03-02-2025', '%d-%m-%Y'), 1, 3, 1, 9, 10, a.id, NULL
FROM Arbiters a WHERE a.username = 'lucy';
INSERT INTO MatchResults SELECT 5, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'isabel' AND p2.username = 'jack';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 6, STR_TO_DATE('03-02-2025', '%d-%m-%Y'), 3, 3, 2, 1, 3, a.id, NULL
FROM Arbiters a WHERE a.username = 'mohamed';
INSERT INTO MatchResults SELECT 6, p1.id, p2.id, 'white wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'kara' AND p2.username = 'liam';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 7, STR_TO_DATE('04-02-2025', '%d-%m-%Y'), 1, 4, 1, 2, 5, a.id, '4,5'
FROM Arbiters a WHERE a.username = 'erin';
INSERT INTO MatchResults SELECT 7, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'mia' AND p2.username = 'noah';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 8, STR_TO_DATE('04-02-2025', '%d-%m-%Y'), 3, 4, 2, 6, 7, a.id, '3,1'
FROM Arbiters a WHERE a.username = 'sara';
INSERT INTO MatchResults SELECT 8, p1.id, p2.id, 'white wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'olivia' AND p2.username = 'peter';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 9, STR_TO_DATE('05-02-2025', '%d-%m-%Y'), 1, 5, 1, 8, 9, a.id, '7,7'
FROM Arbiters a WHERE a.username = 'ana';
INSERT INTO MatchResults SELECT 9, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'quinn' AND p2.username = 'rachel';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 10, STR_TO_DATE('05-02-2025', '%d-%m-%Y'), 3, 5, 2, 10, 1, a.id, '6,4'
FROM Arbiters a WHERE a.username = 'mark';
INSERT INTO MatchResults SELECT 10, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'sam' AND p2.username = 'tina';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 11, STR_TO_DATE('06-02-2025', '%d-%m-%Y'), 1, 1, 1, 3, 5, a.id, '5,1'
FROM Arbiters a WHERE a.username = 'james';
INSERT INTO MatchResults SELECT 11, p1.id, p2.id, 'white wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'tina' AND p2.username = 'umar';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 12, STR_TO_DATE('06-02-2025', '%d-%m-%Y'), 3, 1, 2, 4, 6, a.id, NULL
FROM Arbiters a WHERE a.username = 'lucy';
INSERT INTO MatchResults SELECT 12, p1.id, p2.id, 'white wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'umar' AND p2.username = 'vera';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 13, STR_TO_DATE('07-02-2025', '%d-%m-%Y'), 1, 2, 1, 7, 9, a.id, NULL
FROM Arbiters a WHERE a.username = 'sara';
INSERT INTO MatchResults SELECT 13, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'vera' AND p2.username = 'will';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 14, STR_TO_DATE('07-02-2025', '%d-%m-%Y'), 3, 2, 2, 8, 10, a.id, '2,6'
FROM Arbiters a WHERE a.username = 'mohamed';
INSERT INTO MatchResults SELECT 14, p1.id, p2.id, 'draw'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'will' AND p2.username = 'xena';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 15, STR_TO_DATE('08-02-2025', '%d-%m-%Y'), 1, 3, 1, 1, 4, a.id, '7,1'
FROM Arbiters a WHERE a.username = 'erin';
INSERT INTO MatchResults SELECT 15, p1.id, p2.id, 'draw'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'xena' AND p2.username = 'yusuff';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 16, STR_TO_DATE('08-02-2025', '%d-%m-%Y'), 3, 3, 2, 2, 5, a.id, '6,3'
FROM Arbiters a WHERE a.username = 'ana';
INSERT INTO MatchResults SELECT 16, p1.id, p2.id, 'white wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'yusuff' AND p2.username = 'zoe';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 17, STR_TO_DATE('09-02-2025', '%d-%m-%Y'), 1, 4, 1, 3, 6, a.id, NULL
FROM Arbiters a WHERE a.username = 'james';
INSERT INTO MatchResults SELECT 17, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'zoe' AND p2.username = 'hakan';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 18, STR_TO_DATE('09-02-2025', '%d-%m-%Y'), 3, 4, 2, 7, 10, a.id, '4,9'
FROM Arbiters a WHERE a.username = 'mark';
INSERT INTO MatchResults SELECT 18, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'hakan' AND p2.username = 'julia';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 19, STR_TO_DATE('10-02-2025', '%d-%m-%Y'), 1, 5, 1, 5, 8, a.id, '9,7'
FROM Arbiters a WHERE a.username = 'lucy';
INSERT INTO MatchResults SELECT 19, p1.id, p2.id, 'black wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'julia' AND p2.username = 'mehmet';

INSERT INTO Matches (id, date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id, ratings)
SELECT 20, STR_TO_DATE('10-02-2025', '%d-%m-%Y'), 3, 5, 2, 6, 9, a.id, '7,4'
FROM Arbiters a WHERE a.username = 'ahmet';
INSERT INTO MatchResults SELECT 20, p1.id, p2.id, 'white wins'
FROM Players p1 JOIN Players p2
WHERE p1.username = 'mehmet' AND p2.username = 'elena';
