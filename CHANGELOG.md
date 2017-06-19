# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.13.6] - 2015-11-02
### Changed
- Loosen language about OS and web server requirements in README-install.md (Philip Chase)
- Expand on requirements listed in installation notes (Philip Chase)

## [0.13.5] - 2015-10-04
### Changed
- Make shell scripts in ./sql executable (Philip Chase)
- unhyphenate extremadamente where it does not occur in the header (Philip Chase)

## [0.13.4] - 2015-10-03
### Changed
- Change mysqldump invocations to use .my.cnf (Philip Chase)
- 2015-09-22 Punchlist changes for spanish/engish. There are new images in the ccdaa_media repo that go with these changes for 0.13.4 (Roy Keyes)
- Fix reload issues at the end of the form, trying to fix the issue with the initial form load. Also, cleanup the directives a little, same goal. (Roy Keyes)
- Fix next/previous form buttons used for testing/debugging. (Roy Keyes)

### Removed
- Remove old code from the web/app/directives.js script to begin debugging the directives. (Roy Keyes)

## [0.13.3] - 2015-09-16
### Changed
- [104] Fix MDAT to save results to the responses table on next/previous. (Roy Keyes)

## [0.13.2] - 2015-09-16
### Changed
- [103] Set higher timeout for the service connections collecting data from the API (Roy Keyes)
- [102] Fix Spanish colonoscopy accuracy image link in the attributes list (Roy Keyes)
- [100,101] Fix Spanish next button text to show Siguiente instead of Hecho (Roy Keyes)


## [0.13.1] - 2015-09-16
### Changed
- Patch to fix next/previous form ids for form 2, which should correct the next/previous functionality on the forms. (Roy Keyes)
- Rename sql 'update' tools and output files to 'upgrade' (Philip Chase)

## [0.13.0] - 2015-09-16
### Changed
- Return only the latest response data in getResponsesForAll sproc (Philip Chase)
- Normalize response data to english text in getResponsesForAll sproc (Philip Chase)
- [69] Revise next/previous behavior to allow the user to traverse from one end of the app to the other. (Roy Keyes)
- Modify sql script for generating update.sql files, to add comments showing file names. (Roy Keyes)
- Change title in preferences_text from a varchar255 to a text type (Philip Chase)

### Added
- Add version control and handling for release-based sql updates to update-version-numbers-for-release.sh (Philip Chase)
- Add 'Extracting Data' section to README (Philip Chase)
- Document debugging options in README-developer.md (Philip Chase)
- [98] Add required field functionality and related data in forms
- Add old sql updates directory from 9/10, never got pushed. (Roy Keyes)
- Add ability to turn on/off the buttons allowing jumping from form to form, used for faster testing. (Roy Keyes)
- [74] Add updated image handler which can handle more than one image in a table as well as image alternate tags. (Roy Keyes)
- [78-85] Add copyright content for DCS, SURE, 'Preparation for Decision Making', and Acceptability forms (Philip Chase)


## [0.12.1] - 2015-09-04
### Changed
- [86-97] Fix bugs 86-97 correcting typos in Spanish text in Subjective Numeracy Scale, procedure descriptions, and preference elicitation sections, and any occurence of '[sic]'
- Fix permission and home directory detection in vagrant/puphpet/files/exec-always/edit-my-cnf.sh (Philip Chase)


## [0.12.0] - 2015-09-04
### Added
- Add puphpet script to write .my.cnf during provisioning (Philip Chase)
- Add form handlers for checkboxes (not complete, but not used) and ranking questions. (Roy Keyes)
- Update mysql invocations in documentation to reflect the use of .my.cnf file (Philip Chase)
- Add database redeployment script and sample .my.cnf file (Philip Chase)
- Add getopts tests to update-version-numbers-for-release.sh (Philip Chase)

### Changed
- [72] Fix bug 72, text change on Process of Change section in the Baseline Survey. (Roy Keyes)
- [52,67,68] Fix bugs 52,67,68. This includes correcting all audio for the preference elicitation sections. (Roy Keyes)
- Fix MainController media handler, fails to pause first screen audio after exit because the element was missing. (Roy Keyes)
- [8] Fix bug number 8 according to OMB standards. Run the sql/20150903/update.sql script for this patch. (Roy Keyes)


## [0.11.0] - 2015-09-03
### Added
- Update config.js.example code for removing the debugging panel on the main form screen. (Roy Keyes)

