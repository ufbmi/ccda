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
     preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=r.languages_id
        JOIN
     preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=r.languages_id
        LEFT JOIN
     preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=r.languages_id
        JOIN
     sessions AS s ON r.sessions_id=s.id
        JOIN
     authorization as az ON s.id=az.sessions_id;
