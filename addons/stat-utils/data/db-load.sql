-- init

.bail ON
.headers ON
.echo ON

-- drop tables

DROP TABLE IF EXISTS vi;
DROP TABLE IF EXISTS vt;
DROP TABLE IF EXISTS g;
DROP TABLE IF EXISTS v;
VACUUM;

-- create tables

CREATE TABLE vi (
  vn TEXT,
  level INTEGER,
  class TEXT,
  hp INTEGER,
  premium INTEGER,
  nation TEXT,
  vname TEXT);

CREATE TABLE vt (
  region TEXT,
  vn TEXT,
  topR REAL,
  topD REAL,
  topE REAL,
  topF REAL,
  topS REAL,
  topU REAL);

CREATE TABLE g (
  id INTEGER,
  created INTEGER,
  updated INTEGER,
  name TEXT,
  battles INTEGER,
  wins INTEGER,
  spotted INTEGER,
  hit_percent INTEGER,
  captured INTEGER,
  damage INTEGER,
  frags INTEGER,
  defence INTEGER);

CREATE TABLE v (
  id INTEGER,
  vn TEXT,
  vbattles INTEGER,
  vwins INTEGER,
  vdamage INTEGER,
  vfrags INTEGER,
  vspotted INTEGER,
  vsurvived INTEGER);

-- load data

.separator ;
.import 'data/_vinfo.csv' vi
.import 'data/_vtop.csv' vt
.import 'data/_global.csv' g
.import 'data/_vehicle.csv' v

-- create indices

CREATE UNIQUE INDEX IF NOT EXISTS ix_vi_vn ON vi (vn);
CREATE INDEX IF NOT EXISTS ix_vt_region_vn ON vt (region, vn);
CREATE UNIQUE INDEX IF NOT EXISTS ix_g_id ON g (id);
CREATE INDEX IF NOT EXISTS ix_v_id ON v (id);

-- delete header lines

DELETE FROM vi WHERE vn = 'vn';
DELETE FROM vt WHERE region = 'region';
DELETE FROM g WHERE id = 'id';
DELETE FROM v WHERE id = 'id';

-- update table structure

ALTER TABLE v ADD COLUMN R REAL DEFAULT NULL;
ALTER TABLE v ADD COLUMN D REAL DEFAULT NULL;
ALTER TABLE v ADD COLUMN E REAL DEFAULT NULL;
ALTER TABLE v ADD COLUMN F REAL DEFAULT NULL;
ALTER TABLE v ADD COLUMN S REAL DEFAULT NULL;
ALTER TABLE v ADD COLUMN U REAL DEFAULT NULL;

-- calculate

UPDATE v SET
  R = (SELECT 1.0*vwins/vbattles FROM vi WHERE vi.vn=v.vn),
  D = (SELECT 1.0*vdamage/vbattles FROM vi WHERE vi.vn=v.vn),
  E = (SELECT 1.0*vdamage/vbattles/hp FROM vi WHERE vi.vn=v.vn),
  F = (SELECT 1.0*vfrags/vbattles FROM vi WHERE vi.vn=v.vn),
  S = (SELECT 1.0*vspotted/vbattles FROM vi WHERE vi.vn=v.vn),
  U = (SELECT 1.0*vsurvived/vbattles FROM vi WHERE vi.vn=v.vn);

-- final

--VACUUM;