### Changed
- Add old tag name as a parameter in utils/update-version-numbers-for-release.sh to allow for sort order issues in the tag list (Philip Chase)
- [8,63,64,65,77] Fix bugs #8,63,64,65,77, addition of questions, correction of text on 2 sections, and correcting follow-up forms that did not have a perfect copy of their baseline counterparts. (Roy Keyes)
- Working on repairing the JSON ingest script. (Roy Keyes)
- Fix missing form instructions because of mispelled variable. (Roy Keyes)
- Fix the error where the icon for the main page was not being loaded. (Roy Keyes)
- Edit the main sprocs used to generate the objects in the form JSON data. (Roy Keyes)
- [48,49,50,57,66] Fix bugs #48,49,50,57,66 with question number sequencing issues as well as use the small audio for all matrix questions. (Roy Keyes)
- Update bootstrap source and files related to use the latest and stop using the bootstrap cdn. (Roy Keyes)
- [70] Fix bug #70, removing the additional 'begin' button that had to be pressed to start the first form. (Roy Keyes)

## Removed
- Remove fast debug flag from the config file for the angular app. (Roy Keyes)
- Remove the counter parameter for the getDetails method, no longer used. (Roy Keyes)


## [0.10.0] - 2015-08-31
### Added
- Add new dataTable audio handler and correct other handlers to show limited buttons. (Roy Keyes)
- Add audio files to forms: 01-03,05-16,17-30,31-44,45-58,59,61,62.
- New directive for videocontrol. (Roy Keyes)

### Changed
- Turn off form debugging hack (Philip Chase)
- Update SQL files with revised Sprocs and audio content clean up (Roy Keyes)
- Reformat forms and sections to remove empty description and instructions rows from the display panels. (Roy Keyes)
- Remove bad carriage returns from start.html (Roy Keyes)
- Remove fast form shortcut and prevent display of project welcome until the forms are loaded to prevent the misconception that the welcome screen loads twice. (Roy Keyes)
- Reinstate controller method that pauses audio on calling the next section method. (Roy Keyes)
- Fix error that prevented audio after the first screen. (Roy Keyes)
- Remove old projects code from the MyAPI library. (Roy Keyes)
- Fix form content bugs: 53,54,55,56,58,59,63 (Philip Chase)
- Add script to update version numbers for release i ./utils/ (Philip Chase)

### Removed
- Remove old audio/video controller methods and directives


## [0.9.0] - 2015-08-27
### Added
- Add new directives for handling tables, lists, and fix the audio handler. (Roy Keyes)
- Add new script for mass creation/copy of forms/sections/questions. (Roy Keyes)
- Update update.sql for 20140821 sql updates, adding new addAudioToObject sproc (Roy Keyes)
- New audio handling directive. (Roy Keyes)
- Add scripts for generating test datasets to be used in unit testing. (Roy Keyes)
- Add path to custom webPhpunit.xml file in the angular/phpunit testing suite. (Roy Keyes)
- Add new answer for higher than college to baseline survey questions 5-6 (Roy Keyes)
- Create script for building SQL update.sql files based on a directory of sql upgrade scripts. (Roy Keyes)
- Add unit test suite with autoloader and bootstrap for the API using PHPUnit. (Roy Keyes)
- Add Travis-CI testing of the web service (PHP) (Philip Chase)
- Create default phpunit.xml at root of repo (Philip Chase)

### Changed
- Improve audio/video handlers. (Roy Keyes)
- Fix getDetails/makeDetails to turn strings true/false to their boolean equivalent. (Roy Keyes)
- Modify the MyBase library to use the 'debug' config setting to determine whether the error_log method acts or simply just does not log to the filesystem. This will improve speed on the vagrant servers. (Roy Keyes)
- Update the API config.php.example with new layout. (Roy Keyes)
- Document the flag in MyAPI to disabled MyPDO initializing a connection to a real MySQL instance. (Roy Keyes)
- Fix make_update_sql script to remove comment line. (Roy Keyes)
- Repair MyAPI library response to saved questions, it now notifies the app properly that the data was saved. (Roy Keyes)
- Increase font on 'screen 1' of the application, the instructions page. (Roy Keyes)
- Fix the MyPDO library, force a timezone setting if not configured, set one if it was configured. (Roy Keyes)
- Add Silvia Flores as a content provider (Philip Chase)
- Expand on authentication needs and fix typos in README-install.md (Philip Chase)
- Streamline the getObject sprocs into 2 univeral sprocs and remove obfuscated getDetails sproc as well as removing unused columns from answers table. (Roy Keyes)
- Upgrade the API library to handle the new streamlined getObject sprocs. (Roy Keyes)
- Add cloaking to all angular variables inside of the html tags. (Roy Keyes)
- Update the gitignore file. (Roy Keyes)
- Change the angular/PHPUnit app controller to refer to the API by the config file. (Roy Keyes)
- Streamline the process of getting object details with the getDetails method. (Roy Keyes)
- Update all main libraries for the API to load with dependencies passed in at the constructor as well as no custom includes, also removed the LOGS_PATH global from being loaded inside the class to being passed to the constructor. (Roy Keyes)
- Change load of the main libraries for the API. (Roy Keyes)
- Move MyAPI from API root directory to /libs with all the other libraries, for testing sake. (Roy Keyes)
- Update the config.php.example with current settings. (Roy Keyes)
- Add exception for failure to load the config. Remove old csv_array conversion method. Add exception handling for the writeFile method. (Roy Keyes)
- Modify the MyAPI class to throw an exception instead of die on failure to load the configuration. (Roy Keyes)
- Add document blocks to methods in all classes for the API (Roy Keyes)
- Shorten lines docs/README-developer.md (Andrei Sura)

