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
-- Passwords are now properly hashed with SHA-256
INSERT INTO Users (username, password, role) VALUES
-- Managers (hashed passwords)
('kevin', SHA2('K3v!n#2024', 256), 'manager'),
('bob', SHA2('Bob@Secure88', 256), 'manager'),
('admin1', SHA2('326593', 256), 'manager'),  -- Updated to meet password policy
('jessica', SHA2('secretpw.33#', 256), 'manager'),
('admin2', SHA2('admin2pw', 256), 'manager'),  -- Updated to meet password policy
('fatima', SHA2('F4tima!DBmngr', 256), 'manager'),
('yusuf', SHA2('Yu$ufSecure1', 256), 'manager'),
('maria', SHA2('M@r1a321', 256), 'manager'),

-- Players (hashed passwords)
('alice', SHA2('Pass@123', 256), 'player'),
('bob1', SHA2('Bob@2023', 256), 'player'),
('clara', SHA2('Clara#21', 256), 'player'),
('david', SHA2('D@vid2024', 256), 'player'),
('emma', SHA2('Emm@9win', 256), 'player'),
('felix', SHA2('F3lix$88', 256), 'player'),
('grace', SHA2('Gr@ce2025', 256), 'player'),
('henry', SHA2('Hen!ry777', 256), 'player'),
('isabel', SHA2('Isa#Blue', 256), 'player'),
('jack', SHA2('Jack@321', 256), 'player'),
('kara', SHA2('Kara$99', 256), 'player'),
('liam', SHA2('Li@mChess', 256), 'player'),
('mia', SHA2('M!a2020', 256), 'player'),
('noah', SHA2('Noah#44', 256), 'player'),
('olivia', SHA2('Oliv@99', 256), 'player'),
('peter', SHA2('P3ter!1', 256), 'player'),
('quinn', SHA2('Quinn%x1', 256), 'player'),  -- Updated to meet password policy
('rachel', SHA2('Rach3l@', 256), 'player'),
('sam', SHA2('S@mWise', 256), 'player'),
('tina', SHA2('T!naChess', 256), 'player'),
('umar', SHA2('Umar$22', 256), 'player'),
('vera', SHA2('V3ra#21', 256), 'player'),
('will', SHA2('Will@321', 256), 'player'),
('xena', SHA2('Xena$!1', 256), 'player'),  -- Updated to meet password policy
('yusuff', SHA2('Yusuf88@', 256), 'player'),
('zoe', SHA2('Zo3!pass', 256), 'player'),
('hakan', SHA2('H@kan44', 256), 'player'),
('julia', SHA2('J!ulia77', 256), 'player'),
('mehmet', SHA2('Mehmet#1', 256), 'player'),
('elena', SHA2('El3na@pw', 256), 'player'),
('nina', SHA2('Nina@2024', 256), 'player'),
('louis', SHA2('Louis#88', 256), 'player'),
('sofia', SHA2('Sofia$22', 256), 'player'),
('ryan', SHA2('Ryan@77', 256), 'player'),
('claire', SHA2('Claire#01', 256), 'player'),
('jacob', SHA2('Jacob!pass', 256), 'player'),
('ava', SHA2('Ava@Chess', 256), 'player'),
('ethan', SHA2('Ethan$win', 256), 'player'),
('isabella', SHA2('Isabella#77', 256), 'player'),
('logan', SHA2('Logan@55', 256), 'player'),
('sophia', SHA2('Sophia$12', 256), 'player'),
('lucas', SHA2('Lucas!88', 256), 'player'),
('harper', SHA2('Harper@pw', 256), 'player'),
('james_player', SHA2('James!44', 256), 'player'),
('amelia', SHA2('Amelia#99', 256), 'player'),
('benjamin', SHA2('Ben@2023', 256), 'player'),
('ella', SHA2('Ella@pw1', 256), 'player'),  -- Updated to meet password policy
('alex', SHA2('Alex$88', 256), 'player'),
('lily', SHA2('Lily@sun1', 256), 'player'),  -- Updated to meet password policy

