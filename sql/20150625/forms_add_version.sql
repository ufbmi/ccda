ALTER TABLE `forms`  ADD `version` VARCHAR(9) NOT NULL DEFAULT '0.0.0' AFTER `previous_forms_id`;
