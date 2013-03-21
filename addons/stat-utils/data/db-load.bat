@echo off
type "db-load.sql" | sqlite3 players.db
