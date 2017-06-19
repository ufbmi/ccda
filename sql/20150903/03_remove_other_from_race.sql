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
