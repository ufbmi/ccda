UPDATE `preferences_types` SET
`id` = '234',
`lu_types_id` = '18',
`sites_id` = NULL,
`projects_id` = NULL,
`forms_id` = NULL,
`sections_id` = '33',
`questions_id` = NULL
WHERE `id` = '234';

UPDATE `preferences_types` SET
`id` = '235',
`lu_types_id` = '19',
`sites_id` = NULL,
`projects_id` = NULL,
`forms_id` = NULL,
`sections_id` = '34',
`questions_id` = NULL
WHERE `id` = '235';

DELETE FROM `preferences_types`
WHERE `sections_id` >= '21' AND `sections_id` <= '42' AND ((`id` = '236') OR (`id` = '237') OR (`id` = '238') OR (`id` = '239') OR (`id` = '240') OR (`id` = '241') OR (`id` = '187') OR (`id` = '188'));
