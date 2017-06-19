var debug_mode = true;
var root_config = {
    "title": "Colorectal Cancer Decision Assistance Application",
    "short_title": "Decision Assistance Application",
    "description": "Fast, intelligent, decision aid tool.  Because your health is important!",
    "author": "CTS-IT <ctsit@ctsi.ufl.edu>, Roy Keyes <keyes@ufl.edu>",
    "copyright": "CTS-IT @ University of Florida 2015",
    "api_url": "http://vagrant1/ccda-colorectal-cancer-decision-aids/api/v1/",
    "languages": [
      { 'abbr': 'es', 'name': 'Español' },
      { 'abbr': 'en', 'name': 'English' }
    ],
    "start" : { "text" : { "en": "Welcome", "es": "Bienvenida" } },
    "finish" : {
      "text" : { "en": "Congratulations", "es": "Felicitaciones" },
      "details": {
          "en": "Thank You! You have successfully completed the survey!",
          "es": "Gracias! Ha completado con éxito la encuesta!"
        }
    },
    "instructions": {
      "en": [
          "Welcome to this educational program about colorectal cancer and screening.",
          "You will be learning about this type of cancer and how to detect it early.",
          "We will ask you a series of questions to learn a little more about you.",
          "Then you will complete the education and decide what to do next."
        ],
      "es": [
          "Bienvenidos a este programa educativo acerca del cáncer de colon y recto y su detección.",
          "Usted va a aprender sobre éste tipo de cáncer y como detectarlo de manera temprana.",
          "Vamos a hacerle algunas preguntas para conocer un poco más sobre usted.",
          "Después usted completará la educación y decidirá que hacer a continuación."
        ]
      },
    "begin": { "en": "Begin", "es": "Empezar" },
    "complete": { "en": "Finished", "es": "Terminado" },
    "progress": { "value": null, "text": { "en": "Progress", "es": "Progreso" } },
    "forms": [
      {},
        {
          "title": {
            "en": "Preparation for Decision Making Scale",
            "es": "Escala de preparacion para la toma de decisions" },
          "instructions": {
            "en": "Please indicate your opinion about the effect of the educational material by circling the appropriate number to show the extent to which you agree with each statement.",
            "es": "Por favor indique su opinión sobre el efecto del material educativo seleccionado  el número apropiado para mostrar  hasta qué punto está de acuerdo con cada afirmación" },
          "header_a": {
            "en": "Did this educational material...",
            "es": "Este material educativo..."
          },
          "header_1": {
            "en": "Not at all",
            "es": "Nada"
          },
          "header_2": {
            "en": "A little",
            "es": "Un Poco"
          },
          "header_3": {
            "en": "Somewhat",
            "es": "Algo"
          },
          "header_4": {
            "en": "Quite a bit",
            "es": "Mucho"
          },
          "header_5": {
            "en": "A great deal",
            "es": "Bastante"
          },
          "scores": ['1','2','3','4','5'],
          "questions": [
            {
              "id": "1",
              "text": {
                "en": "Help you recognize that a decision needs to be made?",
                "es": "¿Le ayudó a reconocer que se debe tomar una decisión Ɂ"
              },
              "answer": false
            },
            {
              "id": "2",
              "text": {
                "en": "Prepare you to make a better decision?",
                "es": "¿Lo preparó para tomar una mejor decisión Ɂ"
              },
              "answer": false
            },
            {
              "id": "3",
              "text": {
                "en": "Help you think about the pros and cons of each option?",
                "es": "Le ayudó a pensar acerca de cuáles son las  ventajas y desventajas  de cada opción Ɂ"
              },
              "answer": false
            },
            {
              "id": "4",
              "text": {
                "en": "Help you think about which pros and cons are most important?",
                "es": "¿Le ayudó a pensar acerca de cuáles  ventajas y desventajas son  mas importantesɁ"
              },
              "answer": false
            },
            {
              "id": "5",
              "text": {
                "en": "Help you know that the decision depends on what matters most to you?",
                "es": "¿Le ayudó a saber que las decisiones dependen de que es lo que a usted mas le importa?"
              },
              "answer": false
            },
            {
              "id": "6",
              "text": {
                "en": "Help you organize your own thoughts about the decision?",
                "es": "¿Le ayudó a organizar sus propios pensamientos acerca de la ecision a tomar ?"
              },
              "answer": false
            },
            {
              "id": "7",
              "text": {
                "en": "Help you think about how involved you want to be in this decision?",
                "es": "¿Le ayudó a pensar que tanto quiere estar usted involucrado en la toma de ésta decisión?"
              },
              "answer": false
            },
            {
              "id": "8",
              "text": {
                "en": "Help you identify questions you want to ask your doctor?",
                "es": "¿Le ayudó a identificar las preguntas que usted le quiere hacer a su doctor?"
              },
              "answer": false
            },
            {
              "id": "9",
              "text": {
                "en": "Prepare you to talk to your doctor about what matters most to you?",
                "es": "¿Lo preparó para hablar con su doctor sobre lo que es mas importante para usted?"
              },
              "answer": false
            },
            {
              "id": "10",
              "text": {
                "en": "Prepare you for a follow-up visit with your doctor?",
                "es": "¿ Lo prepare para sus visitas de seguimiento con su doctor ?"
              },
              "answer": false
            }
          ]
        }
      ]
};