-- Coaches (hashed passwords)
('carol', SHA2('Coach@123', 256), 'coach'),  -- Updated to meet password policy
('david_b', SHA2('dPass!99', 256), 'coach'),
('emma_green', SHA2('E@mma77', 256), 'coach'),
('fatih', SHA2('FatihC@21', 256), 'coach'),  -- Updated to meet password policy
('hana', SHA2('Hana$45', 256), 'coach'),
('lucaas', SHA2('Lucas#1A', 256), 'coach'),  -- Updated to meet password policy
('mia_rose', SHA2('Mia!888', 256), 'coach'),
('onur', SHA2('onUr@32', 256), 'coach'),
('sofia_lop', SHA2('S0fia#A', 256), 'coach'),  -- Updated to meet password policy
('arslan_yusuf', SHA2('Yusuf@199', 256), 'coach'),  -- Updated to meet password policy

-- Arbiters (hashed passwords)
('erin', SHA2('Arb@Pw123', 256), 'arbiter'),  -- Updated to meet password policy
('mark', SHA2('Ref@Pass1', 256), 'arbiter'),  -- Updated to meet password policy
('lucy', SHA2('Arb@123', 256), 'arbiter'),  -- Updated to meet password policy
('ahmet', SHA2('Pass@2024', 256), 'arbiter'),  -- Updated to meet password policy
('ana', SHA2('Secret@Pw1', 256), 'arbiter'),  -- Updated to meet password policy
('james', SHA2('Secure@1', 256), 'arbiter'),  -- Updated to meet password policy
('sara', SHA2('sara!2024A', 256), 'arbiter'),  -- Updated to meet password policy
('mohamed', SHA2('M@Pass123', 256), 'arbiter');  -- Updated to meet password policy

-- Get user_ids for further reference
-- Insert into Players table with user_id reference
INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Alice', 'Smith', 'USA', STR_TO_DATE('10-05-2000', '%d-%m-%Y'), 'FIDE001', 2200, 1 
FROM Users WHERE username = 'alice';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Bob', 'Jones', 'UK', STR_TO_DATE('21-07-1998', '%d-%m-%Y'), 'FIDE002', 2100, 5
FROM Users WHERE username = 'bob1';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Clara', 'Kim', 'KOR', STR_TO_DATE('15-03-2001', '%d-%m-%Y'), 'FIDE003', 2300, 2
FROM Users WHERE username = 'clara';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'David', 'Chen', 'CAN', STR_TO_DATE('02-12-1997', '%d-%m-%Y'), 'FIDE004', 2050, 3
FROM Users WHERE username = 'david';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Emma', 'Rossi', 'ITA', STR_TO_DATE('19-06-1999', '%d-%m-%Y'), 'FIDE005', 2250, 2
FROM Users WHERE username = 'emma';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Felix', 'Novak', 'GER', STR_TO_DATE('04-09-2002', '%d-%m-%Y'), 'FIDE006', 2180, 4
FROM Users WHERE username = 'felix';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Grace', 'Ali', 'TUR', STR_TO_DATE('12-08-2000', '%d-%m-%Y'), 'FIDE007', 2320, 1
FROM Users WHERE username = 'grace';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Henry', 'Patel', 'IND', STR_TO_DATE('25-04-1998', '%d-%m-%Y'), 'FIDE008', 2150, 3
FROM Users WHERE username = 'henry';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Isabel', 'Lopez', 'MEX', STR_TO_DATE('17-02-2001', '%d-%m-%Y'), 'FIDE009', 2240, 3
FROM Users WHERE username = 'isabel';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Jack', 'Brown', 'USA', STR_TO_DATE('30-11-1997', '%d-%m-%Y'), 'FIDE010', 2000, 4
FROM Users WHERE username = 'jack';


-- Insert into Coaches table with user_id reference
INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Carol', 'White', 'Canada'
FROM Users WHERE username = 'carol';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'David', 'Brown', 'USA'
FROM Users WHERE username = 'david_b';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Emma', 'Green', 'UK'
FROM Users WHERE username = 'emma_green';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Fatih', 'Ceylan', 'Turkey'
FROM Users WHERE username = 'fatih';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Hana', 'Yamada', 'Japan'
FROM Users WHERE username = 'hana';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Lucas', 'Müller', 'Germany'
FROM Users WHERE username = 'lucaas';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Mia', 'Rossi', 'Italy'
FROM Users WHERE username = 'mia_rose';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Onur', 'Kaya', 'Turkey'
FROM Users WHERE username = 'onur';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Sofia', 'López', 'Spain'
FROM Users WHERE username = 'sofia_lop';

INSERT INTO Coaches (user_id, username, name, surname, nationality)
SELECT user_id, username, 'Yusuf', 'Arslan', 'Turkey'
FROM Users WHERE username = 'arslan_yusuf';