### Removed
- Removing namespace dependencies in index.php, root of API. (Roy Keyes)
- Removing namespace dependencies on api/libs and MyAPI. (Roy Keyes)


## [0.8.0] - 2015-08-06
### Added
- Add new survey content for DCS and SURE forms in both Spanish and English.
- Add report for showing a participants answers to their survey. (Roy Keyes)
- Add form building documentation and related queries (Roy Keyes)
- Add support for audio directives. (Roy Keyes)
- Add new sproc for reporting answers, changed name to getReportForAll.
- Add 2 new sprocs, one for getting answers, one for creating Key groups with just 2 parameters. (Roy Keyes)
- Add getAnswers sproc. (Philip Chase)

### Changed
- Make corrections on spanish and english text for baseline form.
- Restructure Preference Elicitation section. (Roy Keyes)
- Remove authorization table from DB dumps and adjust dump scripts and instructions to match (Philip Chase)
- Correct omissions in README-install.md (Philip Chase)
- Fix bug in Vagrantfile-aws to allow tags to be written the AWS instance (Philip Chase)


## [0.7.1] - 2015-07-17
### Changed
- Move README-install.md to docs and fix broken links in README.md (Philip Chase)
- Add ability for video to be reset on mp4video directives. (Roy Keyes)

### Added
- Add LICENSE and CONTRIBUTORS files (Alex Loiacono)
- Write manual deployment procedure in README-install.md, add supporting image, and make corresponding changed in README.md (Philip Chase)
- Add reportFormsAndSectionsByProjectsId stored procedure (Philip Chase)

### Removed
- Remove old htaccess files. (Roy Keyes)


## [0.7.0] - 2015-07-13
### Changed
- Reduce the permissions in the deployed application to a more restricted set (Philip Chase)
- Add fix for importing language based options from preferences_options. (Roy Keyes)
- Raise number of patient authorization records to 5000 (Philip Chase)
- Fix date error in CHANGELOG.md (Philip Chase)

### Added
- Add Spanish language text for all forms
- Added decision aid test characteristis english and spanish docs (Alex Loiacono)
- Add sql statements to fix language options for preferences_options to include spanish translation. (Roy Keyes)

### Removed
- Remove javascript error collection link from the footer. (Roy Keyes)
- Remove fixed form files english and spanish from the repository. (Roy Keyes)


## [0.6.0] - 2015-07-09
### Changed
- Remove nginx config from config.yaml of VM (Philip Chase)
- Move all web sites to SSL
- Give the web server group write access to all content below the document root. (Philip Chase)
- Update the sample data generation script to include new stored procedure for session generation. (Roy Keyes)
- Fix the progress bars used during changes in scenery. (Roy Keyes)

### Added
- Add new steps for handling answer data in the angular controller, and handling the answer data on the API side. (Roy Keyes)
- Sent data to and receive repsonses from MDAT, the Choquet Integral processing code.
- Add full save function to backup file and database for next and previous submits from the angular app. (Roy Keyes)
- Add question numbers to questions on all forms. (Roy Keyes)
- Add documentation for manual creation of a question. (Roy Keyes)
- Add documentation for manually building forms and sections. (Roy Keyes)
- Install python-pip and mdat during VM deployment (Philip Chase)
- Set hostname via provisioning script 'update-hostname.sh' and domain name parameter for that script (Philip Chase)
- Stub out README-install.md (Philip Chase)
- Redirect all traffic to SSL
- Redirect all URLs without a path to /web


