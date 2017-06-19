-- Fix spacing in spanish text
UPDATE `preferences_text` SET `title` = '¿Qué tan bueno es usted para calcular cuánto costará una camisa si tiene un 25% de descuento?', WHERE `id` = '3071'and `languages_id` = '2';
UPDATE `preferences_text` SET `title` = '¿Lo prepare para sus visitas de seguimiento con su doctor?' WHERE `id` = '3919' and `languages_id` = '2';
UPDATE `preferences_text` SET `title` = 'Rehusa / No sé' WHERE `title` = 'Rehusa/No sé' and `languages_id` = '2';
