-- Convert schema '/Users/typester/dev/Inamena/script/../sql/Inamena-Schema-2-MySQL.sql' to 'Inamena::Schema v2':;

BEGIN;

ALTER TABLE comment CHANGE COLUMN keyword keyword INTEGER unsigned NOT NULL;


COMMIT;

