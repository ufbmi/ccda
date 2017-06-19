ALTER TABLE `preferences_styles`
ADD `answers_id` bigint NULL;

ALTER TABLE `preferences_styles`
ADD FOREIGN KEY (`answers_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
