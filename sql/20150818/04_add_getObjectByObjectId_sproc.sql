DROP PROCEDURE IF EXISTS `getObjectByObjectId`;

CREATE PROCEDURE `getObjectByObjectId`(IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `object_id` bigint)
BEGIN
END;

DELIMITER ;;
CREATE PROCEDURE `getObjectByObjectId_adminer_55d3ada5845f4` (IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `object_id` bigint)
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

SET @sql_command = CONCAT(@sql_command,",",
    title_field,",",
    description_field,",
    pt.instructions,",
    placeholder_field,",",
    default_field,",","
    pt.object_label
FROM
    ",object_type," as object
JOIN
    preferences_text AS pt ON object.id=pt.",object_id_column,"
WHERE
    object.id='",object_id,"' AND pt.languages_id='",languages_id,"' AND object.deleted_at='",deleted_at,"'");

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END;;
DELIMITER ;
