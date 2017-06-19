USE `ccdaa`;
DROP procedure IF EXISTS `reportFormsAndSectionsByProjectsId`;

DELIMITER $$
USE `ccdaa`$$
CREATE DEFINER=`ccdaa`@`localhost` PROCEDURE `reportFormsAndSectionsByProjectsId`(IN `deleted_at` text, IN `languages_id` bigint, IN `object_id` bigint)
BEGIN

SELECT
    pt.title as form_title,
    pt_child.title as section_title
FROM
    forms AS object
        JOIN
    preferences_text AS pt ON object.id = pt.forms_id
            join
    sections as child ON object.id = child.forms_id
            Join
    preferences_text AS pt_child ON child.id = pt_child.sections_id

WHERE
    object.projects_id = object_id
        AND pt.languages_id = languages_id
        AND pt_child.languages_id = languages_id
        AND object.deleted_at = deleted_at
ORDER BY object.sort_order, child.sort_order ASC;

END$$

DELIMITER ;

