ALTER TABLE `lu_types`  ADD `parameter` TEXT NOT NULL AFTER `title`;
ALTER TABLE `lu_types` CHANGE `parameter` `parameter` ENUM('type') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;