-- -- Master DB Initialization Script
-- -- This file has been renamed to prevent it from being automatically executed
-- -- All individual SQL files are already being executed by Docker in alphabetical order

-- -- Disable warnings for cleaner output
-- SET sql_notes = 0;

-- -- Execute schema creation scripts first
-- SOURCE /docker-entrypoint-initdb.d/01_create_user_table.sql;
-- SOURCE /docker-entrypoint-initdb.d/02_create_team_table.sql;
-- SOURCE /docker-entrypoint-initdb.d/04_create_match_table.sql;

-- -- Execute triggers script if it exists
-- SOURCE /docker-entrypoint-initdb.d/04_triggers.sql;

-- -- Now initialize the data
-- SOURCE /docker-entrypoint-initdb.d/05_initialize_data.sql;
-- SOURCE /docker-entrypoint-initdb.d/06_initialize_relationships.sql;

-- -- Re-enable warnings
-- SET sql_notes = 1;

-- -- Output success message
-- SELECT 'Database initialization completed successfully!' AS 'Init Status'; 