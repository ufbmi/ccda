--
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.5/01-unhyphenate-a-word.sql
--
UPDATE `preferences_text` SET `title` = 'Extremadamente' WHERE `id` = '2930';
--
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.5/99_bump_version_number.sql
--
update forms set version='0.13.5' where 1=1;

