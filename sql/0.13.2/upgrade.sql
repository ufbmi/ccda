-- 
-- Contents of /Users/pbc/git/ccdaa-spanish/utils/..//./sql/0.13.2/01_fix_spanish_next_buttons.sql
-- 
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '1294';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '1688';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = '' WHERE `id` = '1930';
UPDATE `preferences_text` SET `placeholder` = 'Hecho', `default` = '' WHERE `id` = '2520';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = '' WHERE `id` = '2522';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = '' WHERE `id` = '2952';

-- 
-- Contents of /Users/pbc/git/ccdaa-spanish/utils/..//./sql/0.13.2/02_fix_colonoscopy_accuracy_image_in_attributes_list.sql
-- 
UPDATE `preferences_text` SET
`id` = '3261',
`languages_id` = '2',
`title` = '',
`description` = '{\"0\":{\"0\":\"Descripción de la prueba\",\"1\":\"El médico busca tumores o cáncer en todo su colon utilizando un tubo flexible, largo y estrecho iluminado que tiene una cámara en el extremo final. Éste se introduce  por el ano y, a continuación, pasa por todo su colon, el cuál puede ser visto en una pantalla de televisión. A usted se le da un medicamento directamente en la vena en el brazo para sedarlo durante el examen.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/31.mp3\"}},\"1\":{\"0\":\"Precisión\",\"image_01\":{\"image_alt\":{\"0\":\"Si existieran 10 cánceres, esta prueba podría detectar 9 o 10 de ellos.Si existieran 10 pólipos grandes, esta prueba podría detectar 9 o 10 de ellos.\"},\"image_src\":{\"0\":\"/media/spanish/col_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/32.mp3\"}},\"2\":{\"0\":\"Cantidad de colon examinado\",\"1\":\"El colon completo se examina con esta prueba.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/33.mp3\"}},\"3\":{\"0\":\"Complicaciones\",\"1\":\"2 o 3 de cada 1,000 examenes  pueden resultar en una complicación grave. 1 de cada 20,000 exámenes puede resultar en complicaciones que ocasionen la muerte.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/34.mp3\"}},\"4\":{\"0\":\"Costo\",\"1\":\"El costo promedio sin seguro médico es de $800 a $1600. De acuerdo a la ley de Cuidado de Salud Accesible (Affordable Care Act en Inglés ), todos los planes de salud deben cubrir cualquier prueba o exámen preventivo, como las colonoscopías. Sin embargo, es posible que usted tenga que hacer un copago o pagar un deducible.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/35.mp3\"}},\"5\":{\"0\":\"Molestia\",\"1\":\"Si usted se hace éste exámen, podría presentar cólicos abdominales, diarrea y gases antes y después del exámen, pero no durante el exámen.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/36.mp3\"}},\"6\":{\"0\":\"Frecuencia\",\"1\":\"Se recomienda realizarse este exámen una vez cada 10 años.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/37.mp3\"}},\"7\":{\"0\":\"Ubicación\",\"1\":\"Este exámen se realiza en el hospital o en un centro de endoscopia ambulatorio por un médico especialista.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/38.mp3\"}},\"8\":{\"0\":\"Pruebas adicionales\",\"1\":\"No hay necesidad de realizar exámenes adicionales para saber si algo está mal.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/39.mp3\"}},\"9\":{\"0\":\"Sedación\",\"1\":\"Se le pone una inyección para inducir el sueño.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/40.mp3\"}},\"10\":{\"0\":\"Preparación para la prueba\",\"1\":\"Para prepararse para este exámen, usted tendrá que hacer lo siguiente: El día antes del exámen, tendrá que estar a dieta de puros líquidos claros. La noche antes del exámen y el día del examen, entre 5 y 6 de la mañana debe beber un galón  de solución tomando un vaso cada 10 a 15 minutos. Esto le causara diarrea y vaciará el colon. El día del exámen, no puede desayunar, pero puede tomar sus medicamentos.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/41.mp3\"}},\"11\":{\"0\":\"Evidencia Científica\",\"image_01\":{\"image_alt\":{\"0\":\"La evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 5 a 8 de cada 10 nuevos casos de cancer. De forma similar, la evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 6 a 7 de cada 10 muertes por cancer de colon y recto si se realiza éste exámen periódicamente después de los 50 años de edad.\",\"1\":\"La evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 5 a 8 de cada 10 nuevos casos de cancer. De forma similar, la evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 6 a 7 de cada 10 muertes por cancer de colon y recto si se realiza éste exámen periódicamente después de los 50 años de edad.\"},\"image_src\":{\"0\":\"/media/spanish/col_scientific_evidence_1.png\",\"1\":\"/media/spanish/col_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/42.mp3\"}},\"12\":{\"0\":\"Tiempo\",\"1\":\"Toma 45 minutos hacer esta prueba, pero usted necesitará tomarse todo el día libre de sus actividades regulares.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/43.mp3\"}},\"13\":{\"0\":\"Responsabilidades\",\"1\":\"Cuando se decida a realizarse esta prueba, tendrá que cambiar su dieta, hacer una cita, comprar la solución y beberla en casa según las instrucciones. El día del examen es necesario que lo acompañe un adulto para que lo lleve de regreso a casa.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/44.mp3\"}}}',
`instructions` = 'COL',
`placeholder` = '',
`default` = '0',
`object_label` = '',
`sites_id` = NULL,
`projects_id` = NULL,
`forms_id` = NULL,
`sections_id` = NULL,
`questions_id` = '276',
`answers_id` = NULL
WHERE `id` = '3261';

-- 
-- Contents of /Users/pbc/git/ccdaa-spanish/utils/..//./sql/0.13.2/99_bump_version_number.sql
-- 
update forms set version='0.13.2' where 1=1;

