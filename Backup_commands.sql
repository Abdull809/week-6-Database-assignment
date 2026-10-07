-- ============================================================
-- POSTGRESQL BACKUP AND DISASTER RECOVERY LAB
-- TASK 1: LOGICAL BACKUP
-- ============================================================

-- Check PostgreSQL version
SELECT version();

-- Check the current database
SELECT current_database();

-- List tables
\dt

-- Display students table
SELECT * FROM students;

-- ============================================================
-- TERMINAL COMMANDS
-- ============================================================

-- Create a backup directory:
-- mkdir -p ~/backups

-- Create a logical backup:
-- pg_dump -Fc -f ~/backups/bootcamp.dump bootcamp

-- List the contents of the backup:
-- pg_restore --list ~/backups/bootcamp.dump

-- Create a test database:
-- createdb bootcamp_check

-- Restore the backup:
-- pg_restore -d bootcamp_check ~/backups/bootcamp.dump

-- Connect to the restored database:
-- psql bootcamp_check

-- Verify the restored table:
-- SELECT * FROM students;