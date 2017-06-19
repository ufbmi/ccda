DROP PROCEDURE `getProjectData`;
DROP PROCEDURE `getQuestionsCountBySectionsId`;
DROP PROCEDURE `getQuestionDetailsByQuestionsId`;
DROP PROCEDURE `insertQuestionStep_01`;

DROP PROCEDURE `getProjectsByProjectsId`;

DROP PROCEDURE `getFormsByFormsId`;
DROP PROCEDURE `getFormsByProjectsId`;

DROP PROCEDURE `getSectionsBySectionsId`;
DROP PROCEDURE `getSectionsByFormsId`;

DROP PROCEDURE `getSectionsBySectionsId`;
DROP PROCEDURE `getSectionsByFormsId`;

DROP PROCEDURE `getQuestionsByQuestionsId`;
DROP PROCEDURE `getQuestionsBySectionsId`;

DROP PROCEDURE `getAnswersByAnswersId`;
DROP PROCEDURE `getAnswersByQuestionsId`;
--------------------------------------------------
DELIMITER ;;
CREATE PROCEDURE `getObjectDetails` (IN `object_id` bigint, IN `object_type` text, IN `languages_id` bigint)
BEGIN

DECLARE pt_object_type_id TEXT;
DECLARE po_object_type_id TEXT;

SET pt_object_type_id=CONCAT('pt.',object_type,'_id');
SET po_object_type_id=CONCAT('po.',object_type,'_id');

SET @query = CONCAT("SELECT CONCAT('types') AS from_table,lut.parameter, lut.value FROM preferences_types AS pt JOIN lu_types AS lut ON pt.lu_types_id=lut.id WHERE ",pt_object_type_id,"=",object_id," AND lut.category='",object_type,"' UNION SELECT CONCAT('options'),luo.parameter, po.value FROM preferences_options AS po JOIN lu_options AS luo ON po.lu_options_id=luo.id WHERE ",po_object_type_id,"=",object_id," AND luo.category='",object_type,"' AND (po.languages_id='",languages_id,"' OR po.languages_id IS NULL)");

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;;
DELIMITER ;
DROP PROCEDURE `getDetails`;
--------------------------------------------------
ALTER TABLE `answers`
DROP FOREIGN KEY `answers_ibfk_6`;

ALTER TABLE `answers`
DROP FOREIGN KEY `answers_ibfk_7`;

ALTER TABLE `answers`
DROP `previous_questions_id`,
DROP `next_questions_id`;
--------------------------------------------------
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
--------------------------------------------------
DROP PROCEDURE IF EXISTS `getObjectByParentId`;

CREATE PROCEDURE `getObjectByParentId`(IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `parent_type` text, IN `parent_id` bigint)
BEGIN
END;

DELIMITER ;;
CREATE PROCEDURE `getObjectByParentId_adminer_55d3ad4a2c651` (IN `deleted_at` text, IN `languages_id` bigint, IN `object_type` text, IN `parent_type` text, IN `parent_id` bigint)
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
    object.",parent_id_column,"='",parent_id,"' AND pt.languages_id='",languages_id,"' AND object.deleted_at='",deleted_at,"'");

IF (object_type != 'projects') THEN
    SET @sql_command = CONCAT(@sql_command," ORDER BY object.sort_order ASC");
END IF;

PREPARE stmt FROM @sql_command;
EXECUTE stmt;
END;;
DELIMITER ;
--------------------------------------------------
