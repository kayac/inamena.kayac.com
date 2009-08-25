-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Tue Aug 11 18:05:24 2009
-- 


BEGIN TRANSACTION;

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

CREATE INDEX comment_idx_keyword_comment ON comment (keyword);

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

COMMIT;
