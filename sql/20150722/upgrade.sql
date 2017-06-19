
DELIMITER ;;
CREATE PROCEDURE `getAnswers_adminer_55b003bc9e71f` (IN `sessions_id` bigint)
SELECT
     spt.title AS section,
     r.sections_id,
     qpt.title AS question,
     r.questions_id,
     apt.title AS answer_title,
     apt.description AS answer_value,
     r.free_text AS free_text,
     r.answers_id,
     r.created_at
FROM
     responses AS r
        JOIN
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=r.languages_id
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=r.languages_id
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=r.languages_id
        JOIN
     sessions AS s ON r.sessions_id=s.id
WHERE
     r.sessions_id=sessions_id;;
DELIMITER ;
DROP PROCEDURE `getAnswers_adminer_55b003bc9e71f`;
DROP PROCEDURE `getAnswers`;
DELIMITER ;;
CREATE PROCEDURE `getAnswers` (IN `sessions_id` bigint)
SELECT
     spt.title AS section,
     r.sections_id,
     qpt.title AS question,
     r.questions_id,
     apt.title AS answer_title,
     apt.description AS answer_value,
     r.free_text AS free_text,
     r.answers_id,
     r.created_at
FROM
     responses AS r
        JOIN
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=r.languages_id
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=r.languages_id
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=r.languages_id
        JOIN
     sessions AS s ON r.sessions_id=s.id
WHERE
     r.sessions_id=sessions_id;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `createKeyGroup_adminer_55b00388b299c` (IN `key_count` int, IN `min_val` int)
BEGIN
    DECLARE i INT;
    SET i = 0;
    START TRANSACTION;
        WHILE i <= key_count DO
            CALL insertSessionKey(min_val + i);
            SET i = i + 1;
        END WHILE;
    COMMIT;
END;;
DELIMITER ;
DROP PROCEDURE `createKeyGroup_adminer_55b00388b299c`;
DROP PROCEDURE `createKeyGroup`;
DELIMITER ;;
CREATE PROCEDURE `createKeyGroup` (IN `key_count` int, IN `min_val` int)
BEGIN
    DECLARE i INT;
    SET i = 0;
    START TRANSACTION;
        WHILE i <= key_count DO
            CALL insertSessionKey(min_val + i);
            SET i = i + 1;
        END WHILE;
    COMMIT;
END;;
DELIMITER ;
