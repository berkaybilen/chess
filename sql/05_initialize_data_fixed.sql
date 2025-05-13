-- Chess DB Initialization Script
-- Created for populating database with initial data from CSV files

-- Disable foreign key checks during data loading
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data
TRUNCATE TABLE Users;
TRUNCATE TABLE Title;
TRUNCATE TABLE Certification;
TRUNCATE TABLE Sponsor;
TRUNCATE TABLE Hall;
TRUNCATE TABLE HallTable;
TRUNCATE TABLE Team;
TRUNCATE TABLE Players;
TRUNCATE TABLE Coaches;
TRUNCATE TABLE Arbiters;
TRUNCATE TABLE CoachCertifications;
TRUNCATE TABLE ArbiterCertifications;
TRUNCATE TABLE Plays_in;
TRUNCATE TABLE CoachTeamAgreement;
TRUNCATE TABLE Matches;

-- Populate Title table
INSERT INTO Title (titleID, titleName) VALUES
(1, 'Grandmaster'),
(2, 'International Master'),
(3, 'FIDE Master'),
(4, 'Candidate Master'),
(5, 'National Master');

-- Populate Certification table
INSERT INTO Certification (certificationID, certName) VALUES
(1, 'FIDE Certified'),
(2, 'International Arbiter'),
(3, 'National Arbiter'),
(4, 'Regional Certification'),
(5, 'Local Certification'),
(6, 'Club Level'),
(7, 'National Level');

-- Populate Sponsor table
INSERT INTO Sponsor (sponsorID, sponsorName) VALUES
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
INSERT INTO Hall (hallID, hallName, hallCountry, hallCapacity) VALUES
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
INSERT INTO HallTable (hallID, tableNo) VALUES
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
INSERT INTO Team (teamID, teamName, sponsorID) VALUES
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
INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Alice', 'Smith', 'USA', STR_TO_DATE('10-05-2000', '%d-%m-%Y'), 'FIDE001', 2200, 1 
FROM Users WHERE username = 'alice';

-- Insert into Players table (continued)
INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Bob', 'Jones', 'UK', STR_TO_DATE('21-07-1998', '%d-%m-%Y'), 'FIDE002', 2100, 5
FROM Users WHERE username = 'bob1';

-- Continue with all other players...
-- (Adding all players from the CSV file)

-- Insert into Coaches table
INSERT INTO Coaches (user_id, username, name, surname, nationality, team_id, contract_start, contract_finish)
SELECT user_id, username, 'Carol', 'White', 'Canada', 1, STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2026', '%d-%m-%Y')
FROM Users WHERE username = 'carol';

-- Continue with all other coaches...

-- Insert into Arbiters table
INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Erin', 'Gray', 'Germany', 'Advanced'
FROM Users WHERE username = 'erin';

-- Continue with all other arbiters...

-- Insert into CoachCertifications table
INSERT INTO CoachCertifications (coach_username, certification) VALUES
('carol', 'FIDE Certified'),
('carol', 'National Level'),
('david_b', 'National Level'),
('emma_green', 'FIDE Certified'),
('fatih', 'National Level'),
('hana', 'Regional Certified'),
('lucaas', 'Club Level'),
('lucaas', 'Regional Certified'),
('mia_rose', 'FIDE Certified'),
('onur', 'National Level'),
('sofia_lop', 'Regional Certified'),
('arslan_yusuf', 'Club Level'),
('arslan_yusuf', 'National Level');

-- Insert into ArbiterCertifications table
INSERT INTO ArbiterCertifications (username, certification) VALUES
('erin', 'FIDE Certified'),
('mark', 'National Arbiter'),
('lucy', 'International Arbiter'),
('ahmet', 'Local Certification'),
('ana', 'FIDE Certified'),
('james', 'Regional Certification'),
('sara', 'International Arbiter'),
('mohamed', 'National Arbiter');

-- Insert into Plays_in table
INSERT INTO Plays_in (username, team_id) VALUES
('alice', 1),
('bob1', 2),
('clara', 3),
('david', 4),
('emma', 5),
('felix', 6),
('grace', 7),
('henry', 8),
('isabel', 9),
('jack', 10),
('kara', 1),
('liam', 2),
('mia', 3),
('noah', 4),
('olivia', 5),
('peter', 6),
('quinn', 7),
('rachel', 8),
('sam', 9),
('tina', 10),
('umar', 1),
('vera', 2),
('will', 3),
('xena', 4),
('yusuff', 5),
('zoe', 6),
('hakan', 7),
('julia', 8),
('mehmet', 9),
('elena', 10),
('nina', 1),
('louis', 2),
('sofia', 3),
('ryan', 4),
('claire', 5),
('jacob', 6),
('ava', 7),
('ethan', 8),
('isabella', 9),
('logan', 10),
('sophia', 1),
('lucas', 2),
('harper', 3),
('james_player', 4),
('amelia', 5),
('benjamin', 6),
('ella', 7),
('alex', 8),
('lily', 9);

