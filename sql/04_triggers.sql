DELIMITER //

-- -- 6.1 Password Policy & Hashing
-- CREATE TRIGGER trg_user_password_policy
-- BEFORE INSERT ON Users
-- FOR EACH ROW
-- BEGIN
--     IF CHAR_LENGTH(NEW.password) >= 8
--        OR NEW.password NOT REGEXP '[A-Z]'
--        OR NEW.password NOT REGEXP '[a-z]'
--        OR NEW.password NOT REGEXP '[0-9]'
--        OR NEW.password NOT REGEXP '[^A-Za-z0-9]'
--     THEN
--         SIGNAL SQLSTATE '45000'
--           SET MESSAGE_TEXT = 'Password must be ≥8 chars, include upper/lower/digit/special';
--     END IF;
--     SET NEW.password = SHA2(NEW.password, 256);
-- END //

-- -- Mirror on UPDATE
-- CREATE TRIGGER trg_user_password_policy_upd
-- BEFORE UPDATE ON Users
-- FOR EACH ROW
-- BEGIN
--     IF OLD.password <> NEW.password THEN
--         IF CHAR_LENGTH(NEW.password) < 8
--            OR NEW.password NOT REGEXP BINARY '[A-Z]'
--            OR NEW.password NOT REGEXP BINARY '[a-z]'
--            OR NEW.password NOT REGEXP '[0-9]'
--            OR NEW.password NOT REGEXP '[^A-Za-z0-9]'
--         THEN
--             SIGNAL SQLSTATE '45000'
--               SET MESSAGE_TEXT = 'Password must be ≥8 chars, include upper/lower/digit/special';
--         END IF;
--         SET NEW.password = SHA2(NEW.password, 256);
--     END IF;
-- END //

-- 6.2 No Overlapping Matches (Hall/Table/Time)
CREATE TRIGGER trg_match_time_conflict
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
      FROM Matches
      WHERE date = NEW.date
        AND hallID = NEW.hallID
        AND tableNo = NEW.tableNo
        AND (
            NEW.timeSlot BETWEEN timeSlot AND timeSlot+1
         OR NEW.timeSlot+1 BETWEEN timeSlot AND timeSlot+1
        );
    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Time slot conflict for hall/table';
    END IF;
END //

-- 6.3 Arbiter Availability
CREATE TRIGGER trg_arbiter_availability
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    DECLARE is_certified BOOLEAN;
    
    -- Check if arbiter is certified
    SELECT COUNT(*) > 0 INTO is_certified
    FROM ArbiterCertifications
    WHERE arbiter_username = NEW.arbiter_username;
    
    IF NOT is_certified THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Selected arbiter is not certified';
    END IF;
    
    -- Check arbiter availability
    SELECT COUNT(*) INTO cnt
      FROM Matches
      WHERE date = NEW.date
        AND arbiter_username = NEW.arbiter_username
        AND (
            NEW.timeSlot BETWEEN timeSlot AND timeSlot+1
         OR NEW.timeSlot+1 BETWEEN timeSlot AND timeSlot+1
        );
    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Arbiter not available at this time';
    END IF;
END //

-- 6.4 Team Availability
CREATE TRIGGER trg_team_availability
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    
    -- Check team1 availability
    SELECT COUNT(*) INTO cnt
      FROM Matches
      WHERE date = NEW.date
        AND (team1ID = NEW.team1ID OR team2ID = NEW.team1ID)
        AND (
            NEW.timeSlot BETWEEN timeSlot AND timeSlot+1
         OR NEW.timeSlot+1 BETWEEN timeSlot AND timeSlot+1
        );
    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Team 1 is already scheduled for a match at this time';
    END IF;
    
    -- Check team2 availability
    SELECT COUNT(*) INTO cnt
      FROM Matches
      WHERE date = NEW.date
        AND (team1ID = NEW.team2ID OR team2ID = NEW.team2ID)
        AND (
            NEW.timeSlot BETWEEN timeSlot AND timeSlot+1
         OR NEW.timeSlot+1 BETWEEN timeSlot AND timeSlot+1
        );
    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Team 2 is already scheduled for a match at this time';
    END IF;
    
    -- Check if teams are different
    IF NEW.team1ID = NEW.team2ID THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'A team cannot play against itself';
    END IF;
