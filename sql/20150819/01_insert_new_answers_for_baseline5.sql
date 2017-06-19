INSERT INTO `answers` (`id`, `questions_id`, `next_answers_id`, `previous_answers_id`, `sort_order`, `created_at`, `updated_at`, `deleted_at`)
VALUES ('1327', '5', NULL, NULL, '5', now(), '0000-00-00 00:00:00', '0000-00-00 00:00:00');

UPDATE `answers` SET
`id` = '14',
`questions_id` = '5',
`next_answers_id` = NULL,
`previous_answers_id` = NULL,
`sort_order` = '0',
`created_at` = '2015-05-29 02:27:11',
`updated_at` = '0000-00-00 00:00:00',
`deleted_at` = '2015-08-19 15:16:44'
WHERE `id` = '14';

INSERT INTO `preferences_text` (`id`, `languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES
(NULL,	1,	'Higher than College',	'higher_than_college',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	1327),
(NULL,	2,	'Superior a la universidad',	'higher_than_college',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	NULL,	1327);

UPDATE `answers` SET `id` = '15', `questions_id` = '5', `next_answers_id` = NULL, `previous_answers_id` = NULL, `sort_order` = '4', `created_at` = '2015-05-29 02:22:59', `updated_at` = '0000-00-00 00:00:00', `deleted_at` = '0000-00-00 00:00:00' WHERE `questions_id` = '5' AND `id` = '15';
