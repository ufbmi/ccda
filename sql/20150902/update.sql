DELIMITER ;;
CREATE PROCEDURE `getObjectByObjectId_adminer_55e75c871d688` (IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `object_id` bigint)
BEGIN
DECLARE object_id_column TEXT;
DECLARE next_object_column TEXT;
DECLARE previous_object_column TEXT;

DECLARE title_field TEXT DEFAULT 'pt.title';
DECLARE description_field TEXT DEFAULT 'pt.description';
DECLARE placeholder_field TEXT DEFAULT 'pt.placeholder';
DECLARE default_field TEXT DEFAULT 'pt.default';

IF (object_type = 'projects')
THEN
    SET placeholder_field = 'pt.placeholder AS begin';
END IF;

IF (object_type = 'forms') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'sections') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'answers') THEN
    SET title_field = 'pt.title AS display';
    SET description_field = 'pt.description AS value';
END IF;

SET object_id_column = CONCAT(object_type,'_id');
SET next_object_column = CONCAT('next_',object_type,'_id');
SET previous_object_column = CONCAT('previous_',object_type,'_id');

SET @sql_command = "SELECT object.id";

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command,",object.",previous_object_column,",object.",next_object_column,",object.sort_order");
END IF;

IF (object_type = 'forms') THEN
    SET @sql_command = CONCAT(@sql_command, ",version");
END IF;

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label,
    pt.languages_id
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.id='",object_id,"' AND object.deleted_at='",deleted_at,"'");

IF (languages_id != '0') THEN
    SET @sql_command = CONCAT(@sql_command," AND pt.languages_id='",languages_id,"'");
END IF;

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END;;
DELIMITER ;
DROP PROCEDURE `getObjectByObjectId_adminer_55e75c871d688`;
DROP PROCEDURE `getObjectByObjectId`;
DELIMITER ;;
CREATE PROCEDURE `getObjectByObjectId` (IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `object_id` bigint)
BEGIN
DECLARE object_id_column TEXT;
DECLARE next_object_column TEXT;
DECLARE previous_object_column TEXT;

DECLARE title_field TEXT DEFAULT 'pt.title';
DECLARE description_field TEXT DEFAULT 'pt.description';
DECLARE placeholder_field TEXT DEFAULT 'pt.placeholder';
DECLARE default_field TEXT DEFAULT 'pt.default';

IF (object_type = 'projects')
THEN
    SET placeholder_field = 'pt.placeholder AS begin';
END IF;

IF (object_type = 'forms') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'sections') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'answers') THEN
    SET title_field = 'pt.title AS display';
    SET description_field = 'pt.description AS value';
END IF;

SET object_id_column = CONCAT(object_type,'_id');
SET next_object_column = CONCAT('next_',object_type,'_id');
SET previous_object_column = CONCAT('previous_',object_type,'_id');

SET @sql_command = "SELECT object.id";

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command,",object.",previous_object_column,",object.",next_object_column,",object.sort_order");
END IF;

IF (object_type = 'forms') THEN
    SET @sql_command = CONCAT(@sql_command, ",version");
END IF;

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label,
    pt.languages_id
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.id='",object_id,"' AND object.deleted_at='",deleted_at,"'");

IF (languages_id != '0') THEN
    SET @sql_command = CONCAT(@sql_command," AND pt.languages_id='",languages_id,"'");
END IF;

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `getObjectByParentId_adminer_55e75cbdf2f6a` (IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `parent_type` text, IN `parent_id` bigint)
BEGIN
DECLARE parent_id_column TEXT;
DECLARE object_id_column TEXT;
DECLARE next_object_column TEXT;
DECLARE previous_object_column TEXT;

DECLARE title_field TEXT DEFAULT 'pt.title';
DECLARE description_field TEXT DEFAULT 'pt.description';
DECLARE placeholder_field TEXT DEFAULT 'pt.placeholder';
DECLARE default_field TEXT DEFAULT 'pt.default';

SET parent_id_column = CONCAT(parent_type,'_id');
SET object_id_column = CONCAT(object_type,'_id');
SET next_object_column = CONCAT('next_',object_type,'_id');
SET previous_object_column = CONCAT('previous_',object_type,'_id');

IF (object_type = 'projects')
THEN
    SET placeholder_field = 'pt.placeholder AS begin';
END IF;

IF (object_type = 'forms') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'sections') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'answers') THEN
    SET title_field = 'pt.title AS display';
    SET description_field = 'pt.description AS value';
END IF;

SET @sql_command = "SELECT object.id";

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command,",object.",previous_object_column,",object.",next_object_column,",object.sort_order");
END IF;

IF (object_type = 'forms') THEN
    SET @sql_command = CONCAT(@sql_command, ",version");
END IF;

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label,
    pt.languages_id
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.",parent_id_column,"='",parent_id,"' AND object.deleted_at='",deleted_at,"'");

IF (languages_id != '0') THEN
    SET @sql_command = CONCAT(@sql_command," AND pt.languages_id='",languages_id,"'");
END IF;

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END;;
DELIMITER ;
DROP PROCEDURE `getObjectByParentId_adminer_55e75cbdf2f6a`;
DROP PROCEDURE `getObjectByParentId`;
DELIMITER ;;
CREATE PROCEDURE `getObjectByParentId` (IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `parent_type` text, IN `parent_id` bigint)
BEGIN
DECLARE parent_id_column TEXT;
DECLARE object_id_column TEXT;
DECLARE next_object_column TEXT;
DECLARE previous_object_column TEXT;

DECLARE title_field TEXT DEFAULT 'pt.title';
DECLARE description_field TEXT DEFAULT 'pt.description';
DECLARE placeholder_field TEXT DEFAULT 'pt.placeholder';
DECLARE default_field TEXT DEFAULT 'pt.default';

SET parent_id_column = CONCAT(parent_type,'_id');
SET object_id_column = CONCAT(object_type,'_id');
SET next_object_column = CONCAT('next_',object_type,'_id');
SET previous_object_column = CONCAT('previous_',object_type,'_id');

IF (object_type = 'projects')
THEN
    SET placeholder_field = 'pt.placeholder AS begin';
END IF;

IF (object_type = 'forms') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'sections') THEN
    SET placeholder_field = 'pt.placeholder AS finish';
    SET default_field = 'pt.default AS begin';
END IF;

IF (object_type = 'answers') THEN
    SET title_field = 'pt.title AS display';
    SET description_field = 'pt.description AS value';
END IF;

SET @sql_command = "SELECT object.id";

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command,",object.",previous_object_column,",object.",next_object_column,",object.sort_order");
END IF;

IF (object_type = 'forms') THEN
    SET @sql_command = CONCAT(@sql_command, ",version");
END IF;

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label,
    pt.languages_id
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.",parent_id_column,"='",parent_id,"' AND object.deleted_at='",deleted_at,"'");

IF (languages_id != '0') THEN
    SET @sql_command = CONCAT(@sql_command," AND pt.languages_id='",languages_id,"'");
END IF;

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END;;
DELIMITER ;

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

