ALTER TABLE `preferences_options`
ADD `answers_id` bigint NULL;

ALTER TABLE `preferences_options`
ADD FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
