-- Create views for the chess database
-- These views will help maintain data integrity while preserving existing invalid records

-- Login view that checks both hashed and plain text passwords
CREATE OR REPLACE VIEW LoginView AS
SELECT 
    u.username,
    u.role,
    CASE 
        WHEN u.password = SHA2(u.password, 256) THEN 'hashed'
        ELSE 'plain'
    END as password_type
FROM Users u;

-- View for active player contracts
CREATE OR REPLACE VIEW ActivePlayerContracts AS
SELECT 
    p.username,
    p.name,
    p.surname,
    t.teamID,
    t.teamName,
    pi.contractStart,
    pi.contractFinish
FROM Players p
JOIN Plays_in pi ON p.username = pi.username
JOIN Team t ON pi.teamID = t.teamID
WHERE CURRENT_DATE BETWEEN pi.contractStart AND pi.contractFinish;

-- View for active coach contracts
CREATE OR REPLACE VIEW ActiveCoachContracts AS
SELECT 
    c.username,
    c.name,
    c.surname,
    t.teamID,
    t.teamName,
    cta.contractStart,
    cta.contractFinish
FROM Coaches c
JOIN CoachTeamAgreement cta ON c.user_id = cta.coach_user_id
JOIN Team t ON cta.teamID = t.teamID
WHERE CURRENT_DATE BETWEEN cta.contractStart AND cta.contractFinish;

-- View for match assignments with team validation
CREATE OR REPLACE VIEW MatchAssignmentsWithValidation AS
SELECT 
    m.matchID,
    m.date,
    m.timeSlot,
    m.hallID,
    m.tableNo,
    m.team1ID,
    m.team2ID,
    m.arbiter_username,
    ma.white_player,
    ma.black_player,
    ma.result,
    m.ratings,
    -- Validation flags (for information only, doesn't prevent viewing)
    CASE 
        WHEN wp.teamID != m.team1ID AND wp.teamID != m.team2ID THEN 'Invalid White Player Team'
        WHEN bp.teamID != m.team1ID AND bp.teamID != m.team2ID THEN 'Invalid Black Player Team'
        WHEN wp.teamID = bp.teamID THEN 'Players from Same Team'
        ELSE 'Valid'
    END as assignment_status
FROM Matches m
JOIN MatchAssignments ma ON m.matchID = ma.match_id
JOIN Plays_in wp ON ma.white_player = wp.username
JOIN Plays_in bp ON ma.black_player = bp.username;

-- View for player statistics
CREATE OR REPLACE VIEW PlayerStatistics AS
SELECT 
    p.username,
    p.name,
    p.surname,
    p.elo_rating,
    t.titleName,
    COUNT(DISTINCT m.matchID) as total_matches,
    SUM(CASE WHEN ma.result = 'white wins' AND ma.white_player = p.username THEN 1
             WHEN ma.result = 'black wins' AND ma.black_player = p.username THEN 1
             ELSE 0 END) as wins,
    SUM(CASE WHEN ma.result = 'draw' THEN 1 ELSE 0 END) as draws,
    SUM(CASE WHEN ma.result = 'white wins' AND ma.black_player = p.username THEN 1
             WHEN ma.result = 'black wins' AND ma.white_player = p.username THEN 1
             ELSE 0 END) as losses
FROM Players p
LEFT JOIN Title t ON p.title_id = t.titleID
LEFT JOIN MatchAssignments ma ON p.username IN (ma.white_player, ma.black_player)
LEFT JOIN Matches m ON ma.match_id = m.matchID
GROUP BY p.username, p.name, p.surname, p.elo_rating, t.titleName;

-- View for team statistics
CREATE OR REPLACE VIEW TeamStatistics AS
SELECT 
    t.teamID,
    t.teamName,
    s.sponsorName,
    COUNT(DISTINCT p.username) as total_players,
    COUNT(DISTINCT c.username) as total_coaches,
    COUNT(DISTINCT m.matchID) as total_matches,
    SUM(CASE 
        WHEN (m.team1ID = t.teamID AND ma.result = 'white wins') OR 
             (m.team2ID = t.teamID AND ma.result = 'black wins') THEN 1
        ELSE 0 
    END) as wins,
    SUM(CASE WHEN ma.result = 'draw' THEN 1 ELSE 0 END) as draws,
    SUM(CASE 
        WHEN (m.team1ID = t.teamID AND ma.result = 'black wins') OR 
             (m.team2ID = t.teamID AND ma.result = 'white wins') THEN 1
        ELSE 0 
    END) as losses
FROM Team t
LEFT JOIN Sponsor s ON t.sponsorID = s.sponsorID
LEFT JOIN Plays_in pi ON t.teamID = pi.teamID
LEFT JOIN Players p ON pi.username = p.username
LEFT JOIN Coaches c ON c.team_id = t.teamID
LEFT JOIN Matches m ON t.teamID IN (m.team1ID, m.team2ID)
LEFT JOIN MatchAssignments ma ON m.matchID = ma.match_id
GROUP BY t.teamID, t.teamName, s.sponsorName;

-- View for hall utilization
CREATE OR REPLACE VIEW HallUtilization AS
SELECT 
    h.hallID,
    h.hallName,
    h.hallCountry,
    h.hallCapacity,
    COUNT(DISTINCT m.matchID) as total_matches,
    COUNT(DISTINCT ht.tableNo) as total_tables,
    COUNT(DISTINCT m.tableNo) as tables_used,
    ROUND(COUNT(DISTINCT m.matchID) / COUNT(DISTINCT ht.tableNo) * 100, 2) as utilization_percentage
FROM Hall h
LEFT JOIN HallTable ht ON h.hallID = ht.hallID
LEFT JOIN Matches m ON h.hallID = m.hallID
GROUP BY h.hallID, h.hallName, h.hallCountry, h.hallCapacity;

-- View for arbiter assignments
CREATE OR REPLACE VIEW ArbiterAssignments AS
SELECT 
    a.username,
    a.name,
    a.surname,
    ac.certification,
    COUNT(DISTINCT m.matchID) as total_matches,
    COUNT(DISTINCT m.date) as days_worked,
    GROUP_CONCAT(DISTINCT h.hallName) as halls_worked
FROM Arbiters a
LEFT JOIN ArbiterCertifications ac ON a.username = ac.username
LEFT JOIN Matches m ON a.username = m.arbiter_username
LEFT JOIN Hall h ON m.hallID = h.hallID
GROUP BY a.username, a.name, a.surname, ac.certification; 