END //

-- 6.5 Time Slot Validation
CREATE TRIGGER trg_timeslot_validation
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    IF NEW.timeSlot < 1 OR NEW.timeSlot > 7 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Time slot must be between 1 and 7';
    END IF;
END //

-- 6.6 Player Availability
CREATE TRIGGER trg_player_availability
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE cntW, cntB INT;
    -- white player
    SELECT COUNT(*) INTO cntW
      FROM Matches
      WHERE date = NEW.date
        AND (whitePlayerUsername = NEW.whitePlayerUsername
          OR blackPlayerUsername = NEW.whitePlayerUsername)
        AND (
            NEW.timeSlot BETWEEN timeSlot AND timeSlot+1
         OR NEW.timeSlot+1 BETWEEN timeSlot AND timeSlot+1
        );
    IF cntW > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'White player unavailable at this time';
    END IF;
    -- black player
    SELECT COUNT(*) INTO cntB
      FROM Matches
      WHERE date = NEW.date
        AND (whitePlayerUsername = NEW.blackPlayerUsername
          OR blackPlayerUsername = NEW.blackPlayerUsername)
        AND (
            NEW.timeSlot BETWEEN timeSlot AND timeSlot+1
         OR NEW.timeSlot+1 BETWEEN timeSlot AND timeSlot+1
        );
    IF cntB > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Black player unavailable at this time';
    END IF;
END //

-- 6.7 Team Membership Checks
CREATE TRIGGER trg_player_team_membership
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    -- Check white player's team membership
    SELECT COUNT(*) INTO cnt
      FROM Plays_in
      WHERE player_username = NEW.whitePlayerUsername
        AND teamID = NEW.team1ID;
    IF cnt = 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'White player not in specified team';
    END IF;
    -- Check black player's team membership
    SELECT COUNT(*) INTO cnt
      FROM Plays_in
      WHERE player_username = NEW.blackPlayerUsername
        AND teamID = NEW.team2ID;
    IF cnt = 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Black player not in specified team';
    END IF;
END //

-- 6.8 Tournament Registration Checks
CREATE TRIGGER trg_team_tournament_registration
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
      FROM Participates
      WHERE tournamentID = NEW.tournamentID
        AND teamID = NEW.team1ID;
    IF cnt = 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'White team not registered for tournament';
    END IF;
    SELECT COUNT(*) INTO cnt
      FROM Participates
      WHERE tournamentID = NEW.tournamentID
        AND teamID = NEW.team2ID;
    IF cnt = 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Black team not registered for tournament';
    END IF;
END //

-- 6.9 Coach Contract Overlap
CREATE TRIGGER trg_coach_contract_overlap
BEFORE INSERT ON CoachTeamAgreement
FOR EACH ROW
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
      FROM CoachTeamAgreement
      WHERE coach_username = NEW.coach_username
        AND (
            NEW.contractStart <= contractFinish
         AND NEW.contractFinish >= contractStart
        );
    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Coach has overlapping contract';
    END IF;
END //

-- 6.10 Rating Rules: only once & only after match date
CREATE TRIGGER trg_rating_rules
BEFORE UPDATE ON Matches
FOR EACH ROW
BEGIN
    -- first rating
    IF OLD.rating IS NULL AND NEW.rating IS NOT NULL THEN
        IF OLD.date > CURRENT_DATE() THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Cannot rate match before it occurs';
        END IF;
    -- prevent changes once set
    ELSEIF OLD.rating IS NOT NULL AND NEW.rating <> OLD.rating THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Rating is immutable once set';
    END IF;
END //

DELIMITER ;
