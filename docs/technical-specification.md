Technical Specification for the Colorectal Cancer Decision Aids Application

Project Goals:

* This application is designed to present an X step survey and instructional information, to a patient who has entered a clinic for various possible reasons.

* We intend to do the following...

    * Obtain verbal consent of the patient, to partake in this survey

    * Collect written consent to survey on paper

    * Present the patient with a device on which to take the survey

    * Present an initial set of questions to determine eligibility

    * Present instructional video clips and information regarding the survey

    * Present a series of questions to send to our formula for decision aid

    * Process the patients answers through our formula and return an answer to the patient, showing our assessment of their answers

    * Patient returns the device to our staff

    * All data is stored based on a session number, with no PHI, solely for data analysis

    * No authentication is required to access the application. 

# System Architecture & Infrastructure:

* **Server Specifications**

    * **Processor: **Single Core

    * **Memory:** 4GB

    * **Operating System:** Debian 7

* **Required Daemons**

    * **Web Server:** Apache 2

        * *Resource Version:* 2.4.12 ([Download](http://httpd.apache.org/download.cgi))

* **Front-End Application**

    * **Framework:** AngularJS

        * *Resource Version:* 1.3.14 ([CDN](https://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js))

    * **Supporting Libraries:** JQuery, Bootstrap

        * *Resource 1 Version:* 1.11.2 ([CDN](https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js))

        * *Resource 2 Version:* 3.3.2 ([CDN](https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css) for CSS, [CDN](https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js) for JS)

* **Back-End Application**

    * **Framework:** PHP

        * *Resource Version:* 5.6.6 ([Download](http://php.net/downloads.php#v5.6.6))

    * **Storage:** SQLite3

        * *Resource Version:* 3.8.8.4 ([Download](http://www.sqlite.org/download.html))

    * **Video Storage & Format:** File system storage & MP4 Format

        * *Required Space:* 500MB each (may require compression)

User Dialogs & Control Flow:

* Screen 1

    * Language Definition

* Screen 2

    * Eligibility Questions

    * User Preferences

* Screen 3

    * Instructional Video

    * Instructional Information

* Screen 4

    * Detailed Survey

* Screen 5

    * Presentation of Results

Background Tasks:

* Backups of the database

* Backups of the code base

* Any post-collection reporting/analysis of the user data

Database Model:

* Initially, the database will be housed in an SQLite3 database.  This will be transferred to a higher level of storage at a later date

* Table Structure:

    * Sessions

        * Session ID

        * Created Timestamp (for collection of start time)

        * IP Address (for security of session, session should originate and complete from the same location, best case scenario)

        * Updated Timestamp (for session maintenance and activity history)

    * Surveys

        * Session ID

        * Survey ID

        * Created Timestamp

        * Updated Timestamp

        * Status

    * Questions

        * Survey ID

        * Order

        * Text

        * Type

    * Answers

        * Survey ID

        * Session ID

        * Data

        * Timestamp

Interfaces to Other Systems:

* Computational API for delivering a scored response to a patient’s answers

# Application Deployment

* The client and server components should be deployed to one directory. Subdirectories containing client and server components will be presented separately by Apache alias entries in the server configuration.  

* The application will be deployed by git post receive hooks to allow standardized deployment without console access. 

Non-Functional Requirements:

* Data transfer should take place on an encrypted connection (SSL)

* Response time of the Computational API should be within (~5 seconds of request)

* Session management must be unique to a user, but session maintenance is not critical outside of the patient room

