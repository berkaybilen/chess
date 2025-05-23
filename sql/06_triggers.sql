DELIMITER //

CREATE TRIGGER validate_player_elo_before_insert
BEFORE INSERT ON Players
FOR EACH ROW
BEGIN
    IF NEW.elo_rating < 0 OR NEW.elo_rating > 3000 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ELO rating must be between 0 and 3000';
    END IF;
END//

CREATE TRIGGER validate_player_elo_before_update
BEFORE UPDATE ON Players
FOR EACH ROW
BEGIN
    IF NEW.elo_rating < 0 OR NEW.elo_rating > 3000 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ELO rating must be between 0 and 3000';
    END IF;
END//

CREATE TRIGGER prevent_self_matches
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    IF NEW.team_white = NEW.team_black THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'A team cannot play against itself';
    END IF;
END//

CREATE TRIGGER validate_match_time_slot
BEFORE INSERT ON Matches
FOR EACH ROW
BEGIN
    IF NEW.time_slot < 1 OR NEW.time_slot > 7 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Time slot must be between 1 and 7';
    END IF;
END//

CREATE TRIGGER validate_match_result
BEFORE INSERT ON MatchResults
FOR EACH ROW
BEGIN
    IF NEW.result IS NOT NULL AND 
       NEW.result NOT IN ('white wins', 'black wins', 'draw') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid match result. Must be "white wins", "black wins", or "draw"';
    END IF;
END//

CREATE TRIGGER validate_match_players
BEFORE UPDATE ON MatchResults
FOR EACH ROW
BEGIN
    IF NEW.result IS NOT NULL AND (NEW.white_player_id IS NULL OR NEW.black_player_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Both players must be specified for a rated match';
    END IF;
END//

CREATE TRIGGER set_user_role_player
AFTER INSERT ON Players
FOR EACH ROW
BEGIN
    UPDATE Users SET role = 'player' WHERE id = NEW.id;
END//

CREATE TRIGGER set_user_role_coach
AFTER INSERT ON Coaches
FOR EACH ROW
BEGIN
    UPDATE Users SET role = 'coach' WHERE id = NEW.id;
END//

CREATE TRIGGER set_user_role_arbiter
AFTER INSERT ON Arbiters
FOR EACH ROW
BEGIN
    UPDATE Users SET role = 'arbiter' WHERE id = NEW.id;
END//

DELIMITER ;