-- Insert into Arbiters table with user_id reference
INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Erin', 'Gray', 'Germany', 'Advanced'
FROM Users WHERE username = 'erin';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Mark', 'Blake', 'USA', 'Intermediate'
FROM Users WHERE username = 'mark';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Lucy', 'Wang', 'China', 'Expert'
FROM Users WHERE username = 'lucy';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Ahmet', 'Yılmaz', 'Turkey', 'Beginner'
FROM Users WHERE username = 'ahmet';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Ana', 'Costa', 'Brazil', 'Advanced'
FROM Users WHERE username = 'ana';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'James', 'Taylor', 'UK', 'Intermediate'
FROM Users WHERE username = 'james';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Sara', 'Kim', 'South Korea', 'Expert'
FROM Users WHERE username = 'sara';

INSERT INTO Arbiters (user_id, username, name, surname, nationality, experience_level)
SELECT user_id, username, 'Mohamed', 'Farouk', 'Egypt', 'Advanced'
FROM Users WHERE username = 'mohamed';

-- Continue inserting the rest of the players similarly
INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Kara', 'Singh', 'IND', STR_TO_DATE('07-01-2003', '%d-%m-%Y'), 'FIDE011', 2350, 5
FROM Users WHERE username = 'kara';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Liam', 'Müller', 'GER', STR_TO_DATE('23-05-1999', '%d-%m-%Y'), 'FIDE012', 2200, 2
FROM Users WHERE username = 'liam';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Mia', 'Wang', 'CHN', STR_TO_DATE('14-12-2002', '%d-%m-%Y'), 'FIDE013', 2125, 4
FROM Users WHERE username = 'mia';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Noah', 'Evans', 'CAN', STR_TO_DATE('08-08-1996', '%d-%m-%Y'), 'FIDE014', 2400, 1
FROM Users WHERE username = 'noah';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Olivia', 'Taylor', 'UK', STR_TO_DATE('03-06-2001', '%d-%m-%Y'), 'FIDE015', 2280, 2
FROM Users WHERE username = 'olivia';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Peter', 'Dubois', 'FRA', STR_TO_DATE('11-10-2000', '%d-%m-%Y'), 'FIDE016', 2140, 3
FROM Users WHERE username = 'peter';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Quinn', 'Ma', 'CHN', STR_TO_DATE('16-09-1998', '%d-%m-%Y'), 'FIDE017', 2210, 4
FROM Users WHERE username = 'quinn';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Rachel', 'Silva', 'BRA', STR_TO_DATE('06-07-1999', '%d-%m-%Y'), 'FIDE018', 2290, 2
FROM Users WHERE username = 'rachel';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Sam', 'O''Neill', 'IRE', STR_TO_DATE('29-01-2002', '%d-%m-%Y'), 'FIDE019', 2100, 3
FROM Users WHERE username = 'sam';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Tina', 'Zhou', 'KOR', STR_TO_DATE('13-03-2003', '%d-%m-%Y'), 'FIDE020', 2230, 3
FROM Users WHERE username = 'tina';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Umar', 'Haddad', 'UAE', STR_TO_DATE('01-11-1997', '%d-%m-%Y'), 'FIDE021', 2165, 4
FROM Users WHERE username = 'umar';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Vera', 'Nowak', 'POL', STR_TO_DATE('22-04-2001', '%d-%m-%Y'), 'FIDE022', 2260, 2
FROM Users WHERE username = 'vera';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Will', 'Johnson', 'AUS', STR_TO_DATE('18-06-2000', '%d-%m-%Y'), 'FIDE023', 2195, 3
FROM Users WHERE username = 'will';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Xena', 'Popov', 'RUS', STR_TO_DATE('09-02-1998', '%d-%m-%Y'), 'FIDE024', 2330, 1
FROM Users WHERE username = 'xena';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Yusuf', 'Demir', 'TUR', STR_TO_DATE('26-12-1999', '%d-%m-%Y'), 'FIDE025', 2170, 4
FROM Users WHERE username = 'yusuff';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Zoe', 'Tanaka', 'JPN', STR_TO_DATE('05-05-2001', '%d-%m-%Y'), 'FIDE026', 2220, 2
FROM Users WHERE username = 'zoe';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Hakan', 'Şimşek', 'TUR', STR_TO_DATE('14-10-1997', '%d-%m-%Y'), 'FIDE027', 2110, 4
FROM Users WHERE username = 'hakan';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Julia', 'Nilsen', 'SWE', STR_TO_DATE('02-03-2002', '%d-%m-%Y'), 'FIDE028', 2300, 1
FROM Users WHERE username = 'julia';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Mehmet', 'Yıldız', 'TUR', STR_TO_DATE('31-07-1998', '%d-%m-%Y'), 'FIDE029', 2080, 3
FROM Users WHERE username = 'mehmet';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Elena', 'Kuznetsova', 'RUS', STR_TO_DATE('24-09-2000', '%d-%m-%Y'), 'FIDE030', 2345, 1
FROM Users WHERE username = 'elena';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Nina', 'Martinez', 'ESP', STR_TO_DATE('12-07-2001', '%d-%m-%Y'), 'FIDE031', 2150, 3
FROM Users WHERE username = 'nina';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Louis', 'Schneider', 'GER', STR_TO_DATE('08-11-1998', '%d-%m-%Y'), 'FIDE032', 2100, 4
FROM Users WHERE username = 'louis';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Sofia', 'Russo', 'ITA', STR_TO_DATE('17-02-2000', '%d-%m-%Y'), 'FIDE033', 2250, 2
FROM Users WHERE username = 'sofia';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Ryan', 'Edwards', 'USA', STR_TO_DATE('02-09-1997', '%d-%m-%Y'), 'FIDE034', 2170, 3
FROM Users WHERE username = 'ryan';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Claire', 'Dupont', 'FRA', STR_TO_DATE('11-01-2002', '%d-%m-%Y'), 'FIDE035', 2225, 2
FROM Users WHERE username = 'claire';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Jacob', 'Green', 'AUS', STR_TO_DATE('20-10-1999', '%d-%m-%Y'), 'FIDE036', 2120, 4
FROM Users WHERE username = 'jacob';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Ava', 'Kowalski', 'POL', STR_TO_DATE('04-05-2003', '%d-%m-%Y'), 'FIDE037', 2300, 2
FROM Users WHERE username = 'ava';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Ethan', 'Yamamoto', 'JPN', STR_TO_DATE('25-03-1998', '%d-%m-%Y'), 'FIDE038', 2190, 3
FROM Users WHERE username = 'ethan';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Isabella', 'Moretti', 'ITA', STR_TO_DATE('19-08-2001', '%d-%m-%Y'), 'FIDE039', 2240, 2
FROM Users WHERE username = 'isabella';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Logan', 'O''Connor', 'IRL', STR_TO_DATE('14-04-1997', '%d-%m-%Y'), 'FIDE040', 2115, 4
FROM Users WHERE username = 'logan';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Sophia', 'Weber', 'GER', STR_TO_DATE('01-06-2000', '%d-%m-%Y'), 'FIDE041', 2280, 2
FROM Users WHERE username = 'sophia';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Lucas', 'Novak', 'CZE', STR_TO_DATE('30-12-1999', '%d-%m-%Y'), 'FIDE042', 2145, 4
FROM Users WHERE username = 'lucas';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Harper', 'Clarke', 'UK', STR_TO_DATE('06-07-2002', '%d-%m-%Y'), 'FIDE043', 2200, 2
FROM Users WHERE username = 'harper';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'James', 'Silva', 'BRA', STR_TO_DATE('21-03-1998', '%d-%m-%Y'), 'FIDE044', 2155, 3
FROM Users WHERE username = 'james_player';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Amelia', 'Zhang', 'CHN', STR_TO_DATE('09-09-2001', '%d-%m-%Y'), 'FIDE045', 2275, 2
FROM Users WHERE username = 'amelia';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Benjamin', 'Fischer', 'GER', STR_TO_DATE('27-01-1997', '%d-%m-%Y'), 'FIDE046', 2095, 4
FROM Users WHERE username = 'benjamin';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Ella', 'Svensson', 'SWE', STR_TO_DATE('03-11-2000', '%d-%m-%Y'), 'FIDE047', 2235, 2
FROM Users WHERE username = 'ella';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Alex', 'Dimitrov', 'BUL', STR_TO_DATE('22-05-1999', '%d-%m-%Y'), 'FIDE048', 2180, 3
FROM Users WHERE username = 'alex';

INSERT INTO Players (user_id, username, name, surname, nationality, date_of_birth, fide_id, elo_rating, title_id)
SELECT user_id, username, 'Lily', 'Nakamura', 'USA', STR_TO_DATE('12-02-2003', '%d-%m-%Y'), 'FIDE049', 2310, 2
FROM Users WHERE username = 'lily';