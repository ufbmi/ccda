INSERT INTO `questions` (`id`, `sections_id`, `next_questions_id`, `previous_questions_id`, `is_required`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES
(NULL,	45,	NULL,	NULL,	0,	0,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	1,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	2,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	3,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	4,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	5,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	6,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	7,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	8,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	9,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00'),
(NULL,	45,	NULL,	NULL,	0,	10,	NOW(),	'0000-00-00 00:00:00',	'0000-00-00 00:00:00');

UPDATE `preferences_text` SET
`languages_id` = NULL
WHERE ((`id` = '2486') OR (`id` = '2485') OR (`id` = '2484') OR (`id` = '2483') OR (`id` = '2482') OR (`id` = '2481') OR (`id` = '2480') OR (`id` = '2479') OR (`id` = '2478') OR (`id` = '2477') OR (`id` = '2476'));

INSERT INTO `preferences_text` (`id`, `languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES
(NULL,	2,	'Do you feel sure about what to choose? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	222,	NULL),
(NULL,	2,	'Are you clear about the best choice for you? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	221,	NULL),
(NULL,	2,	'¿Ha recibido suficientes consejos para elegir una opción?',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	220,	NULL),
(NULL,	2,	'¿Está decidiendo sin ninguna presión de otros?',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	219,	NULL),
(NULL,	2,	'¿Cuenta con suficiente apoyo de otros para elegir una opción?',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	218,	NULL),
(NULL,	2,	'Are you clear about which risks and side effects matter most to you? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	217,	NULL),
(NULL,	2,	'Are you clear about which benefits matter most to you? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	216,	NULL),
(NULL,	2,	'Do you know the risks and side effects of each option? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	215,	NULL),
(NULL,	2,	'Do you know the benefits of each option? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	214,	NULL),
(NULL,	2,	'Do you know which options are available to you? [sic]',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	213,	NULL),
(NULL,	2,	'',	'',	'',	'',	'',	NULL,	NULL,	NULL,	NULL,	212,	NULL);

INSERT INTO `preferences_types` (`id`, `lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	222),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	221),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	220),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	219),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	218),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	217),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	216),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	215),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	214),
(NULL,	8,	NULL,	NULL,	NULL,	NULL,	213),
(NULL,	10,	NULL,	NULL,	NULL,	NULL,	212);

INSERT INTO `preferences_options` (`id`, `lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	222),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	221),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	220),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	219),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	218),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	217),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	216),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	215),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	214),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	213),
(NULL,	2,	NULL,	'matrix',	NULL,	NULL,	NULL,	NULL,	212);

CREATE PROCEDURE `getResponsesForAll` ()
SELECT
     az.passid AS subject_id,
     spt.title AS section,
     qpt.title AS question,
     apt.title AS answer_title,
     apt.description AS answer_value,
     r.free_text AS free_text,
     r.created_at
FROM
     responses AS r
        JOIN
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=r.languages_id
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=r.languages_id
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=r.languages_id
        JOIN
     sessions AS s ON r.sessions_id=s.id
        JOIN
     authorization as az ON s.id=az.sessions_id;

DROP PROCEDURE `getAnswers`;
