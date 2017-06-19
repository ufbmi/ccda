INSERT INTO `sections` (`id`, `forms_id`, `next_sections_id`, `previous_sections_id`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
(NULL,	??forms_id??,	NULL,	NULL,	0,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00');

INSERT INTO `preferences_types` (`id`, `lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES
(NULL,	4,	NULL,	NULL,	NULL,	??sections_id??,	NULL);

INSERT INTO `preferences_text` (`id`, `languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES
(NULL,	1,	'Title',	'Describe,	'',	'Done',	'',	NULL,	NULL,	NULL,	??sections_id??,	NULL,	NULL);
