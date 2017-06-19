DELIMITER ;;
CREATE PROCEDURE `createNewObject_adminer_55e7ffe0b5377` (IN `object_type` text, IN `parent_id` bigint, IN `object_title_english` text, IN `object_description_english` text, IN `object_instructions_english` text, IN `object_title_spanish` text, IN `object_description_spanish` text, IN `object_instructions_spanish` text, IN `object_types_id` bigint, IN `object_sort_order` int, IN `object_options_display` int, IN `object_options_value` text)
BEGIN

DECLARE new_object_id BIGINT;
DECLARE object_insert TEXT;
DECLARE placeholder_english TEXT DEFAULT '';
DECLARE placeholder_spanish TEXT DEFAULT '';
DECLARE default_english TEXT DEFAULT '';
DECLARE default_spanish TEXT DEFAULT '';

IF (object_type = 'forms') THEN
    SET @insert_query = CONCAT("INSERT INTO forms (projects_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

IF (object_type = 'sections') THEN
    SET @insert_query = CONCAT("INSERT INTO sections (forms_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");

    SET placeholder_english = 'Next';
    SET placeholder_spanish = 'Siguiente';
    SET default_english = 'Previous';
    SET default_spanish = 'Anterior';
END IF;

IF (object_type = 'questions') THEN
    SET @insert_query = CONCAT("INSERT INTO questions (sections_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

IF (object_type = 'answers') THEN
    SET @insert_query = CONCAT("INSERT INTO answers (questions_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

PREPARE stmt FROM @insert_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET new_object_id = LAST_INSERT_ID();

IF (object_type = 'forms') THEN
    SET object_insert = CONCAT("NULL,NULL,",new_object_id,",NULL,NULL,NULL");
END IF;

IF (object_type = 'sections') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,",new_object_id,",NULL,NULL");
END IF;

IF (object_type = 'questions') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,",new_object_id,",NULL");
END IF;

IF (object_type = 'answers') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,NULL,",new_object_id);
END IF;

SET @ptext_query = CONCAT("INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES (1,'",object_title_english,"', '",object_description_english,"', '",object_instructions_english,"', '",placeholder_english,"', '",default_english,"', '',",object_insert,")");
PREPARE stmt FROM @ptext_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @ptext_query = CONCAT("INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES (2,'",object_title_spanish,"', '",object_description_spanish,"', '",object_instructions_spanish,"', '",placeholder_spanish,"', '",default_spanish,"', '',",object_insert,")");
PREPARE stmt FROM @ptext_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

IF (object_types_id) THEN
    SET @ptypes_query = CONCAT("INSERT INTO `preferences_types` (`lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES ('",object_types_id,"',",object_insert,")");
    PREPARE stmt FROM @ptypes_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

IF (object_options_display) THEN
    SET @poptions_query = CONCAT("INSERT INTO `preferences_options` (`lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES ('",object_options_display,"', NULL, '",object_options_value,"',",object_insert,")");
    PREPARE stmt FROM @poptions_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

END;;
DELIMITER ;
DROP PROCEDURE `createNewObject_adminer_55e7ffe0b5377`;
DROP PROCEDURE `createNewObject`;
DELIMITER ;;
CREATE PROCEDURE `createNewObject` (IN `object_type` text, IN `parent_id` bigint, IN `object_title_english` text, IN `object_description_english` text, IN `object_instructions_english` text, IN `object_title_spanish` text, IN `object_description_spanish` text, IN `object_instructions_spanish` text, IN `object_types_id` bigint, IN `object_sort_order` int, IN `object_options_display` int, IN `object_options_value` text)
BEGIN

DECLARE new_object_id BIGINT;
DECLARE object_insert TEXT;
DECLARE placeholder_english TEXT DEFAULT '';
DECLARE placeholder_spanish TEXT DEFAULT '';
DECLARE default_english TEXT DEFAULT '';
DECLARE default_spanish TEXT DEFAULT '';

IF (object_type = 'forms') THEN
    SET @insert_query = CONCAT("INSERT INTO forms (projects_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

IF (object_type = 'sections') THEN
    SET @insert_query = CONCAT("INSERT INTO sections (forms_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");

    SET placeholder_english = 'Next';
    SET placeholder_spanish = 'Siguiente';
    SET default_english = 'Previous';
    SET default_spanish = 'Anterior';
END IF;

IF (object_type = 'questions') THEN
    SET @insert_query = CONCAT("INSERT INTO questions (sections_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

IF (object_type = 'answers') THEN
    SET @insert_query = CONCAT("INSERT INTO answers (questions_id,sort_order) VALUES ('",parent_id,"','",object_sort_order,"')");
END IF;

PREPARE stmt FROM @insert_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET new_object_id = LAST_INSERT_ID();

IF (object_type = 'forms') THEN
    SET object_insert = CONCAT("NULL,NULL,",new_object_id,",NULL,NULL,NULL");
END IF;

IF (object_type = 'sections') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,",new_object_id,",NULL,NULL");
END IF;

IF (object_type = 'questions') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,",new_object_id,",NULL");
END IF;

IF (object_type = 'answers') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,NULL,",new_object_id);
END IF;

SET @ptext_query = CONCAT("INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES (1,'",object_title_english,"', '",object_description_english,"', '",object_instructions_english,"', '",placeholder_english,"', '",default_english,"', '',",object_insert,")");
PREPARE stmt FROM @ptext_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @ptext_query = CONCAT("INSERT INTO `preferences_text` (`languages_id`, `title`, `description`, `instructions`, `placeholder`, `default`, `object_label`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES (2,'",object_title_spanish,"', '",object_description_spanish,"', '",object_instructions_spanish,"', '",placeholder_spanish,"', '",default_spanish,"', '',",object_insert,")");
PREPARE stmt FROM @ptext_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

IF (object_types_id) THEN
    SET @ptypes_query = CONCAT("INSERT INTO `preferences_types` (`lu_types_id`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES ('",object_types_id,"',",object_insert,")");
    PREPARE stmt FROM @ptypes_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

IF (object_options_display) THEN
    SET @poptions_query = CONCAT("INSERT INTO `preferences_options` (`lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`, `answers_id`) VALUES ('",object_options_display,"', NULL, '",object_options_value,"',",object_insert,")");
    PREPARE stmt FROM @poptions_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END IF;

END;;
DELIMITER ;
