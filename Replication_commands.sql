-- ============================================================
-- POSTGRESQL BACKUP AND DISASTER RECOVERY LAB
-- TASK 4 AND TASK 5
-- STREAMING REPLICATION
-- ============================================================


-- ============================================================
-- TASK 4: CREATE REPLICATION USER
-- ============================================================

-- Create a replication user.
-- Run this as a PostgreSQL administrator.

CREATE ROLE replicator
WITH REPLICATION
LOGIN
PASSWORD 'reppass';


-- Verify the replication user:
SELECT rolname, rolreplication, rolcanlogin
FROM pg_roles
WHERE rolname = 'replicator';


-- ============================================================
-- CONFIGURE pg_hba.conf
-- ============================================================

-- Add the following line to pg_hba.conf:
--
-- host replication replicator 127.0.0.1/32 scram-sha-256
--
-- If your assignment specifically requires md5, use:
--
-- host replication replicator 127.0.0.1/32 md5


-- Reload PostgreSQL:
--
-- sudo systemctl reload postgresql


-- ============================================================
-- CREATE THE STANDBY
-- ============================================================

-- Run this command in the terminal:
--
-- pg_basebackup -h 127.0.0.1 \
-- -U replicator \
-- -D ~/standby \
-- -R \
-- -P


-- The -R option creates the standby connection configuration.


-- ============================================================
-- START THE STANDBY
-- ============================================================

-- If the standby is on another machine, start PostgreSQL
-- on that standby machine.

-- If primary and standby are on the same computer,
-- the standby must use a different PostgreSQL port
-- from the primary.


-- ============================================================
-- TASK 5: CHECK REPLICATION HEALTH
-- ============================================================

-- Run this query on the PRIMARY server:

SELECT
    application_name,
    client_addr,
    state,
    sync_state,
    sent_lsn,
    write_lsn,
    flush_lsn,
    replay_lsn
FROM pg_stat_replication;


-- ============================================================
-- CHECK REPLICATION LAG
-- ============================================================

SELECT
    application_name,
    state,
    pg_size_pretty(
        pg_wal_lsn_diff(sent_lsn, replay_lsn)
    ) AS lag
FROM pg_stat_replication;


-- ============================================================
-- CHECK WHETHER THIS SERVER IS A STANDBY
-- ============================================================

SELECT pg_is_in_recovery();


-- On the PRIMARY server the result should normally be:
-- f
--
-- On the STANDBY server the result should normally be:
-- t


-- ============================================================
-- FINAL VERIFICATION
-- ============================================================

-- On the primary:
SELECT * FROM students;

-- Insert a test record:
-- INSERT INTO students (name, age, course)
-- VALUES ('Replication Test', 20, 'Software Development');

-- On the standby, check whether the record appears:
-- SELECT * FROM students;