ALTER TABLE `lu_options`  ADD `parameter` TEXT NOT NULL AFTER `title`;
ALTER TABLE `lu_options` CHANGE `parameter` `parameter` ENUM('display') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
ALTER TABLE `lu_options` CHANGE `parameter` `parameter` ENUM('display','width','rows','cols','max','min') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
ALTER TABLE `lu_options` CHANGE `title` `value` VARCHAR(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
ALTER TABLE DROP COLUMN `value`;

ALTER TABLE `lu_options` CHANGE `parameter` `parameter` ENUM('display','width','rows','cols','max','min','headers') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;