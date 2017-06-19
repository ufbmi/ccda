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

ALTER TABLE `lu_options`
CHANGE `parameter` `parameter` enum('display','width','height','rows','cols','max','min','headers','isOpen','isDisabled','video_src','autoplay','loop','aspectRatio','resetAvailable','show_logic','scored_section','audio_src','controls','preload','volume') COLLATE 'latin1_swedish_ci' NOT NULL AFTER `id`;

DROP PROCEDURE IF EXISTS `addAudioToObject`;;
CREATE PROCEDURE `addAudioToObject`(IN `object_type` text, IN `object_id` bigint, IN `audio_src_spanish` text, IN `audio_src_english` text, IN `audio_autoplay` text, IN `audio_preload` text, IN `audio_controls` text, IN `audio_volume` text)
BEGIN

DECLARE object_insert TEXT;
DECLARE autoplay INT;
DECLARE controls INT;
DECLARE preload INT;
DECLARE volume INT;
DECLARE source INT;

IF (object_type = 'sites') THEN
    SET object_insert = CONCAT(object_id,",NULL,NULL,NULL,NULL");
    SET autoplay = 18;
    SET controls = 19;
    SET preload = 20;
    SET volume = 23;
    SET source = 14;
END IF;

IF (object_type = 'projects') THEN
    SET object_insert = CONCAT("NULL,",object_id,",NULL,NULL,NULL");
    SET autoplay = NULL;
    SET controls = NULL;
    SET preload = NULL;
    SET volume = NULL;
    SET source = NULL;
END IF;

IF (object_type = 'forms') THEN
    SET object_insert = CONCAT("NULL,NULL,",object_id,",NULL,NULL");
    SET autoplay = 33;
    SET controls = 32;
    SET preload = 31;
    SET volume = 30;
    SET source = 15;
END IF;

IF (object_type = 'sections') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,",object_id,",NULL");
    SET autoplay = 28;
    SET controls = 24;
    SET preload = 25;
    SET volume = 26;
    SET source = 16;
END IF;

IF (object_type = 'questions') THEN
    SET object_insert = CONCAT("NULL,NULL,NULL,NULL,",object_id);
    SET autoplay = 7;
    SET controls = 21;
    SET preload = 22;
    SET volume = 27;
    SET source = 17;
END IF;

SET @query = CONCAT("INSERT INTO `preferences_options` (`id`, `lu_options_id`, `languages_id`, `value`, `sites_id`, `projects_id`, `forms_id`, `sections_id`, `questions_id`) VALUES ");

SET @query = CONCAT(@query,"(NULL,",source,",1,'", audio_src_english,"',", object_insert, ")",",");
SET @query = CONCAT(@query,"(NULL,",source,",2,'", audio_src_spanish,"',", object_insert, ")",",");

SET @query = CONCAT(@query,"(NULL,",autoplay,",NULL,'",audio_autoplay,"',", object_insert, ")");
SET @query = CONCAT(@query,",");
SET @query = CONCAT(@query,"(NULL,",preload,",NULL,'",audio_preload,"',", object_insert, ")");
SET @query = CONCAT(@query,",");
SET @query = CONCAT(@query,"(NULL,",controls,",NULL,'",audio_controls,"',", object_insert, ")");
SET @query = CONCAT(@query,",");
SET @query = CONCAT(@query,"(NULL,",volume,",NULL,'",audio_volume,"',", object_insert, ")");

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;;

