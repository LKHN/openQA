PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;
CREATE TABLE job_state (id INTEGER PRIMARY KEY, name TEXT);
INSERT INTO "job_state" VALUES(1,'scheduled');
INSERT INTO "job_state" VALUES(2,'running');
INSERT INTO "job_state" VALUES(3,'stopped');
INSERT INTO "job_state" VALUES(4,'waiting');
INSERT INTO "job_state" VALUES(5,'done');
CREATE TABLE worker(
	id INTEGER PRIMARY KEY,
	host TEXT,
	port INTEGER,
	backend TEXT,
	UNIQUE(host, port)
);
INSERT INTO "worker" VALUES(0,NULL,NULL,NULL);
CREATE TABLE jobs (
	id INTEGER PRIMARY KEY,
	state INTEGER DEFAULT 1 REFERENCES job_state(id),
	priority INTEGER DEFAULT 50, -- 0-99
	result TEXT,
	worker INTEGER DEFAULT 0 REFERENCES worker(id) ON DELETE SET DEFAULT,
	start_date TIMESTAMP,
	finish_date TIMESTAMP
);
CREATE TABLE job_settings(
	jobid INTEGER REFERENCES jobs(id),
	key TEXT,
	value TEXT
);
COMMIT;
