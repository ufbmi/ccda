DELETE pt1 FROM preferences_types pt1, preferences_types pt2
WHERE pt1.id > pt2.id 
AND pt1.lu_types_id = pt2.lu_types_id
AND pt1.questions_id = pt2.questions_id;

