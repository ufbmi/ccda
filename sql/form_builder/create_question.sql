INSERT INTO `questions` (`sections_id`, `next_questions_id`, `previous_questions_id`, `is_required`, `sort_order`, `created_at`, `updated_at`, `deleted_at`)
VALUES (??sections_id??, NULL, NULL, '0', '0', NOW(), '0000-00-00 00:00:00', '0000-00-00 00:00:00');

INSERT INTO `preferences_types` (`lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`)
VALUES (??lu_types_id??, NULL, NULL, NULL, NULL, ??questions_id??);

INSERT INTO `preferences_options` (`lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`)
VALUES ('2', NULL, '', NULL, NULL, NULL, NULL, ??questions_id??);

INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`)
VALUES ('1', 'Text', 'Description', '', '', '', NULL, NULL, NULL, NULL, ??questions_id??, NULL);
