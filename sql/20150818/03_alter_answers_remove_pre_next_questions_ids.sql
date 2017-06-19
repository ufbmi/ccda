ALTER TABLE `answers`
DROP FOREIGN KEY `answers_ibfk_6`;

ALTER TABLE `answers`
DROP FOREIGN KEY `answers_ibfk_7`;

ALTER TABLE `answers`
DROP `previous_questions_id`,
DROP `next_questions_id`;
