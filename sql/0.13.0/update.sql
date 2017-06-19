-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/01_alter_lu_options_add_required.sql
-- 
ALTER TABLE `lu_options`
CHANGE `parameter` `parameter` enum('display','width','height','rows','cols','max','min','headers','isOpen','isDisabled','video_src','autoplay','loop','aspectRatio','resetAvailable','show_logic','scored_section','audio_src','controls','preload','volume','required') COLLATE 'latin1_swedish_ci' NOT NULL AFTER `id`;

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/02_alter_preferences_text_upsize_title.sql
-- 
ALTER TABLE `preferences_text`
CHANGE `title` `title` text COLLATE 'latin1_swedish_ci' NOT NULL AFTER `languages_id`;

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/03_edit_preferences_text_add_images_to_PE_sections.sql
-- 
UPDATE `preferences_text` SET `id` = '3258', `languages_id` = '1', `title` = '', `description` = '{\"0\":{\"0\":\"Test Description\",\"1\":\"This test checks if your bowel movement contains blood. It is done at home using a test kit with 3 cards. You smear a sample of your bowel movement onto a card. This is done for 3 different bowel movements. The three cards are then returned to the lab.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/17.mp3\"}},\"1\":{\"0\":\"Accuracy\",\"image_01\":{\"image_alt\":{\"0\":\"If there were 10 cancers, this test could find 8 of them; if there were 10 large polyps, this test could find 2 of them.\"},\"image_src\":{\"0\":\"/media/english/fit_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/18.mp3\"}},\"2\":{\"0\":\"Amount of Colon Examined\",\"1\":\"The colon is not examined directly\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/19.mp3\"}},\"3\":{\"0\":\"Complications\",\"1\":\"There are no complications with this test\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/20.mp3\"}},\"4\":{\"0\":\"Cost\",\"1\":\"The average cost before insurance is about $25. Health plans usually cover the cost of the test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/21.mp3\"}},\"5\":{\"0\":\"Discomfort\",\"1\":\"There is no discomfort with this test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/22.mp3\"}},\"6\":{\"0\":\"Frequency\",\"1\":\"It is recommended that you have this test done every year\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/23.mp3\"}},\"7\":{\"0\":\"Location and Who Performs the Test\",\"1\":\"The test is done by you at home and a lab technician checks the cards\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/24.mp3\"}},\"8\":{\"0\":\"Further Testing\",\"1\":\"If the test is abnormal, you would need to have a colonoscopy to find out what is wrong.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/25.mp3\"}},\"9\":{\"0\":\"Sedation\",\"1\":\"None\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/26.mp3\"}},\"10\":{\"0\":\"Test Preparation\",\"1\":\"There is no preparation for the test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/27.mp3\"}},\"11\":{\"0\":\"Scientific Evidence\",\"image_01\":{\"image_alt\":{\"0\":\"High quality evidence suggests that this test could prevent 2 out of every 10 new cancers; and high quality evidence also suggests that this test could prevent 2 to 3 out of 10 colorectal cancer deaths with regular testing after age 50.\",\"1\":\"High quality evidence suggests that this test could prevent 2 out of every 10 new cancers; and high quality evidence also suggests that this test could prevent 2 to 3 out of 10 colorectal cancer deaths with regular testing after age 50.\"},\"image_src\":{\"0\":\"/media/english/fit_scientific_evidence_1.png\",\"1\":\"/media/english/fit_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/28.mp3\"}},\"12\":{\"0\":\"Time\",\"1\":\"Time required for the test is a few minutes on three separate occasions. You won’t miss time off from your regular activities.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/29.mp3\"}},\"13\":{\"0\":\"Responsibilities\",\"1\":\"When you decide to have this test, you will have to pick up the test kit, put a sample of your bowel movement on the cards and mail it or bring it to the lab.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/30.mp3\"}}}', `instructions` = 'FIT', `placeholder` = '', `default` = '0', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '275', `answers_id` = NULL WHERE `description` LIKE '{%' AND `instructions` IS NOT NULL AND `default` = '0' AND `id` = '3258';
UPDATE `preferences_text` SET `id` = '3259', `languages_id` = '2', `title` = '', `description` = '{\"0\":{\"0\":\"Descripción de la prueba\",\"1\":\"Esta prueba verifica si su excremento contiene sangre. Se realiza en casa con un kit de prueba que contiene 3 tarjetas. Usted debe colocar una muestra de su excremento en una tarjeta. Esto se repite en 3 ocasiones diferentes en las que usted vaya a defecar. Después, las tres tarjetas se envían al laboratorio.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/17.mp3\"}},\"1\":{\"0\":\"Precisión\",\"image_01\":{\"image_alt\":{\"0\":\"Si existieran 10 cánceres, esta prueba podría detectar 8 de ellos. Si existieran 10 pólipos grandes, esta prueba podría detectar 2 de ellos.\"},\"image_src\":{\"0\":\"/media/spanish/fit_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/18.mp3\"}},\"2\":{\"0\":\"Cantidad de colon examinado\",\"1\":\"El colon no es examinado directamente.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/19.mp3\"}},\"3\":{\"0\":\"Complicaciones\",\"1\":\"No hay complicaciones con esta prueba.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/20.mp3\"}},\"4\":{\"0\":\"Costo\",\"1\":\"El costo promedio sin cobertura de seguro es de $25.  Las aseguranzas o planes de salud usualmente cubren el costo de la prueba.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/21.mp3\"}},\"5\":{\"0\":\"Molestia\",\"1\":\"Esta prueba no produce ninguna molestia.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/22.mp3\"}},\"6\":{\"0\":\"Frecuencia\",\"1\":\"Se recomienda realizarse esta prueba cada año.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/23.mp3\"}},\"7\":{\"0\":\"Ubicación\",\"1\":\"La prueba la realiza usted mismo en su casa y un técnico de laboratorio examina las tarjetas.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/24.mp3\"}},\"8\":{\"0\":\"Pruebas adicionales\",\"1\":\"Si la prueba es anormal, usted tendría que hacerse otra prueba (colonoscopía) para saber si algo está mal.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/25.mp3\"}},\"9\":{\"0\":\"Sedación\",\"1\":\"No requiere.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/26.mp3\"}},\"10\":{\"0\":\"Preparación para la prueba\",\"1\":\"No se requiere preparación previa para la prueba.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/27.mp3\"}},\"11\":{\"0\":\"Evidencia Científica\",\"image_01\":{\"image_alt\":{\"0\":\"La evidencia científica de alta calidad sugiere que esta prueba puede prevenir 2 de cada 10 nuevos casos de cáncer. De forma similar, la evidencia científica de alta calidad sugiere que esta prueba puede prevenir de 2 a 3 de cada 10 muertes por cancer de colon y recto si se realizan éstas pruebas regularmente después de cumplir los 50 años.\",\"1\":\"La evidencia científica de alta calidad sugiere que esta prueba puede prevenir 2 de cada 10 nuevos casos de cáncer. De forma similar, la evidencia científica de alta calidad sugiere que esta prueba puede prevenir de 2 a 3 de cada 10 muertes por cancer de colon y recto si se realizan éstas pruebas regularmente después de cumplir los 50 años.\"},\"image_src\":{\"0\":\"/media/spanish/fit_scientific_evidence_1.png\",\"1\":\"/media/spanish/fit_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/28.mp3\"}},\"12\":{\"0\":\"Tiempo\",\"1\":\"El tiempo que se requiere para realizar la prueba es tan sólo unos cuantos minutos en tres ocasiones distintas. Usted no perderá tiempo de sus actividades regulares.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/29.mp3\"}},\"13\":{\"0\":\"Responsabilidades\",\"1\":\"Cuando se decida a realizarse esta prueba, usted tendrá que recoger el kit de la prueba, poner una muestra de su excremento en las tarjetas y enviarlo por correo, o llevarlas a un laboratorio.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/30.mp3\"}}}', `instructions` = 'FIT', `placeholder` = '', `default` = '0', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '275', `answers_id` = NULL WHERE `description` LIKE '{%' AND `instructions` IS NOT NULL AND `default` = '0' AND `id` = '3259';
UPDATE `preferences_text` SET `id` = '3260', `languages_id` = '1', `title` = '', `description` = '{\"0\":{\"0\":\"Test Description\",\"1\":\"A doctor checks for growths or cancer in your whole colon using a flexible long narrow, lighted tube with a camera on the end. It is inserted into your bottom and then passed into your whole colon, which can be seen on a TV screen. You are given medicine through a needle in your arm to make you sleepy during the test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/45.mp3\"}},\"1\":{\"0\":\"Accuracy\",\"image_01\":{\"image_alt\":{\"0\":\"If there were 10 cancers, this test could find 9 or 10 of them; if there were 10 large polyps, this test could find 9 or 10 of them.\"},\"image_src\":{\"0\":\"/media/english/col_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/46.mp3\"}},\"2\":{\"0\":\"Amount of Colon Examined\",\"1\":\"The entire colon is examined with this test\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/47.mp3\"}},\"3\":{\"0\":\"Complications\",\"1\":\"2 to 3 out of every 1,000 tests may result in a serious complication 1 in every 20,000 tests may lead to a complication resulting in death\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/48.mp3\"}},\"4\":{\"0\":\"Cost\",\"1\":\"The average cost before insurance is  $800 - $1600. Under the Patient Prevention and Affordable Care Act, all health plans are required to cover preventive screening tests, like colonoscopies. However, you may still owe a copay or deductible.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/49.mp3\"}},\"5\":{\"0\":\"Discomfort\",\"1\":\"If you have this test, you may experience cramping abdominal pain, diarrhea and gas before and after the test but not during the test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/50.mp3\"}},\"6\":{\"0\":\"Frequency\",\"1\":\"It is recommended that you have this test once every 10 years\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/51.mp3\"}},\"7\":{\"0\":\"Location and Who Performs the Test\",\"1\":\"The test is done in the hospital or outpatient endoscopy center by a physician specialist.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/52.mp3\"}},\"8\":{\"0\":\"Further Testing\",\"1\":\"There is no need for further tests to find out what is wrong.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/53.mp3\"}},\"9\":{\"0\":\"Sedation\",\"1\":\"A shot is given to make you sleepy.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/54.mp3\"}},\"10\":{\"0\":\"Test Preparation\",\"1\":\"To get ready to have this test, you will have to do the following things. The day before the test, you can only have a clear liquid diet. The night before this test and between 5 and 6 on the morning of the test, you drink a gallon of solution, drinking a glass every 10 to 15 minutes. This causes diarrhea, which empties your colon. On the day of the test, you cannot eat breakfast but can take your medications.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/55.mp3\"}},\"11\":{\"0\":\"Scientific Evidence\",\"image_01\":{\"image_alt\":{\"0\":\"Fair quality evidence suggests that this test could prevent 5 to 8 out of every 10 new cancers; and fair quality evidence also suggests that this test could prevent 6 to 7 out of 10 colorectal cancer deaths with regular testing after age 50.\",\"1\":\"Fair quality evidence suggests that this test could prevent 5 to 8 out of every 10 new cancers; and fair quality evidence also suggests that this test could prevent 6 to 7 out of 10 colorectal cancer deaths with regular testing after age 50.\"},\"image_src\":{\"0\":\"/media/english/col_scientific_evidence_1.png\",\"1\":\"/media/english/col_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/56.mp3\"}},\"12\":{\"0\":\"Time\",\"1\":\"It takes 45 minutes to have this test but you will need a whole day off from your regular activities.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/57.mp3\"}},\"13\":{\"0\":\"Responsibilities\",\"1\":\"When you decide to have this test, you will have to alter your diet, make an appointment, buy the solution and take the solution at home according to the instructions. You need to bring a responsible adult who can drive you home.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/58.mp3\"}}}', `instructions` = 'COL', `placeholder` = '', `default` = '0', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '276', `answers_id` = NULL WHERE `description` LIKE '{%' AND `instructions` IS NOT NULL AND `default` = '0' AND `id` = '3260';
UPDATE `preferences_text` SET `id` = '3261', `languages_id` = '2', `title` = '', `description` = '{\"0\":{\"0\":\"Descripción de la prueba\",\"1\":\"El médico busca tumores o cáncer en todo su colon utilizando un tubo flexible, largo y estrecho iluminado que tiene una cámara en el extremo final. Éste se introduce  por el ano y, a continuación, pasa por todo su colon, el cuál puede ser visto en una pantalla de televisión. A usted se le da un medicamento directamente en la vena en el brazo para sedarlo durante el examen.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/31.mp3\"}},\"1\":{\"0\":\"Precisión\",\"image_01\":{\"image_alt\":{\"0\":\"Si existieran 10 cánceres, esta prueba podría detectar 9 o 10 de ellos.Si existieran 10 pólipos grandes, esta prueba podría detectar 9 o 10 de ellos.\"},\"image_src\":{\"0\":\"/media/spanish/images/col_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/32.mp3\"}},\"2\":{\"0\":\"Cantidad de colon examinado\",\"1\":\"El colon completo se examina con esta prueba.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/33.mp3\"}},\"3\":{\"0\":\"Complicaciones\",\"1\":\"2 o 3 de cada 1,000 examenes  pueden resultar en una complicación grave. 1 de cada 20,000 exámenes puede resultar en complicaciones que ocasionen la muerte.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/34.mp3\"}},\"4\":{\"0\":\"Costo\",\"1\":\"El costo promedio sin seguro médico es de $800 a $1600. De acuerdo a la ley de Cuidado de Salud Accesible (Affordable Care Act en Inglés ), todos los planes de salud deben cubrir cualquier prueba o exámen preventivo, como las colonoscopías. Sin embargo, es posible que usted tenga que hacer un copago o pagar un deducible.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/35.mp3\"}},\"5\":{\"0\":\"Molestia\",\"1\":\"Si usted se hace éste exámen, podría presentar cólicos abdominales, diarrea y gases antes y después del exámen, pero no durante el exámen.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/36.mp3\"}},\"6\":{\"0\":\"Frecuencia\",\"1\":\"Se recomienda realizarse este exámen una vez cada 10 años.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/37.mp3\"}},\"7\":{\"0\":\"Ubicación\",\"1\":\"Este exámen se realiza en el hospital o en un centro de endoscopia ambulatorio por un médico especialista.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/38.mp3\"}},\"8\":{\"0\":\"Pruebas adicionales\",\"1\":\"No hay necesidad de realizar exámenes adicionales para saber si algo está mal.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/39.mp3\"}},\"9\":{\"0\":\"Sedación\",\"1\":\"Se le pone una inyección para inducir el sueño.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/40.mp3\"}},\"10\":{\"0\":\"Preparación para la prueba\",\"1\":\"Para prepararse para este exámen, usted tendrá que hacer lo siguiente: El día antes del exámen, tendrá que estar a dieta de puros líquidos claros. La noche antes del exámen y el día del examen, entre 5 y 6 de la mañana debe beber un galón  de solución tomando un vaso cada 10 a 15 minutos. Esto le causara diarrea y vaciará el colon. El día del exámen, no puede desayunar, pero puede tomar sus medicamentos.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/41.mp3\"}},\"11\":{\"0\":\"Evidencia Científica\",\"image_01\":{\"image_alt\":{\"0\":\"La evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 5 a 8 de cada 10 nuevos casos de cancer. De forma similar, la evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 6 a 7 de cada 10 muertes por cancer de colon y recto si se realiza éste exámen periódicamente después de los 50 años de edad.\",\"1\":\"La evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 5 a 8 de cada 10 nuevos casos de cancer. De forma similar, la evidencia científica de moderada calidad sugiere que esta prueba puede prevenir de 6 a 7 de cada 10 muertes por cancer de colon y recto si se realiza éste exámen periódicamente después de los 50 años de edad.\"},\"image_src\":{\"0\":\"/media/spanish/col_scientific_evidence_1.png\",\"1\":\"/media/spanish/col_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/42.mp3\"}},\"12\":{\"0\":\"Tiempo\",\"1\":\"Toma 45 minutos hacer esta prueba, pero usted necesitará tomarse todo el día libre de sus actividades regulares.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/43.mp3\"}},\"13\":{\"0\":\"Responsabilidades\",\"1\":\"Cuando se decida a realizarse esta prueba, tendrá que cambiar su dieta, hacer una cita, comprar la solución y beberla en casa según las instrucciones. El día del examen es necesario que lo acompañe un adulto para que lo lleve de regreso a casa.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/44.mp3\"}}}', `instructions` = 'COL', `placeholder` = '', `default` = '0', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '276', `answers_id` = NULL WHERE `description` LIKE '{%' AND `instructions` IS NOT NULL AND `default` = '0' AND `id` = '3261';
UPDATE `preferences_text` SET `id` = '3262', `languages_id` = '1', `title` = '', `description` = '{\"0\":{\"0\":\"Test Description\",\"1\":\"A doctor checks for growths or cancer in the lower third of your colon using a short flexible narrow, lighted tube with a camera on the end. It is inserted into your bottom and then passed only into your lower colon, which can be seen on a TV screen. You are awake during the test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/31.mp3\"}},\"1\":{\"0\":\"Accuracy\",\"image_01\":{\"image_alt\":{\"0\":\"If there were 10 cancers in the lower colon, this test could find 9 or 10 of them.\"},\"image_src\":{\"0\":\"/media/english/sig_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/32.mp3\"}},\"2\":{\"0\":\"Amount of Colon Examined\",\"1\":\"The lower third of the colon is examined with this test\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/33.mp3\"}},\"3\":{\"0\":\"Complications\",\"1\":\"For every 20,000 tests, 1 may result in a serious complication.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/34.mp3\"}},\"4\":{\"0\":\"Cost\",\"1\":\"The average cost before insurance is : $500 - $750. Under the Patient Prevention and Affordable Care Act, all health plans are required to cover preventive screening tests, like flexible sigmoidoscopy. However, you may still owe a copay or deductible.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/35.mp3\"}},\"5\":{\"0\":\"Discomfort\",\"1\":\"If you have this test, you may experience cramping abdominal pain, diarrhea and gas before, during and after the test.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/36.mp3\"}},\"6\":{\"0\":\"Frequency\",\"1\":\"It is recommended that you have this test once every 5 years\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/37.mp3\"}},\"7\":{\"0\":\"Location and Who Performs the Test\",\"1\":\"This test can be done by a primary care doctor or a physician specialist in a doctor’s office or in a hospital.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/38.mp3\"}},\"8\":{\"0\":\"Further Testing\",\"1\":\"If the test is abnormal, you would need to have a colonoscopy to find out what is wrong.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/39.mp3\"}},\"9\":{\"0\":\"Sedation\",\"1\":\"None\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/40.mp3\"}},\"10\":{\"0\":\"Test Preparation\",\"1\":\"To get ready for this test, you will need to do the following things: After midnight on the night before the test, you cannot eat or drink anything. One hour before the test, you need to give yourself 2 enemas which cause diarrhea and empty your colon. An enema is when you place liquid medicine into your bottom. On the day of the test, you cannot eat breakfast but can take your medications.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/41.mp3\"}},\"11\":{\"0\":\"Scientific Evidence\",\"image_01\":{\"image_alt\":{\"0\":\"High quality evidence suggests that this test could prevent 2 to 4 out of every 10 new cancers; and high quality evidence also suggests that this test could prevent 3 to 5 out of 10 colorectal cancer deaths with regular testing after age 50.\",\"1\":\"High quality evidence suggests that this test could prevent 2 to 4 out of every 10 new cancers; and high quality evidence also suggests that this test could prevent 3 to 5 out of 10 colorectal cancer deaths with regular testing after age 50.\"},\"image_src\":{\"0\":\"/media/english/sig_scientific_evidence_1.png\",\"1\":\"/media/english/sig_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/42.mp3\"}},\"12\":{\"0\":\"Time\",\"1\":\"It takes about 30 minutes to have this test. You will need half a day off from your regular activities.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/43.mp3\"}},\"13\":{\"0\":\"Responsibilities\",\"1\":\"When you decide to have this test, you will have to alter your diet, make an appointment, buy the enema solution and give yourself the enemas at home according to the instructions.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/english/44.mp3\"}}}', `instructions` = 'SIG', `placeholder` = '', `default` = '0', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '277', `answers_id` = NULL WHERE `description` LIKE '{%' AND `instructions` IS NOT NULL AND `default` = '0' AND `id` = '3262';
UPDATE `preferences_text` SET `id` = '3263', `languages_id` = '2', `title` = '', `description` = '{\"0\":{\"0\":\"Descripción de la prueba\",\"1\":\"El médico busca si existen tumores o cáncer a lo largo de la mitad inferior del colon mediante un tubo, estrecho, corto, flexible e iluminado que tiene una cámara en el extremo. Este tubo se introduce por el ano y a continuación se revisa sólo la parte inferior del colon, el cuál puede ser visto en una pantalla de televisión. Usted permanece despierto durante el exámen.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/45.mp3\"}},\"1\":{\"0\":\"Precisión\",\"image_01\":{\"image_alt\":{\"0\":\"Si existieran 10 cánceres en la parte baja del colon, esta prueba podría detectar 9 ó 10 de ellos.\"},\"image_src\":{\"0\":\"/media/spanish/sig_accuracy.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/46.mp3\"}},\"2\":{\"0\":\"Cantidad de colon examinado\",\"1\":\"Esta prueba examina el tercio inferior del colon.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/47.mp3\"}},\"3\":{\"0\":\"Complicaciones\",\"1\":\"De cada 20,000 exámenes, 1 puede resultar en una complicación grave.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/48.mp3\"}},\"4\":{\"0\":\"Costo\",\"1\":\"El costo promedio sin seguro médico es de : $500 a $750. De acuerdo a la ley de Cuidado de Salud Accesible (Affordable Care Act en Inglés), todos los planes de salud deben cubrir cualquier exámen preventivo, tal como la sigmoidoscopía. Sin embargo, es posible que usted tenga que hacer un copago o pagar un deducible.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/49.mp3\"}},\"5\":{\"0\":\"Molestia\",\"1\":\"Si usted se hace este exámen, podría tener cólicos abdominales, diarrea y gases antes, durante y después del exámen.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/50.mp3\"}},\"6\":{\"0\":\"Frecuencia\",\"1\":\"Es recomendable hacerse este exámen cada 5 años.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/51.mp3\"}},\"7\":{\"0\":\"Ubicación\",\"1\":\"Este exámen puede ser realizado por un médico general o un médico especialista en el consultorio del médico o en un hospital.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/52.mp3\"}},\"8\":{\"0\":\"Pruebas adicionales\",\"1\":\"Si el resultado es anormal, usted tendría que hacerse una colonoscopía para saber si algo está mal.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/53.mp3\"}},\"9\":{\"0\":\"Sedación\",\"1\":\"No requiere\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/54.mp3\"}},\"10\":{\"0\":\"Preparación para la prueba\",\"1\":\"Como preparación para éste exámen, usted tendrá que hacer lo siguiente: Después de la medianoche de la noche anterior al exámen, no se puede comer ni beber nada. Una hora antes de la prueba, es necesario que se ponga 2 enemas/lavativas las cuales causan diarrea y vacían el colon. Enema es un procedimiento para limpiar el colon que consiste en introducir líquido al colon a través del ano. El día de la prueba no debe desayunar, pero puede tomar sus medicamentos.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/55.mp3\"}},\"11\":{\"0\":\"Evidencia Científica\",\"image_01\":{\"image_alt\":{\"0\":\"La evidencia científica de alta calidad sugiere que esta prueba puede prevenir de 2 a 4 de cada 10 nuevos casos de cáncer. De forma similar, la evidencia científica de alta calidad sugiere que esta prueba puede prevenir de 3 a 5 de cada 10 muertes por cancer de colon y recto si se realiza éste examen periódicamente después de los 50 años de edad.\",\"1\":\"La evidencia científica de alta calidad sugiere que esta prueba puede prevenir de 2 a 4 de cada 10 nuevos casos de cáncer. De forma similar, la evidencia científica de alta calidad sugiere que esta prueba puede prevenir de 3 a 5 de cada 10 muertes por cancer de colon y recto si se realiza éste examen periódicamente después de los 50 años de edad.\"},\"image_src\":{\"0\":\"/media/spanish/sig_scientific_evidence_1.png\",\"1\":\"/media/spanish/sig_scientific_evidence_2.png\"}},\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/56.mp3\"}},\"12\":{\"0\":\"Tiempo\",\"1\":\"Este exámen requiere aproximadamente 30 minutos. Usted necesitará tomarse medio día de sus actividades regulares.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/57.mp3\"}},\"13\":{\"0\":\"Responsabilidades\",\"1\":\"Cuando se decida a realizarse esta prueba, tendrá que cambiar su dieta, hacer una cita, comprar la solución para el enema y aplicárselo en casa según las instrucciones.\",\"audio_01\":{\"controls\":false,\"audio_src\":\"/media/spanish/58.mp3\"}}}', `instructions` = 'SIG', `placeholder` = '', `default` = '0', `object_label` = '', `sites_id` = NULL, `projects_id` = NULL, `forms_id` = NULL, `sections_id` = NULL, `questions_id` = '277', `answers_id` = NULL WHERE `description` LIKE '{%' AND `instructions` IS NOT NULL AND `default` = '0' AND `id` = '3263';

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/04_update_previous_next_buttons.sql
-- 
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '527';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '559';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '770';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '2432';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '2434';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '2951';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = '' WHERE `id` = '2964';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '3058';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '4383';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '1690';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '1719';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '1930';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '2520';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '2522';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '2952';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = '' WHERE `id` = '2965';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '3059';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '4382';

UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '86';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '525';
UPDATE `preferences_text` SET `placeholder` = 'Next', `default` = 'Previous' WHERE `id` = '3060';
UPDATE `preferences_text` SET `placeholder` = 'Siguiente', `default` = 'Anterior' WHERE `id` = '3061';

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/05_remove_duplicate_question_rows_in_preferences_types.sql
-- 
DELETE pt1 FROM preferences_types pt1, preferences_types pt2
WHERE pt1.id > pt2.id 
AND pt1.lu_types_id = pt2.lu_types_id
AND pt1.questions_id = pt2.questions_id;


-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/06_add_isRequired_option_foreach_question_in_preference_elicitation.sql
-- 
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

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/07_add_isRequired_option_for_questions.sql
-- 
ALTER TABLE `lu_options`
CHANGE `parameter` `parameter` enum('display','width','height','rows','cols','max','min','headers','isOpen','isDisabled','video_src','autoplay','loop','aspectRatio','resetAvailable','show_logic','scored_section','audio_src','controls','preload','volume','isRequired') COLLATE 'latin1_swedish_ci' NOT NULL AFTER `id`;

INSERT INTO `lu_options` (`parameter`, `category`)
VALUES (22, 6);


-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/08_drop_is_required_from_questions.sql
-- 
ALTER TABLE `questions`
DROP `is_required`;

-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/09_normal_response_data_to_english_text_in_getResponsesForAll.sql
-- 
DELIMITER ;;
CREATE PROCEDURE `getResponsesForAll_adminer_55f883fdeb646` ()
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
DROP PROCEDURE `getResponsesForAll_adminer_55f883fdeb646`;
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


-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/10_select_only_latest_response_in_getResponsesForAll.sql
-- 
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


-- 
-- Contents of /Users/pbc/git/ccdaa-pbc/utils/..//./sql/0.13.0/99_bump_version_number.sql
-- 
update forms set version='0.13.0' where 1=1;

