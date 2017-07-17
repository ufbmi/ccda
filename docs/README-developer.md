# Developer's Notes

## Web interfaces

### Accessing the Development Environment

To access the development environment, open your web browser and access
[http://vagrant1/web/]()

This URL presents the contents of the ./web directory.


### Accessing the API Interface

To access the API interface, open your web browser and access
[http://vagrant1/api/v1/]()

This URL presents the contents of the `./api/v1/` directory.


## Database Notes

The development environment is equipped with a PHP Adminer interface to allow
easy access to manipulate the live database.

To access the MySQL Adminer interface, open your web browser and access
[http://vagrant2/]() Use these parameters:

    Username: root (or ccdaa)
    password: 123
    database: ccdaa


## Development Languages

For the front end we use Angular 1.x.  We are using Angular 1.x because
Angular 2.x does not get release until late 2015. We believe there will be
support for Angular 1.x through 2016, when this project reaches a milestone
where an Angular 2.x upgrade is feasible.

The backend aka the API, is written in **PHP 5.6.x**.
The backend database is **MySQL 5.6**.

More details about technical decisions see
[Technical Specification](./technical-specification.md)


## Coding style

We are going to keep our code centralized in a minimum number of files for
the sake of debugging.


## Virtual Machine Notes

A development environment is provided via virtual machine managed by
Vagrant 1.6+.  The Vagrant VM uses [Puphpet](https://puphpet.com/) to provision
the VM.  Configuration changes are made via the file
./vagrant/puphpet/config-custom.yaml

For custom shell script provisioners, the VM uses Puphpet's infrastructure at
`./vagrant/puphpet/files/`.  The directory `./vagrant/puphpet/files/exec-always`
is preferred to assure that scripts are run at every provisioning cycle.  This
requires that scripts be idempotent. I.e., they must be safely re-runable.


## Resetting Session Keys

The database is preloaded with several stored procedures for the app and
maintenance tasks.  Among these, clearAuthAndSession and insertSessionKey can be
used to (re)generate sessionKeys in the deployed database.
To reset, follow these steps:

1. Visit the ccdaa database at [http://vagrant2/?username=root&db=ccdaa]()
2. Scroll to the bottom of the page and select `clearAuthAndSession`, then click
"Call".
3. Revisit the ccdaa database at [http://vagrant2/?username=root&db=ccdaa]()
4. Again scroll to the bottom, but this time select `insertSessionKey`
5. Use the interface to add session keys as needed.
6. Note the keys you added for use when next logging in at http://vagrant1/web/


To test the application you will need "Pass Keys". You can read them from the
database using this query:

select id, sessions_id, token, passkey from authorization where name = 'ccdaa_session_token' limit 5;
+----+-------------+----------------------------------+---------+
| id | sessions_id | token                            | passkey |
+----+-------------+----------------------------------+---------+
|  2 |        NULL |                                  | 1234    |
|  3 |           1 | beef1e6576d29a07fdbac219d4e3b16a | 1234    |
|  4 |        NULL |                                  | 1234    |
|  5 |        NULL |                                  | 1234    |
|  6 |        NULL |                                  | 1234    |
+----+-------------+----------------------------------+---------+

## Generating Fixed Forms File

The application currently has the ability to load a project directly from the
API or from a file stored alongside of the API code.  The format for this file
is `applicationName_projectsid_languagesid.json`.

Example:

ccdaa_1_1.json (ccdaa is the applicationName, the first 1 is the
projects_id, and the second 1 is for language id #1, which is English)

There are two ways to generate this file.  The first is a simple curl action to
get the project from the API.  You will need an active session number from the
database.

TODO: Finish this section

## Apache self-signed cert

The Apache self-signed certificate and key at ./vagrant/certs/vagrant1/
were generated with this command:

    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
      -keyout apache.key \
      -out apache.crt \
      -subj '/C=US/ST=Florida/L=Gainesville/CN=vagrant1'

The certificate is good until June of 2025.  It is not likely to need update,
but the command above provides a template for this and other certficate creation
work.


## Database Updates

All changes to the database design and data required to run the application must
be documented in version control in the form of SQL statements that create,
alter, drop, insert, delete, update, etc. the database.  These changes must be
stored in the ./sql folder. Specifically the changes should be in folders that
identify the date and/or version number number of the release to which they
apply.  If contents of the .sql files in those folders must be executed in a
prescribed sequence, the sequence must be obvious and simply to apply at
deployment.


## Database Dump Files

Whenever the database changes are made, a complete dump of the required database
structure and content should be made an added to version control.  Such database
dump files should be added to the ./sql folder along with the database update
files described above.  These files are provided for the CCDAA application:

* **ccdaa.sql** - a database structure dump with tables, stored procedures but no
data. This file is dumped with appropriate switches to delete and recreate each
component if they exist.
* **ccdaa\_sample\_data.sql** - a data dump of the _data_ required to show a sample
survey.  This data set is minimal dataset with no collected data, logging or
auditing data.  This dump assumes completely empty tables.
* **ccdaa\_all.sql** - a concatenation of the above two tables and appropriate
foreign constraint switches to allow tables to be allowed.  This file is
generated form the above two files by a shell script, `make_ccdaa_all.sh`.

Scripts to generate all of these files are included with this project.  In each
case, the script is intended to be executed in the VM.  Output is written to
`/sql` folder in the VM.  For local deployment this is a share of `./sql` in the
software repository and can be committed immediately from the repo on the host
machine.

In AWS deployment, the `/sql` is an _rsync_ of the `./sql` folder of the repo
and is _not_ linked back to host machine.  in AWS deployments the output of
these scripts should be transferred back to the `./sql` folder on the host for
addition to the software repo.

For each file above, run these scripts on the host:

* `ccdaa.sql - /sql/make_ccdaa.sh`
* `ccdaa_sample_data.sql - /sql/make_ccdaa_sample_data.sh`
* `ccdaa_all.sql - /sql/make_ccdaa_all.sh` (can be run on the host or the guest)

The scripts that must connect to the database will look for the password in the
environment variable `CCDAA_PASSWORD`. Set that variable to streamline their
use.

    `export CCDAA_PASSWORD=123`

## API Testing Suite with phpunit

To run command line tests, install phpunit and run the command `phpunit` from the root of the repository.  Test results will be written to testOutput/output.json


### Code Coverage and Coverage Reports

Install PHPUnit & XDebug alongside of your Apache/PHP Install.  There are a few
different methods of generating as well as viewing the test results for the API.

* To use the web display method #2, you must first add the /tests directory to
your Apache Configuration.  Simply add another directory for /var/www/ccdaa/tests
and make sure to include execution of PHP

# Generating the output data
* Go to /tests/api and run phpunit manually -> `phpunit`
* Go to the web site located at https://server_name/tests/api (the setting
  phpon="true" must be set in phpunit.xml under the /tests/api directory for the
  web page to generate its own content, otherwise it will fail if the output
  file does not exist)

# Viewing the output data
* Fancy Pass/Fail Data -> Go to https://server_name/tests/api/
* Basic Pass/Fail Data -> Go to https://server_name/tests/api/testOutput/ (NOTE: /testOutput a self configured path)
* Code Coverage Report -> Go to https://server_name/tests/api/testOutput/codeCoverage/ (NOTE: /testOutput a self configured path)


## Debugging the Web App

The web application supports debugging features to simplify testing.  All of these features are controled by editing web/app/config.js.

### Advance by Form

The normal flow of the survey is to visit each section (think page) of each form in order. This can be tedious when verifying form behavior. You can enable an additional set of navigation buttons that jump by form instead of by section.

    root_config = {
        "form_jump_buttons": true
    }

### Skip Required Fields

The survey tool has a feature to require certain fields be filled in before advancing to the next or previous forms.

    root_config = {
        "skip_required": true
    }

### Web app logging

AngularJS will generate additonal logging output in the browser console log if `debug_mode` is on.  This is a variable named `debug_mode` not an element of the root_config JSON object.

    debug_mode = true
