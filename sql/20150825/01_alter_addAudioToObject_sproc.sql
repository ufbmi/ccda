DELIMITER ;;
CREATE PROCEDURE `addAudioToObject_adminer_55dc81549838b` (IN `object_type` text, IN `object_id` bigint, IN `audio_src_spanish` text, IN `audio_src_english` text, IN `audio_autoplay` text, IN `audio_preload` text, IN `audio_controls` text, IN `audio_volume` text)
BEGIN

DECLARE object_insert TEXT;
DECLARE autoplay INT;
DECLARE controls INT;
DECLARE preload INT;
DECLARE volume INT;
DECLARE source INT;

IF (object_type = 'sites') THEN
    SET object_insert = CONCAT(object_id,",NULL,NULL,NULL,NULL");
    SET autoplay = 37;
    SET controls = 35;
    SET preload = 36;
    SET volume = 39;
    SET source = 34;
END IF;

IF (object_type = 'projects') THEN
    SET object_insert = CONCAT("NULL,",object_id,",NULL,NULL,NULL");
    SET autoplay = 18;
    SET controls = 19;
    SET preload = 20;
    SET volume = 23;
    SET source = 14;
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
DELIMITER ;
DROP PROCEDURE `addAudioToObject_adminer_55dc81549838b`;
DROP PROCEDURE `addAudioToObject`;
DELIMITER ;;
CREATE PROCEDURE `addAudioToObject` (IN `object_type` text, IN `object_id` bigint, IN `audio_src_spanish` text, IN `audio_src_english` text, IN `audio_autoplay` text, IN `audio_preload` text, IN `audio_controls` text, IN `audio_volume` text)
BEGIN

DECLARE object_insert TEXT;
DECLARE autoplay INT;
DECLARE controls INT;
DECLARE preload INT;
DECLARE volume INT;
DECLARE source INT;

IF (object_type = 'sites') THEN
    SET object_insert = CONCAT(object_id,",NULL,NULL,NULL,NULL");
    SET autoplay = 37;
    SET controls = 35;
    SET preload = 36;
    SET volume = 39;
    SET source = 34;
END IF;

IF (object_type = 'projects') THEN
    SET object_insert = CONCAT("NULL,",object_id,",NULL,NULL,NULL");
    SET autoplay = 18;
    SET controls = 19;
    SET preload = 20;
    SET volume = 23;
    SET source = 14;
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
DELIMITER ;
