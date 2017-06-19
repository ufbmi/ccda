INSERT INTO `answers` (`questions_id`, `next_answers_id`, `previous_answers_id`, `previous_questions_id`, `next_questions_id`, `sort_order`, `created_at`, `updated_at`, `deleted_at`)
VALUES (??questions_id??, NULL, NULL, NULL, NULL, '0', now(), '0000-00-00 00:00:00', '0000-00-00 00:00:00');

INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`)
VALUES ('1', 'Text', 'Value', '', '', '', NULL, NULL, NULL, NULL, NULL, ??answers_id??);
