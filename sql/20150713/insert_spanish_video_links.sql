INSERT INTO `preferences_options` (`id`, `lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES
(278,	6,	2,	'/videos/spanish/ccdaa_spanish_1_through_3.mov',	NULL,	NULL,	NULL,	NULL,	127),
(279,	6,	2,	'/videos/spanish/ccdaa_spanish_4.mov',	NULL,	NULL,	NULL,	NULL,	128),
(280,	6,	2,	'/videos/spanish/ccdaa_spanish_5.mov',	NULL,	NULL,	NULL,	NULL,	129),
(281,	6,	2,	'/videos/spanish/ccdaa_spanish_6.mov',	NULL,	NULL,	NULL,	NULL,	130);

UPDATE `preferences_options` SET
`languages_id` = '1'
WHERE `lu_options_id` = '6' AND ((`id` = '113') OR (`id` = '121') OR (`id` = '126') OR (`id` = '131'));
