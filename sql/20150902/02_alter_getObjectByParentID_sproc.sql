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
