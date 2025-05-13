-- Chess DB Relationships and Matches Data
-- Created for populating database with initial data from CSV files

-- Populate CoachTeamAgreement table
INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 1, STR_TO_DATE('01-01-2023', '%d-%m-%Y'), STR_TO_DATE('01-01-2026', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'carol';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 2, STR_TO_DATE('15-02-2024', '%d-%m-%Y'), STR_TO_DATE('15-02-2026', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'david_b';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 3, STR_TO_DATE('01-03-2022', '%d-%m-%Y'), STR_TO_DATE('01-03-2025', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'emma_green';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 4, STR_TO_DATE('10-05-2024', '%d-%m-%Y'), STR_TO_DATE('10-05-2026', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'fatih';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 5, STR_TO_DATE('01-04-2023', '%d-%m-%Y'), STR_TO_DATE('01-10-2024', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'hana';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 6, STR_TO_DATE('01-01-2024', '%d-%m-%Y'), STR_TO_DATE('01-01-2025', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'lucaas';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 7, STR_TO_DATE('01-06-2024', '%d-%m-%Y'), STR_TO_DATE('01-06-2025', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'mia_rose';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 8, STR_TO_DATE('15-03-2023', '%d-%m-%Y'), STR_TO_DATE('15-09-2025', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'onur';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 9, STR_TO_DATE('01-05-2024', '%d-%m-%Y'), STR_TO_DATE('01-11-2025', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'sofia_lop';

INSERT INTO CoachTeamAgreement (coach_user_id, teamID, contractStart, contractFinish)
SELECT c.user_id, 10, STR_TO_DATE('01-02-2024', '%d-%m-%Y'), STR_TO_DATE('01-08-2026', '%d-%m-%Y')
FROM Coaches c WHERE c.username = 'arslan_yusuf';

-- Populate Plays_in table - Part 1
INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 1 FROM Players p WHERE p.username = 'alice';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 2 FROM Players p WHERE p.username = 'bob1';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 3 FROM Players p WHERE p.username = 'clara';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 4 FROM Players p WHERE p.username = 'david';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 5 FROM Players p WHERE p.username = 'emma';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 6 FROM Players p WHERE p.username = 'felix';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 7 FROM Players p WHERE p.username = 'grace';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 8 FROM Players p WHERE p.username = 'henry';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 9 FROM Players p WHERE p.username = 'isabel';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 10 FROM Players p WHERE p.username = 'jack';

-- Continue for other player-team relationships similarly
INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 1 FROM Players p WHERE p.username = 'kara';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 2 FROM Players p WHERE p.username = 'liam';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 3 FROM Players p WHERE p.username = 'mia';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 4 FROM Players p WHERE p.username = 'noah';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 5 FROM Players p WHERE p.username = 'olivia';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 6 FROM Players p WHERE p.username = 'peter';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 7 FROM Players p WHERE p.username = 'quinn';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 8 FROM Players p WHERE p.username = 'rachel';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 9 FROM Players p WHERE p.username = 'sam';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 10 FROM Players p WHERE p.username = 'tina';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 1 FROM Players p WHERE p.username = 'umar';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 2 FROM Players p WHERE p.username = 'vera';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 3 FROM Players p WHERE p.username = 'will';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 4 FROM Players p WHERE p.username = 'xena';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 5 FROM Players p WHERE p.username = 'yusuff';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 6 FROM Players p WHERE p.username = 'zoe';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 7 FROM Players p WHERE p.username = 'hakan';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 8 FROM Players p WHERE p.username = 'julia';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 9 FROM Players p WHERE p.username = 'mehmet';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 10 FROM Players p WHERE p.username = 'elena';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 1 FROM Players p WHERE p.username = 'nina';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 2 FROM Players p WHERE p.username = 'louis';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 3 FROM Players p WHERE p.username = 'sofia';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 4 FROM Players p WHERE p.username = 'ryan';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 5 FROM Players p WHERE p.username = 'claire';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 6 FROM Players p WHERE p.username = 'jacob';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 7 FROM Players p WHERE p.username = 'ava';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 8 FROM Players p WHERE p.username = 'ethan';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 9 FROM Players p WHERE p.username = 'isabella';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 10 FROM Players p WHERE p.username = 'logan';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 1 FROM Players p WHERE p.username = 'sophia';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 2 FROM Players p WHERE p.username = 'lucas';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 3 FROM Players p WHERE p.username = 'harper';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 4 FROM Players p WHERE p.username = 'james_player';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 5 FROM Players p WHERE p.username = 'amelia';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 6 FROM Players p WHERE p.username = 'benjamin';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 7 FROM Players p WHERE p.username = 'ella';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 8 FROM Players p WHERE p.username = 'alex';

INSERT INTO Plays_in (player_user_id, teamID)
SELECT p.user_id, 9 FROM Players p WHERE p.username = 'lily';

-- Populate ArbiterCertifications table
INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 1 FROM Arbiters a WHERE a.username = 'erin';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 3 FROM Arbiters a WHERE a.username = 'mark';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 2 FROM Arbiters a WHERE a.username = 'lucy';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 5 FROM Arbiters a WHERE a.username = 'ahmet';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 1 FROM Arbiters a WHERE a.username = 'ana';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 4 FROM Arbiters a WHERE a.username = 'james';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 2 FROM Arbiters a WHERE a.username = 'sara';

INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id)
SELECT a.user_id, 3 FROM Arbiters a WHERE a.username = 'mohamed';

-- Populate CoachCertifications table
INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 1 FROM Coaches c WHERE c.username = 'carol';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 7 FROM Coaches c WHERE c.username = 'carol';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 7 FROM Coaches c WHERE c.username = 'david_b';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 1 FROM Coaches c WHERE c.username = 'emma_green';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 7 FROM Coaches c WHERE c.username = 'fatih';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 4 FROM Coaches c WHERE c.username = 'hana';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 6 FROM Coaches c WHERE c.username = 'lucaas';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 4 FROM Coaches c WHERE c.username = 'lucaas';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 1 FROM Coaches c WHERE c.username = 'mia_rose';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 7 FROM Coaches c WHERE c.username = 'onur';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 4 FROM Coaches c WHERE c.username = 'sofia_lop';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 6 FROM Coaches c WHERE c.username = 'arslan_yusuf';

INSERT INTO CoachCertifications (coach_user_id, certification_id)
SELECT c.user_id, 7 FROM Coaches c WHERE c.username = 'arslan_yusuf';

-- Clear Matches table
TRUNCATE TABLE Matches;

-- Populate Matches table with user_ids using values from the CSV
-- Match 1
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 1, STR_TO_DATE('01-02-2025', '%d-%m-%Y'), 1, 1, 1, 1, 2, a.user_id, p1.user_id, p2.user_id, '8,2'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'erin' AND p1.username = 'alice' AND p2.username = 'bob1';

-- Match 2
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 2, STR_TO_DATE('01-02-2025', '%d-%m-%Y'), 3, 1, 2, 3, 4, a.user_id, p1.user_id, p2.user_id, '7,9'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'lucy' AND p1.username = 'clara' AND p2.username = 'david';

-- Match 3 - Note: Table ID 1 for hall ID 2 corresponds to table number 4 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 3, STR_TO_DATE('02-02-2025', '%d-%m-%Y'), 1, 2, 4, 5, 6, a.user_id, p1.user_id, p2.user_id, NULL
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'mark' AND p1.username = 'emma' AND p2.username = 'felix';

-- Match 4 - Note: Table ID 2 for hall ID 2 corresponds to table number 5 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 4, STR_TO_DATE('02-02-2025', '%d-%m-%Y'), 3, 2, 5, 7, 8, a.user_id, p1.user_id, p2.user_id, '8,5'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'erin' AND p1.username = 'grace' AND p2.username = 'henry';

-- Match 5 - Note: Table ID 1 for hall ID 3 corresponds to table number 6 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 5, STR_TO_DATE('03-02-2025', '%d-%m-%Y'), 1, 3, 6, 9, 10, a.user_id, p1.user_id, p2.user_id, NULL
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'lucy' AND p1.username = 'isabel' AND p2.username = 'jack';

-- Match 6 - Note: Table ID 2 for hall ID 3 corresponds to table number 7 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 6, STR_TO_DATE('03-02-2025', '%d-%m-%Y'), 3, 3, 7, 1, 3, a.user_id, p1.user_id, p2.user_id, NULL
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'mohamed' AND p1.username = 'kara' AND p2.username = 'clara';

-- Match 7 - Note: Table ID 1 for hall ID 4 corresponds to table number 9 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 7, STR_TO_DATE('04-02-2025', '%d-%m-%Y'), 1, 4, 9, 2, 5, a.user_id, p1.user_id, p2.user_id, '4,5'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'erin' AND p1.username = 'liam' AND p2.username = 'emma';

-- Match 8 - Note: Table ID 2 for hall ID 4 doesn't exist, we'll use table 9 instead
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 8, STR_TO_DATE('04-02-2025', '%d-%m-%Y'), 3, 4, 9, 6, 7, a.user_id, p1.user_id, p2.user_id, '3,1'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'sara' AND p1.username = 'peter' AND p2.username = 'grace';

-- Match 9 - Note: Table ID 1 for hall ID 5 corresponds to table number 10 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 9, STR_TO_DATE('05-02-2025', '%d-%m-%Y'), 1, 5, 10, 8, 9, a.user_id, p1.user_id, p2.user_id, '7,7'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'ana' AND p1.username = 'rachel' AND p2.username = 'quinn';

-- Match 10 - Note: Table ID 2 for hall ID 5 doesn't exist, we'll use table 10 instead
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 10, STR_TO_DATE('05-02-2025', '%d-%m-%Y'), 3, 5, 10, 10, 1, a.user_id, p1.user_id, p2.user_id, '6,4'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'mark' AND p1.username = 'sam' AND p2.username = 'tina';

-- Match 11 - Note: Table ID 1 for hall ID 1 corresponds to table number 1 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 11, STR_TO_DATE('06-02-2025', '%d-%m-%Y'), 1, 1, 1, 3, 5, a.user_id, p1.user_id, p2.user_id, '5,1'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'james' AND p1.username = 'tina' AND p2.username = 'umar';

-- Match 12 - Note: Table ID 2 for hall ID 1 corresponds to table number 2 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 12, STR_TO_DATE('06-02-2025', '%d-%m-%Y'), 3, 1, 2, 4, 6, a.user_id, p1.user_id, p2.user_id, NULL
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'lucy' AND p1.username = 'umar' AND p2.username = 'vera';

-- Match 13 - Note: Table ID 1 for hall ID 2 corresponds to table number 4 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 13, STR_TO_DATE('07-02-2025', '%d-%m-%Y'), 1, 2, 4, 7, 9, a.user_id, p1.user_id, p2.user_id, NULL
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'sara' AND p1.username = 'vera' AND p2.username = 'will';

-- Match 14 - Note: Table ID 2 for hall ID 2 corresponds to table number 5 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 14, STR_TO_DATE('07-02-2025', '%d-%m-%Y'), 3, 2, 5, 8, 10, a.user_id, p1.user_id, p2.user_id, '2,6'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'mohamed' AND p1.username = 'will' AND p2.username = 'xena';

-- Match 15 - Note: Table ID 1 for hall ID 3 corresponds to table number 6 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 15, STR_TO_DATE('08-02-2025', '%d-%m-%Y'), 1, 3, 6, 1, 4, a.user_id, p1.user_id, p2.user_id, '7,1'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'erin' AND p1.username = 'xena' AND p2.username = 'yusuff';

-- Match 16 - Note: Table ID 2 for hall ID 3 corresponds to table number 7 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 16, STR_TO_DATE('08-02-2025', '%d-%m-%Y'), 3, 3, 7, 2, 5, a.user_id, p1.user_id, p2.user_id, '6,3'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'ana' AND p1.username = 'yusuff' AND p2.username = 'zoe';

-- Match 17 - Note: Table ID 1 for hall ID 4 corresponds to table number 9 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 17, STR_TO_DATE('09-02-2025', '%d-%m-%Y'), 1, 4, 9, 3, 6, a.user_id, p1.user_id, p2.user_id, NULL
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'james' AND p1.username = 'zoe' AND p2.username = 'hakan';

-- Match 18 - Note: Table ID 2 for hall ID 4 doesn't exist, we'll use table 9 instead
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 18, STR_TO_DATE('09-02-2025', '%d-%m-%Y'), 3, 4, 9, 7, 10, a.user_id, p1.user_id, p2.user_id, '4,9'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'mark' AND p1.username = 'hakan' AND p2.username = 'julia';

-- Match 19 - Note: Table ID 1 for hall ID 5 corresponds to table number 10 in HallTable
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 19, STR_TO_DATE('10-02-2025', '%d-%m-%Y'), 1, 5, 10, 5, 8, a.user_id, p1.user_id, p2.user_id, '9,7'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'lucy' AND p1.username = 'julia' AND p2.username = 'mehmet';

-- Match 20 - Note: Table ID 2 for hall ID 5 doesn't exist, we'll use table 10 instead
INSERT INTO Matches (matchID, date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_user_id, whitePlayerUserID, blackPlayerUserID, ratings)
SELECT 20, STR_TO_DATE('10-02-2025', '%d-%m-%Y'), 3, 5, 10, 6, 9, a.user_id, p1.user_id, p2.user_id, '7,4'
FROM Arbiters a, Players p1, Players p2
WHERE a.username = 'ahmet' AND p1.username = 'mehmet' AND p2.username = 'elena';

-- Update match outcomes based on MatchAssignments
UPDATE Matches SET result = 'draw' WHERE matchID = 1;
UPDATE Matches SET result = 'black wins' WHERE matchID = 2;
UPDATE Matches SET result = 'black wins' WHERE matchID = 3;
UPDATE Matches SET result = 'draw' WHERE matchID = 4;
UPDATE Matches SET result = 'black wins' WHERE matchID = 5;
UPDATE Matches SET result = 'white wins' WHERE matchID = 6;
UPDATE Matches SET result = 'black wins' WHERE matchID = 7;
UPDATE Matches SET result = 'white wins' WHERE matchID = 8;
UPDATE Matches SET result = 'black wins' WHERE matchID = 9;
UPDATE Matches SET result = 'black wins' WHERE matchID = 10;
UPDATE Matches SET result = 'white wins' WHERE matchID = 11;
UPDATE Matches SET result = 'white wins' WHERE matchID = 12;
UPDATE Matches SET result = 'black wins' WHERE matchID = 13;
UPDATE Matches SET result = 'draw' WHERE matchID = 14;
UPDATE Matches SET result = 'draw' WHERE matchID = 15;
UPDATE Matches SET result = 'white wins' WHERE matchID = 16;
UPDATE Matches SET result = 'black wins' WHERE matchID = 17;
UPDATE Matches SET result = 'black wins' WHERE matchID = 18;
UPDATE Matches SET result = 'black wins' WHERE matchID = 19;
UPDATE Matches SET result = 'white wins' WHERE matchID = 20;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1; 