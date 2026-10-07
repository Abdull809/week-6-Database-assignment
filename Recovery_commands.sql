-- ============================================================
-- POSTGRESQL BACKUP AND DISASTER RECOVERY LAB
-- TASK 2 AND TASK 3
-- WAL ARCHIVING AND POINT-IN-TIME RECOVERY
-- ============================================================

-- ============================================================
-- TASK 2: WAL ARCHIVING
-- ============================================================

-- Check the current WAL level
SHOW wal_level;

-- Check whether WAL archiving is enabled
SHOW archive_mode;

-- Check the archive command
SHOW archive_command;

-- The following settings should be configured in
-- postgresql.conf:
--
-- wal_level = replica
-- archive_mode = on
-- archive_command = 'cp %p /var/lib/postgresql/wal_archive/%f'

-- Create the WAL archive directory in the Linux terminal:
--
-- sudo mkdir -p /var/lib/postgresql/wal_archive
--
-- sudo chown postgres:postgres /var/lib/postgresql/wal_archive

-- Restart PostgreSQL after changing postgresql.conf:
--
-- sudo systemctl restart postgresql

-- Create a physical base backup:
--
-- mkdir -p ~/backups/base
--
-- pg_basebackup -D ~/backups/base -Ft -z -Xs -P


-- ============================================================
-- TASK 3: POINT-IN-TIME RECOVERY
-- ============================================================

-- First record the current time BEFORE the simulated disaster.
SELECT now();

-- Check the students table:
SELECT * FROM students;

-- Simulate accidental data deletion:
-- DELETE FROM students;

-- Verify the deletion:
-- SELECT count(*) FROM students;


-- ============================================================
-- RECOVERY CONFIGURATION
-- ============================================================

-- Stop PostgreSQL before restoring the database:
--
-- sudo systemctl stop postgresql

-- Restore the base backup into a PostgreSQL data directory.
--
-- IMPORTANT:
-- The exact PostgreSQL data directory depends on the
-- PostgreSQL version and installation.


-- PostgreSQL 12+ uses recovery.signal to start recovery.
--
-- Create recovery.signal inside the restored data directory:
--
-- sudo touch /var/lib/postgresql/<VERSION>/main/recovery.signal


-- Add the following settings to postgresql.conf:
--
-- restore_command = 'cp /var/lib/postgresql/wal_archive/%f %p'
-- recovery_target_time = 'YYYY-MM-DD HH:MM:SS'
-- recovery_target_action = 'promote'


-- Start PostgreSQL:
--
-- sudo systemctl start postgresql


-- ============================================================
-- VERIFY RECOVERY
-- ============================================================

-- Connect to the database:
-- psql bootcamp

-- Check the students table:
SELECT * FROM students;

-- Count the recovered rows:
SELECT count(*) FROM students;

-- The students that existed before the accidental deletion
-- should be present again.