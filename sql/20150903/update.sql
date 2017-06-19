UPDATE `preferences_text` SET `id` = '4488', `languages_id` = '2', `title` = 'No Hispano o Latino', `description` = 'not_hispanic_or_latino', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '1983' WHERE `id` IN (4488,4487,4486,4485) AND `id` = '4488';
UPDATE `preferences_text` SET `id` = '4487', `languages_id` = '1', `title` = 'Not Hispanic or Latino', `description` = 'not_hispanic_or_latino', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '1983' WHERE `id` IN (4488,4487,4486,4485) AND `id` = '4487';
UPDATE `preferences_text` SET `id` = '4486', `languages_id` = '2', `title` = 'Hispano o Latino', `description` = 'hispanic_or_latino', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '1982' WHERE `id` IN (4488,4487,4486,4485) AND `id` = '4486';
UPDATE `preferences_text` SET `id` = '4485', `languages_id` = '1', `title` = 'Hispanic or Latino', `description` = 'hispanic_or_latino', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '1982' WHERE `id` IN (4488,4487,4486,4485) AND `id` = '4485';

UPDATE `preferences_options` SET
`id` = '1043',
`lu_options_id` = '2',
`languages_id` = NULL,
`value` = '',
`sites_id` = NULL,
`projects_id` = NULL,
`forms_id` = NULL,
`sections_id` = NULL,
`questions_id` = '468',
`answers_id` = NULL
WHERE `id` = '1043';

UPDATE `preferences_text` SET `id` = '49', `languages_id` = '1', `title` = 'Which one of the following would you say is your race?', `description` = '', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '15', `answers_id` = NULL WHERE `questions_id` = '15' AND `id` = '49';
UPDATE `preferences_text` SET `id` = '1262', `languages_id` = '2', `title` = '¿Cuál es su raza?', `description` = '', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '15', `answers_id` = NULL WHERE `questions_id` = '15' AND `id` = '1262';

DELETE FROM `preferences_text`
WHERE `answers_id` >= '25' AND `answers_id` <= '30' AND ((`id` = '55') OR (`id` = '1268'));
DELETE FROM `answers`
WHERE `questions_id` = '15' AND ((`id` = '30'));

UPDATE `questions` SET
`id` = '469',
`sections_id` = '1',
`next_questions_id` = NULL,
`previous_questions_id` = NULL,
`is_required` = '0',
`sort_order` = '10',
`created_at` = '2015-09-03 08:14:09',
`updated_at` = '0000-00-00 00:00:00',
`deleted_at` = '2015-09-03 11:20:49'
WHERE `id` = '469';

UPDATE `preferences_text` SET `id` = '50', `languages_id` = '1', `title` = 'Native Hawaiian or Other Pacific Islander', `description` = 'native_hawaiian_or_other_pacific_islander', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '25' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '50';
UPDATE `preferences_text` SET `id` = '1263', `languages_id` = '2', `title` = 'Nativo de Hawai u otras islas del Pacífico', `description` = 'native_hawaiian_or_other_pacific_islander', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '25' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '1263';
UPDATE `preferences_text` SET `id` = '51', `languages_id` = '1', `title` = 'White', `description` = 'white', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '26' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '51';
UPDATE `preferences_text` SET `id` = '1264', `languages_id` = '2', `title` = 'Blanca', `description` = 'white', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '26' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '1264';
UPDATE `preferences_text` SET `id` = '52', `languages_id` = '1', `title` = 'Black or African American', `description` = 'black_or_african_american', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '27' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '52';
UPDATE `preferences_text` SET `id` = '1265', `languages_id` = '2', `title` = 'Negra o Afroamericana', `description` = 'black_or_african_american', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '27' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '1265';
UPDATE `preferences_text` SET `id` = '53', `languages_id` = '1', `title` = 'Asian', `description` = 'asian', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '28' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '53';
UPDATE `preferences_text` SET `id` = '1266', `languages_id` = '2', `title` = 'Asiática', `description` = 'asian', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '28' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '1266';
UPDATE `preferences_text` SET `id` = '54', `languages_id` = '1', `title` = 'American Indian or Alaska Native', `description` = 'american_indian_or_alaska_native', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '29' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '54';
UPDATE `preferences_text` SET `id` = '1267', `languages_id` = '2', `title` = 'Indio o Alaska Native American', `description` = 'american_indian_or_alaska_native', `instructions` = '', `placeholder` = '', `default` = '', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = NULL, `answers_id` = '29' WHERE `answers_id` >= '25' AND `answers_id` <= '29' AND `id` = '1267';

UPDATE `answers` SET `id` = '25', `questions_id` = '15', `next_answers_id` = NULL, `previous_answers_id` = NULL, `sort_order` = '3', `created_at` = '2015-05-29 03:59:18', `updated_at` = '0000-00-00 00:00:00', `deleted_at` = '0000-00-00 00:00:00' WHERE `questions_id` = '15' AND `id` = '25';
UPDATE `answers` SET `id` = '26', `questions_id` = '15', `next_answers_id` = NULL, `previous_answers_id` = NULL, `sort_order` = '4', `created_at` = '2015-05-29 03:59:18', `updated_at` = '0000-00-00 00:00:00', `deleted_at` = '0000-00-00 00:00:00' WHERE `questions_id` = '15' AND `id` = '26';
UPDATE `answers` SET `id` = '27', `questions_id` = '15', `next_answers_id` = NULL, `previous_answers_id` = NULL, `sort_order` = '2', `created_at` = '2015-05-29 03:59:24', `updated_at` = '0000-00-00 00:00:00', `deleted_at` = '0000-00-00 00:00:00' WHERE `questions_id` = '15' AND `id` = '27';
UPDATE `answers` SET `id` = '28', `questions_id` = '15', `next_answers_id` = NULL, `previous_answers_id` = NULL, `sort_order` = '1', `created_at` = '2015-05-29 03:59:24', `updated_at` = '0000-00-00 00:00:00', `deleted_at` = '0000-00-00 00:00:00' WHERE `questions_id` = '15' AND `id` = '28';
UPDATE `answers` SET `id` = '29', `questions_id` = '15', `next_answers_id` = NULL, `previous_answers_id` = NULL, `sort_order` = '0', `created_at` = '2015-05-29 03:59:28', `updated_at` = '0000-00-00 00:00:00', `deleted_at` = '0000-00-00 00:00:00' WHERE `questions_id` = '15' AND `id` = '29';

