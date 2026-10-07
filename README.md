# PostgreSQL Backup and Disaster Recovery Lab

## Objective

This project demonstrates PostgreSQL backup, WAL archiving, Point-in-Time Recovery (PITR), and streaming replication.

## Tasks

### Task 1: Logical Backup

Create a logical backup of the PostgreSQL database using `pg_dump`.

### Task 2: WAL Archiving and Base Backup

Configure PostgreSQL WAL archiving and create a physical base backup using `pg_basebackup`.

### Task 3: Point-in-Time Recovery

Recover the database to a specific point in time after simulated data loss.

### Task 4: Streaming Replication

Create a replication user and configure a standby PostgreSQL server.

### Task 5: Monitor Replication

Check the replication status and monitor replication lag.

## Tools Used

- PostgreSQL
- pg_dump
- pg_restore
- pg_basebackup
- WAL Archiving
- Point-in-Time Recovery (PITR)
- Streaming Replication
- GitHub

## Learning Outcomes

By completing this lab, I learned how to:

1. Create and verify PostgreSQL backups.
2. Configure WAL archiving.
3. Perform Point-in-Time Recovery.
4. Create a PostgreSQL standby server.
5. Monitor streaming replication.