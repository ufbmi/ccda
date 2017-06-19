-- Add isRequired for questions in the preference elicitation section
insert into preferences_options 
(lu_options_id, value, questions_id)
select 42,'true',q.id
from forms as f 
inner join sections as s 
inner join questions as q
inner join preferences_text as pt
inner join preferences_types as ptypes
where f.id = 3
and f.id = s.forms_id
and s.id = q.sections_id
and q.id = pt.questions_id
and q.id = ptypes.questions_id
and q.deleted_at = "0000-00-00 00:00:00"
and pt.languages_id = 1
and ptypes.lu_types_id not in (10,20)
order by q.sections_id, q.sort_order;

-- Remove any duplicate rows created by above
DELETE po1 FROM preferences_options po1, preferences_options po2
WHERE po1.id > po2.id 
AND po1.lu_options_id = po2.lu_options_id
AND po1.value = po2.value
AND po1.questions_id = po2.questions_id;
