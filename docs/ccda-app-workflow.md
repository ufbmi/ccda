# CCDA Application Workflow

## Authors

* Philip Chase <pbc@ufl.edu>


## Overview

*Colorectal Cancer Decision Aid Study* is a project to increase colorectal cancer (CRC) screen rates via educational tools and assess the efficacy of those tools.  The study uses surveys and informational text, videos and decision making algorithms to assess patient knowledge about CRC screening, inform patients about screening options and recommend a screening option for each patient.  Special emphasis is made in this study to address the particular needs of underrepresented spanish-speaking and english-speaking populations.

This document describes the workflow of the CCDA Application.  It describes the interaction from the patient's first contact with the application until it presents its assessment of her best CRC screening option.  This document focuses on the sequencing of components of the decision aid tool.  The workflow is almost completely linear to present the simplest possible interface to the patient.

See [Decision Aid Script](functional-spec-resources/1.Decision_Aid_Script_1-18-2015.docx) for the details that drive the sequencing of this workflow.

## Workflow

Clara is a patient in the family practice clinic.  She came today for a routine visit.  She read the CCDA Study consent forms in the waiting room outside the clinic.  She had never heard of colorectal cancer before, but papers the clerk gave her said she could have it and not know about it.  That worried her so she wants more information.  She consented to the study to get more information about colorectal cancer.

The nurse, Bob, reminded her about the study as he escorted her to the patient room.  He handed her a tablet computer and asked her to read through what it presents and answer the survey questions.

### Language Selection

Clara turns on the tablet and reads the first screen. The first screen is a simple, bilingual page asking her whether she wants to take the survey in Spanish or English.  She chooses Spanish.  The app responds be presenting the spanish version of each subsequent page.

_ToDo: Add a document that has this text in Spanish and English_

_ToDo: Add a link(s) to the document(s) that have this text in Spanish and English_

### Welcome and Introduction

The app then presents this text

1.  Welcome to this educational program about colorectal cancer and screening.
2.  You will be learning about this type of cancer and how to detect it early
3.  We will ask you a series of questions to learn a little more about you
4.  Then you will complete the education and decide what to do next.

_ToDo: Add a document that has this text in Spanish and English_

_ToDo: Add link(s) to the document(s) that have this text in Spanish and English_

### Eligibility Screening History

The survey then asks Clara to confirm her eligibility for the study with questions about her age and today's appointment.

The app may exit at this point telling Clara why she is ineligible, thanking for her time and exits.

If Clara meets the criteria, the app proceeds.

The app tells Clara about each of the 3 screening procedures: Fecal Occult Blood Test, Colonoscopy and Flexible Sigmoidoscopy.  For each it describes the procedure, asks Clara if she has heard of it, if she has ever had such a procedure, and when she thinks that might have been.

If Clara indicates she has had had a CRC screening, the app will tell Clara she is ineligible, tell her why, thank her for her time and exits.

_ToDo: Add a link(s) to the document(s) that have this text in Spanish_

_ToDo: Extract the English text from [Decision Aid Script](functional-spec-resources/1.Decision_Aid_Script_1-18-2015.docx)._


### Baseline Preferences

The app asks Clara which of the three tests she thinks would be right for her.

_ToDo: Add a link(s) to the document(s) that have this text in Spanish_

_ToDo: Extract the English text from [Decision Aid Script](functional-spec-resources/1.Decision_Aid_Script_1-18-2015.docx)._

### Baseline Survey

The app presents the WDA Baseline Survey to Clara.  This survey is a series of 89 questions. Each question is presented on its own page with a progress bar to show Clara her progress in the survey.

The precise text for the questions can be found in
[Baseline Survey in English](functional-spec-resources/2.e.Baseline_Survey_ENG_10.14.14.docx) and
[Baseline Survey in Spanish](functional-spec-resources/2.s.Baseline_Survey_Span_10.14.14.docx)


