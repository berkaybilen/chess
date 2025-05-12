-- Disable foreign key checks and triggers temporarily
SET FOREIGN_KEY_CHECKS = 0;
SET TRIGGER_DISABLED = 1;

-- Load data from CSV files (this will be handled by Python script)
-- The Python script will execute this SQL file before loading data

-- Re-enable foreign key checks and triggers after data load
SET FOREIGN_KEY_CHECKS = 1;
SET TRIGGER_DISABLED = 0; 