-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Fri Aug 14 19:12:48 2009
-- 


BEGIN TRANSACTION;

--
-- Table: keyword
--
DROP TABLE keyword;

CREATE TABLE keyword (
  id INTEGER PRIMARY KEY NOT NULL,
  keyword VARCHAR(255) NOT NULL,
  count INTEGER NOT NULL DEFAULT '0',
  created_date DATETIME NOT NULL,
  updated_date DATETIME NOT NULL
);

CREATE UNIQUE INDEX keyword_keyword ON keyword (keyword);

--
-- Table: comment
--
DROP TABLE comment;

CREATE TABLE comment (
  id INTEGER PRIMARY KEY NOT NULL,
  keyword INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,
  created_date DATETIME NOT NULL
);

CREATE INDEX comment_idx_keyword ON comment (keyword);

COMMIT;