## [0.4.1] - 2015-06-26
### Changed
- Add charset options back into sql dump files and the scripts that generate them (Philip Chase)
- Fix formatting error in CHANGELOG.md (Philip Chase)


## [0.4.0] - 2015-06-26
### Added
- Add post-preference elicitation/thank you form. (Roy Keyes)
- Add progress bars while loading the languages preference choice buttons. (Roy Keyes)
- Add bootstrap progress bar to authenticating wait message displayed while the modal for authentication is open. (Roy Keyes)
- Add bootstrap progress bar and loading text to loading directive template. (Roy Keyes)
- Add API version to the makeJSONOutput method. (Roy Keyes)
- Add version number for forms to forms table, included in new api/v1/ccdaa_1_1.json (Roy Keyes)
- Add parameter to create cached json version of a project to the API. (Roy Keyes)
- Add form and section text changes to previous/next buttons. (Roy Keyes)
- Add instructions for manual generation of the fixed forms file to the developers README file. (Roy Keyes)
- Ignore the videos directory via .gitignore. (Roy Keyes)

### Changed
- Add standard environment variable to password parameter in mysql commands in docs/README-database.md (Philip Chase)
- Reformat display of app,api,current form version numbers in the footer. (Roy Keyes)
- Relocate, reformat and fix form progress bars (Roy Keyes)

### Removed
- Remove unused bootstrap display of language buttons from welcome template. (Roy Keyes)
- Remove manual text 'loading' from the directive. (Roy Keyes)


## [0.3.1] - 2015-06-25
### Added
- Add scripts to make sql dump files for DDL and data and documentation on how to use them (Philip Chase)

### Changed
- Update database dump files based using new scripts at ./sql/make* (Philip Chase)


## [0.3.0] - 2015-06-24
### Added
- Add https support (Philip Chase)
- Add multiple sshkey support to AWS deployments (Philip Chase)
- Update the sql dump files. (Roy Keyes)
- Add Preference Elictation sections (Roy Keyes)
- Add video sections (Roy Keyes)
- Add fixed file load of forms from the API output (Roy Keyes)
- Replace synched folder entry for /var/www/ccdaa/ with specific entries for the web, api and videos subdirectory (Philip Chase)
- Add instructions for addressing the missing adminer folder in README.md (Philip Chase)
- Add new document docs/README-database.md describing Database Deployment and Maintenance (Philip Chase)
- Adding languages id to stored answer data (Roy Keyes)
- Forms controller is now sending data, not saving, just sending. (Roy Keyes)
- Finish baseline survey forms. (Roy Keyes)
- Add deployment to Amazon Web Services (Philip Chase)

### Changed
- Remove host file entries for crcdaa.org and crcdaa2.org to prevent conflicts with the AWS deployment DNS name (Philip Chase)
- Update sql/ccdaa_all.sql with new content from structural and data files (Philip Chase)
- Turn off foreign key constraints before inserting data in sql/make_ccdaa_all_sql.sh (Philip Chase)
- Turn off the apache default host (Philip Chase)
- Updated Angular framework to patch some errors. (Roy Keyes)
- Insert colonoscopy video slides at slide positions 23 and 24 in the file ccdaa-workflow.pptx (Philip Chase)
- Upgrade puphpet (Philip Chase)

## [0.2.0] - 2015-06-03
### Added
- Add script to make a combined ccdaa_all.sql file and revise Puphpet config to deploy it (Philip Chase)
- Add ./docs/README-developer.md and revise README.md to align it with the new doc (Philip Chase)
- Add Vagrant VM and updates to README.md to describe what it does and how to use it (Philip Chase)
- Add data-driven angular application with working controllers at ./web (Roy Keyes)
- Add DDL for app in ./sql/ccdaa.sql (Roy Keyes)
- Add sample data for app in ./sql/ccdaa_sample_data.sql (Roy Keyes)
- Add ERD diagram in ./sql folder (Roy Keyes)

### Changed
- Update CCDAA Workflow slides based on 2015-05-18 upload and current toolset (Philip Chase)
- Moved the original web prototype to demo. (Roy Keyes)


## [0.1.0] - 2015-03-30
### Added

- Add demo application (Roy Keyes)
- Add survey documents that need to be used in the construction of the CCDA App (Philip Chase)
- Add functional-specification.md and ccda-app-workflow.md (Philip Chase)
- Add documents that could assist in writing the technical and functional specs (Philip Chase)
