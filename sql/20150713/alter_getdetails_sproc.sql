DELIMITER ;;
CREATE PROCEDURE `getDetails_adminer_55a3f90e88157` (IN `object_id` bigint, IN `object_type` text, IN `languages_id` bigint)
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
DROP PROCEDURE `getDetails_adminer_55a3f90e88157`;
DROP PROCEDURE `getDetails`;
DELIMITER ;;
CREATE PROCEDURE `getDetails` (IN `object_id` bigint, IN `object_type` text, IN `languages_id` bigint)
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
