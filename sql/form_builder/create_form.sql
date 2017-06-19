INSERT INTO `forms` (`id`, `projects_id`, `next_forms_id`, `previous_forms_id`, `version`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
(NULL,	1,	NULL,	NULL,	'0.7.1',	0,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00');

INSERT INTO `preferences_types` (`id`, `lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES
(NULL,	3,	NULL,	NULL,	??forms_id??,	NULL,	NULL);

INSERT INTO `preferences_text` (`id`, `languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES
(NULL,	1,	'Decision Conflict Scale',	'',	'',	'Finished',	'Begin',	NULL,	NULL,	??forms_id??,	NULL,	NULL,	NULL);
