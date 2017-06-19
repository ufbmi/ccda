DELIMITER ;;
CREATE PROCEDURE `getScores_adminer_559ecb47da744` (IN `sessions_id` tinyint, IN `lu_options_id` tinyint)
SELECT spt.title AS section, r.sections_id,qpt.title AS question, r.questions_id,apt.description AS score, r.answers_id, s.token, r.id, r.created_at FROM responses AS r, preferences_text AS spt, preferences_text AS qpt, preferences_text AS apt, sessions AS s, preferences_options AS spo WHERE r.sessions_id=sessions_id AND spt.sections_id=r.sections_id AND qpt.questions_id=r.questions_id AND apt.answers_id=r.answers_id AND r.sessions_id=s.id AND spo.value=r.sections_id AND spo.lu_options_id=lu_options_id GROUP BY r.questions_id ORDER BY r.created_at DESC
;;
DELIMITER ;
DROP PROCEDURE `getScores_adminer_559ecb47da744`;
DROP PROCEDURE `getScores`;
DELIMITER ;;
CREATE PROCEDURE `getScores` (IN `sessions_id` tinyint, IN `lu_options_id` tinyint)
SELECT spt.title AS section, r.sections_id,qpt.title AS question, r.questions_id,apt.description AS score, r.answers_id, s.token, r.id, r.created_at FROM responses AS r, preferences_text AS spt, preferences_text AS qpt, preferences_text AS apt, sessions AS s, preferences_options AS spo WHERE r.sessions_id=sessions_id AND spt.sections_id=r.sections_id AND qpt.questions_id=r.questions_id AND apt.answers_id=r.answers_id AND r.sessions_id=s.id AND spo.value=r.sections_id AND spo.lu_options_id=lu_options_id GROUP BY r.questions_id ORDER BY r.created_at DESC
;;
DELIMITER ;