### Decision Conflict Scale

The app presents the Decision Conflict Scale.  This is two part survey offering Clara the choice of the three screening options followed by 10 questions about that decision.

The precise text for the questions can be found in
[Decision Conflict Scale in English](functional-spec-resources/4.e.DCS_LowLiteracy_English.pdf)
and
[Decision Conflict Scale in Spanish](functional-spec-resources/4.s.DCS_LowLiteracy_Spanish_US.pdf)


### SURE Test

The app presents decision conflict scale called the SURE Test.  This is a four-question survey to assist Clara in assessing any difficulty in the CRC screening making the decision.

The precise text for the questions can be found in
[SURE Test in English](functional-spec-resources/5.e.DCS_SURE_English.pdf)
and
[SURE Test in Spanish](functional-spec-resources/5.s.DCS_SURE_Spanish.docx)


### Preparation for Decision Making Scale

The app presents the Preparation for Decision Making Scale.  This is a 10-question survey.

The precise text for the questions can be found in
[Preparation for Decision Making Scale in English](functional-spec-resources/7.e.Preparation_for_DM_English.pdf)
and
[Preparation for Decision Making Scale in English](functional-spec-resources/7.s.Preparation_for_DM_Spanish.docx)

### Health Literacy

The app presents the questions from the CHEW Health Literacy Survey

The precise text for the questions can be found in
[CHEW Health Literacy Survey in Spanish and English](functional-spec-resources/3.es.CHEW_Health_Literacy_Eng_and_Span.docx)

### Numeracy

The app presents the questions from the Subjective Numeracy Scale

The precise text for the questions can be found in
[Subjective Numeracy Scale in English](functional-spec-resources/8.e.Subjective_Numeracy_Scale_Fagerlin_English.pdf)
and
[Subjective Numeracy Scale in Spanish](functional-spec-resources/8.s.Subjective_Numeracy_Scale_Fagerlin_Span.docx)

### Video Segment 1

_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

Display time index 3:02 - 3:58 from the video.

### Video Segment 2


_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

Display time index 6:42 - 7:17 from the video.


### Video Segment 3


_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

Display time index 14:19 - 14:53 from the video.

_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

### Display Decision Factors

The app presents a list of factors to consider when choosing the type of screening

_ToDo: identify the source of these factors and/or the precise text in Spanish and English._

### Video Segment 4 to help describe FIT

_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

Display time index 9:46 - 11:39 from the video.

### Describe Fecal Occult Blood Test

The app describes Fecal Occult Blood Test

_ToDo: Add a link(s) to the document(s) that have this text in Spanish and English_

### Video Segment 5 to help describe Colonoscopy

_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

Display time index 12:54 - 13:41 from the video.

### Describe Colonoscopy

The app describes Colonoscopy.

_ToDo: Add a link(s) to the document(s) that have this text in Spanish and English_


### Video Segment 6 to help describe Flexible Sigmoidoscopy

_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

Display time index 13:41 - 14:19 from the video.

_ToDo: How should we do the transition? Is text involved?  What video effects should be applied?_

### Describe Flexible Sigmoidoscopy

The app describes Flexible Sigmoidoscopy.

_ToDo: Add a link(s) to the document(s) that have this text in Spanish and English_

### Elicit Patient's Preference on Attributes

Present a survey to the patient contain 45-ish questions to assess their preference of CRC Screen procedure.

_ToDo: Add a link(s) to the document(s) that have this text in Spanish and English_

### Score survey answers to produce screening choice

_ToDo: Add link to the article that describes the algorithm_

### Present CRC Screening choice to patient

_ToDo: How do we want this presented?  Add a link(s) to the document(s) that have this text in Spanish and English_


### End of app

Clara reaches the end of the CCDA App.  The app tells her that her opinions suggest sigmoidoscopy would be the best CRC screening option for her.  Clara continues waiting in the patient room until the doctor arrives.

