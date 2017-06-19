UPDATE `questions` SET
`id` = '173',
`sections_id` = '34',
`next_questions_id` = NULL,
`previous_questions_id` = NULL,
`is_required` = '0',
`sort_order` = '0',
`created_at` = '2015-06-12 19:08:19',
`updated_at` = '0000-00-00 00:00:00',
`deleted_at` = '0000-00-00 00:00:00'
WHERE `id` = '173';

UPDATE `preferences_types` SET `id` = '302', `lu_types_id` = '20', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '173', `answers_id` = NULL WHERE `questions_id` = '173' AND `id` = '302';

DELETE FROM `preferences_options` WHERE `questions_id` = '173' AND ((`id` = '452'));

INSERT INTO `lu_types` (`value`, `parameter`, `category`)
VALUES ('read_from_api', 1, 6);

UPDATE `preferences_types` SET `id` = '302', `lu_types_id` = '24', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '173', `answers_id` = NULL WHERE `questions_id` = '173' AND `id` = '302';
