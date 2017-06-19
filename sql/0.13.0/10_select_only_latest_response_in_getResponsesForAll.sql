DELIMITER ;;
CREATE PROCEDURE `getResponsesForAll_adminer_55f88d7d05533` ()
SELECT
     az.passid AS subject_id,
     spt.title AS section,
     qpt.title AS question,
     apt.title AS answer_title,
     apt.description AS answer_value,
     r.free_text AS free_text,
     r.created_at
FROM
     responses AS r
        JOIN 
     (select max(r2.id) id from responses r2
      group by r2.sessions_id, r2.forms_id, r2.sections_id, r2.questions_id
     ) as last_response on last_response.id = r.id
        JOIN
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=1
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=1
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=1
        JOIN
     sessions AS s ON r.sessions_id=s.id
        JOIN
     authorization as az ON s.id=az.sessions_id
;;
DELIMITER ;
DROP PROCEDURE `getResponsesForAll_adminer_55f88d7d05533`;
DROP PROCEDURE `getResponsesForAll`;
DELIMITER ;;
CREATE PROCEDURE `getResponsesForAll` ()
SELECT
     az.passid AS subject_id,
     spt.title AS section,
     qpt.title AS question,
     apt.title AS answer_title,
     apt.description AS answer_value,
     r.free_text AS free_text,
     r.created_at
FROM
     responses AS r
        JOIN 
     (select max(r2.id) id from responses r2
      group by r2.sessions_id, r2.forms_id, r2.sections_id, r2.questions_id
     ) as last_response on last_response.id = r.id
        JOIN
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=1
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=1
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=1
        JOIN
     sessions AS s ON r.sessions_id=s.id
        JOIN
     authorization as az ON s.id=az.sessions_id
;;
DELIMITER ;