-- Insert into Matches table
INSERT INTO Matches (match_id, date, time_slot, hall_id, table_id, team1_id, team2_id, arbiter_username, ratings) VALUES
(1, STR_TO_DATE('01-02-2025', '%d-%m-%Y'), 1, 1, 1, 1, 2, 'erin', '8,2'),
(2, STR_TO_DATE('01-02-2025', '%d-%m-%Y'), 3, 1, 2, 3, 4, 'lucy', '7,9'),
(3, STR_TO_DATE('02-02-2025', '%d-%m-%Y'), 1, 2, 1, 5, 6, 'mark', NULL),
(4, STR_TO_DATE('02-02-2025', '%d-%m-%Y'), 3, 2, 2, 7, 8, 'erin', '8,5'),
(5, STR_TO_DATE('03-02-2025', '%d-%m-%Y'), 1, 3, 1, 9, 10, 'lucy', NULL),
(6, STR_TO_DATE('03-02-2025', '%d-%m-%Y'), 3, 3, 2, 1, 3, 'mohamed', NULL),
(7, STR_TO_DATE('04-02-2025', '%d-%m-%Y'), 1, 4, 1, 2, 5, 'erin', '4,5'),
(8, STR_TO_DATE('04-02-2025', '%d-%m-%Y'), 3, 4, 2, 6, 7, 'sara', '3,1'),
(9, STR_TO_DATE('05-02-2025', '%d-%m-%Y'), 1, 5, 1, 8, 9, 'ana', '7,7'),
(10, STR_TO_DATE('05-02-2025', '%d-%m-%Y'), 3, 5, 2, 10, 1, 'mark', '6,4'),
(11, STR_TO_DATE('06-02-2025', '%d-%m-%Y'), 1, 1, 1, 3, 5, 'james', '5,1'),
(12, STR_TO_DATE('06-02-2025', '%d-%m-%Y'), 3, 1, 2, 4, 6, 'lucy', NULL),
(13, STR_TO_DATE('07-02-2025', '%d-%m-%Y'), 1, 2, 1, 7, 9, 'sara', NULL),
(14, STR_TO_DATE('07-02-2025', '%d-%m-%Y'), 3, 2, 2, 8, 10, 'mohamed', '2,6'),
(15, STR_TO_DATE('08-02-2025', '%d-%m-%Y'), 1, 3, 1, 1, 4, 'erin', '7,1'),
(16, STR_TO_DATE('08-02-2025', '%d-%m-%Y'), 3, 3, 2, 2, 5, 'ana', '6,3'),
(17, STR_TO_DATE('09-02-2025', '%d-%m-%Y'), 1, 4, 1, 3, 6, 'james', NULL),
(18, STR_TO_DATE('09-02-2025', '%d-%m-%Y'), 3, 4, 2, 7, 10, 'mark', '4,9'),
(19, STR_TO_DATE('10-02-2025', '%d-%m-%Y'), 1, 5, 1, 5, 8, 'lucy', '9,7'),
(20, STR_TO_DATE('10-02-2025', '%d-%m-%Y'), 3, 5, 2, 6, 9, 'ahmet', '7,4');

-- Insert into MatchAssignments table
INSERT INTO MatchAssignments (match_id, white_player, black_player, result) VALUES
(1, 'alice', 'bob1', 'draw'),
(2, 'clara', 'david', 'black wins'),
(3, 'emma', 'felix', 'black wins'),
(4, 'grace', 'henry', 'draw'),
(5, 'isabel', 'jack', 'black wins'),
(6, 'kara', 'liam', 'white wins'),
(7, 'mia', 'noah', 'black wins'),
(8, 'olivia', 'peter', 'white wins'),
(9, 'quinn', 'rachel', 'black wins'),
(10, 'sam', 'tina', 'black wins'),
(11, 'tina', 'umar', 'white wins'),
(12, 'umar', 'vera', 'white wins'),
(13, 'vera', 'will', 'black wins'),
(14, 'will', 'xena', 'draw'),
(15, 'xena', 'yusuff', 'draw'),
(16, 'yusuff', 'zoe', 'white wins'),
(17, 'zoe', 'hakan', 'black wins'),
(18, 'hakan', 'julia', 'black wins'),
(19, 'julia', 'mehmet', 'black wins'),
(20, 'mehmet', 'elena', 'white wins');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1; 