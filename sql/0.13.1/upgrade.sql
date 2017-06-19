-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.1/01_update_nextprevious_for_form_2.sql
-- 
UPDATE `forms` SET
`id` = '2',
`projects_id` = '1',
`next_forms_id` = '3',
`previous_forms_id` = '21',
`version` = '0.13.0',
`sort_order` = '5',
`created_at` = '2015-05-28 13:50:47',
`updated_at` = '0000-00-00 00:00:00',
`deleted_at` = '0000-00-00 00:00:00'
WHERE `id` = '2';

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.1/99_bump_version_number.sql
-- 
update forms set version='0.13.1' where 1=1;

