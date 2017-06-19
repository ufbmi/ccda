ALTER TABLE `preferences_text`
CHANGE `title` `title` text COLLATE 'latin1_swedish_ci' NOT NULL AFTER `languages_id`;
