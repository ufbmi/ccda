# Functional Specification for the Colorectal Cancer Decision Aids Application

## Authors

* Philip Chase <pbc@ufl.edu>
* Roy Keyes <keyes@ufl.edu>


## Overview

*Colorectal Cancer Decision Aid Study* is a project to increase colorectal cancer (CRC) screen rates via educational tools and assess the efficacy of those tools.  The study uses surveys and informational text, videos and decision making algorithms to assess patient knowledge about CRC screening, inform patients about screening options and recommend a screening option for each patient.  Special emphasis is made in this study to address the particular needs of underrepresented spanish-speaking and english-speaking populations.

This document describes the workflow of the survey in the context of a family practice clinic where it is expect to be deployed.  It includes use cases for each actor in the workflow to show their relationship to the patient and potential research subject, the study, and the studies aims.

Funding for this project is provided by the National Cancer Institute.

_ToDo: Add link to the text of the grant application._

_ToDo: Add link to the consent for this study._

## Workflow and Use cases

### Clerk invites patient to the study in the waiting room

Alicia is a clerk in a family practice clinic in El Paso, Texas.  The clinic's population reflects El Paso's 80% hispanic population.  The patients she talks to each day are a mix of english, spanish, and bilingual speakers.  Alicia is herself bilingual and it benefits her greatly in her job.

Alicia's job is to assist patients as they arrive in the clinic.  Patients check in when they arrive at the clinic.  Alicia greets them and checks to see what forms they need to fill out before their clinic visit.  Alicia will also try to get patients enrolled in the CCDA study.

Alicia asks each patient who has an appointment their age when they arrive in the clinic.  If the patient is  between 50 and 75 years of age, Alicia asks if the patient would like to participate in a research study of CRC screening.  If the patient expresses interest in the study, Alicia attaches the study's consent forms to the clipboard with the documents they need filled out for their clinic visit.

When the patient returns the clipboard, Alicia checks to see if the patient consented to the CCDA study.  If so she makes a note for the nurse to include the patient in the CCDA study.


### Nurse delivers the tablet to the patient in the clinic

Bob is a nurse in the family practice clinic.  He receives the paperwork for the next patient to enter the clinic.  He notes that the next patient, Clara, should be offered an tablet for the CCDA study.  He checks if one is available.  If it is, he takes it with him to the door when he calls Clara in.  Bob takes Clara's vitals, records them and escorts her to the patient room.  Before he leaves, he reminds Clara of the study and offers her the tablet so she can take the survey and watch the educational video.

_ToDo: Decide how the survey work will be tied to the consent.  This is an important in assuring the study's data collection process could pass an IRB audit._


### Patient interacts with CCDA App in the patient room

Clara is a patient in the family practice clinic.  She came today for routine visit.  She read the CCDA Study consent forms in the waiting room outside the clinic.  She had never heard of colorectal cancer before, but papers the clerk gave her said she might have it and not know about it.  That worried her so she wants more information.  She consented to the study to get more information about colorectal cancer.

The nurse, Bob, reminded her about the study as he escorted her to the patient room.  He handed her a tablet that's supposed to tell her about colorectal cancer, so she turns it on.

The app reviews Clara's eligibility, presents her with information about CRC screening, shows videos, and helps her decided which CRC screening procedure would be the best fit for her.

Clara reaches the end of the CCDA App.  The app tells her that her opinions suggest sigmoidoscopy would be the best CRC screening option for her.  Clara puts the tablet down and continues waiting in the patient room until Dr. Dan arrives.

The workflow of the application is described in [CCDA Application Workflow](ccda-app-workflow.md).  Please refer to that document to see what Clara experiences with the app.


### Clinician meets with patient in the patient room

Dr. Dan is a physician in the family practice clinic.  On a good day he sees 25 patients, but it's usually more.  He often finds his patients are not aware of preventative health care options that could benefit them.  He would like to spend time with each patient to teach them the value of prevention, but he has little time to do this after addressing the need that brought them into the clinic.  He welcomes any chance to available to educate his patients and motivate them to be proactive in their own health.

Dr. Dan is aware his next patient, Clara, is in the office for a wellness visit.  There is a note on her chart that says she is participating in the CCDA study.  When he enters the patient room,  he greets Clara and asks her how she is doing.  In the ensuing conversation he points out the tablet and asks Clara if she has questions about CRC.  Clara mentions that the app recommended sigmoidoscopy and asks if he thinks that is a good idea.  Dr. Dan reinforces the message of the video and decision aid result.  He offers Clara a referral to doctor that can perform the procedure.  Clara says she would like that and asks if there is a flyer on CRC she can share with her sister.


### Co-PI, Elena, wants to better outcomes and better methods

Elena is an oncologist.  She understands the value of CRC screening in preventing death from CRC.  She wants to increase CRC screening rates to save lives and improve quality of life.


### Co-PI, Floyd, wants better outcomes and better methods

Floyd, is the Co-PI, and informaticist on the CCDA study.  He is a computer scientist and tenure track faculty at his university.  He wants to demonstrate that education about CRC and CRC screening can improve CRC screening rates in a population.  As the author of the decision making component of the CCDA App, Floyd wants to demonstrate that his algorithms have value to the project.

Floyd hopes the results of this study can be used in his next funding proposal.  As such, he is always looking for ways to improve the work.  He theorizes that some criteria in the surveys are more important that others.  He hopes to find this in his data to allow the survey to be reduced to the most effective questions.

To achieve these goals Floyd needs good data from the CCDA app.


### Biostatistician analyzes survey data

Ginny is a biostatistician on the CCDA project.  She uses SPSS and SAS to run analyses for PIs, Erin and Frank.  She processes data for lots of projects. She can handle lots of data types, but most of her collaborators send her comma-separated-variable files.

She doesn't like surprises, so asks for preliminary data whenever she can get it. It allows her to draft scripts to do the data processing and locate data quality issues early.  She can provide feedback early to try to correct problems in the source data.  She likes getting data at intermediate steps as well to check if her advice has been heeded.

Ginny's asked to see updated data monthly so she can advise the investigators and be prepared for the analysis.  With the data processing work done early, she has more time to focus on the results when the final data arrives.
