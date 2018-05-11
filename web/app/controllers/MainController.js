app.controller('MainController', ['$scope', '$rootScope', '$q', '$cookies', '$modal', '$route', '$location', '$window', function ($scope, $rootScope, $q, $cookies, $modal, $route, $location, $window) {
    var object_name = 'MainController';
    $scope.makeLog(4, object_name, 'Starting ' + object_name);

    $scope.$on('$locationChangeStart', function (event, next, current) {
      var nextPath = next;
      var currentPath = current;

      console.log("Next path is: " + nextPath);
      console.log("Current path is: " + currentPath);
    });

    $scope.config.media_playing = { 'id': false, 'time': 0, 'volume': 0 };
    $scope.config.media_library = {};

    $scope.config.current_section = null;

    $scope.controlMedia = function(id, method, playResets) {
      if(id) {
        console.log('Controlling Media Element (' + method + '): ' + id);
        var media_element = document.getElementById(id);
        if(method) {
          if(method == 'play') {
            if($scope.config.media_playing.id) {
              if($scope.config.media_playing.id != id) {
                if(document.getElementById($scope.config.media_playing.id)) {
                  $scope.controlMedia($scope.config.media_playing.id, 'pause');
                } else {
                  $scope.config.media_playing.id = false;
                  $scope.config.media_library[id] = false;
                }
              }
            }
            $scope.controlMedia(id, 'load');
            if(playResets) {
              media_element.currentTime = 0;
              $scope.config.media_playing.time = media_element.currentTime;
            }
            media_element.play();
          } else if(method == 'pause') {
            if($scope.config.media_playing.id) {
              if(document.getElementById($scope.config.media_playing.id)) {
                var old_media_element = document.getElementById($scope.config.media_playing.id);
                old_media_element.pause();
              }
            }
            $scope.config.media_playing.id = false;
            $scope.config.media_library[id] = false;
          } else if(method == 'stop') {
            $scope.controlMedia(id, 'pause');
            media_element.currentTime = 0;
            $scope.config.media_playing.time = media_element.currentTime;
          } else if(method == 'reset') {
            $scope.controlMedia(id, 'stop');
            $scope.controlMedia(id, 'play');
          } else if(method == 'load') {
            $scope.config.media_playing.id = id;
            $scope.config.media_library[id] = true;
          } else if(method == 'getState') {
            if($scope.config.media_library[id]) {
              return true;
            } else {
              return false;
            }
          }
        }
      }
    }

    $scope.redirect = function (new_path) {
        $rootScope.redirect(new_path);
    };

    $scope.getParam = function (param) {
		if ($routeParams) {
			if ($routeParams[param]) {
				return $routeParams[param];
			}
    }
	 };

    $scope.init = function (perform_authentication) {
        $scope.perform_authentication = perform_authentication;
        q1 = $scope.q1 = $q.defer(),
            p1 = $scope.q1.promise;

        $scope.data = $q.all([
          p1.then($rootScope.getData)
        ]).then(function (values) {
            $scope.makeLog(4, object_name, 'Retrieved site data from API for session check');
            $scope.site_data = values;
        });

        setTimeout(function () {
            $scope.$apply(function () {
                $scope.makeLog(4, object_name, 'Sending site data to API for session check');
                q1.resolve({
                    method: 'POST',
                    resource_link: $rootScope.config.api_url + 'init/',
                    post_data: {
                        app_name: $rootScope.config.app_name
                    },
                    headers: {
                        'key': $rootScope.config.api_key
                    }
                });
            });
        }, service_timeout, this);
    };

    $scope.checkSession = function () {
        q1 = $scope.q1 = $q.defer(),
            p1 = $scope.q1.promise;

        $scope.data = $q.all([
          p1.then($rootScope.getData)
        ]).then(function (values) {
            $scope.makeLog(4, object_name, 'Retrieved session data from API for session check');
            $scope.session_data = values;
        });

        setTimeout(function () {
            $scope.$apply(function () {
                $scope.makeLog(4, object_name, 'Sending session data to API for session check');
                q1.resolve({
                    method: 'POST',
                    resource_link: $rootScope.config.api_url + 'check/',
                    post_data: {
                        'app_name': $rootScope.config.app_name
                    },
                    headers: {
                        'key': $cookies['token']
                    }
                });
            });
        }, service_timeout, this);
    };

    $scope.loadProject = function () {
        q1 = $scope.q1 = $q.defer(),
            p1 = $scope.q1.promise;

        var data = $q.all([
          p1.then($rootScope.getData)
        ]).then(function (values) {
            $scope.makeLog(4, object_name, 'Retrieved projects data from API');
            $scope.projects_data = values;
        });

        setTimeout(function () {
            $scope.$apply(function () {
                $scope.makeLog(4, object_name, 'Sending projects data to API');
                q1.resolve({
                    method: 'GET',
                    resource_link: $rootScope.config.api_url + 'get/projects/app_name=' + $rootScope.config.app_name + '&projects_id=' + $rootScope.config.project.id + '&languages_id=' + $rootScope.config.site.selected_language.id,
                    headers: {
                        'key': $cookies['token']
                    }
                });
            });
        }, service_timeout, this);
    };

    $scope.loadForms = function () {
        //var sections_id = $scope.getParam('sections_id');
        // + '&sections_id=' + sections_id

        var resource_link = '';
        if($rootScope.config.use_fixed_file) {
          resource_link = $rootScope.config.app_name + '_' + $rootScope.config.project.id + '_' + $rootScope.config.site.selected_language.id + '.json';
        } else {
          resource_link = 'get/forms/app_name=' + $rootScope.config.app_name + '&projects_id=' + $rootScope.config.project.id + '&languages_id=' + $rootScope.config.site.selected_language.id + '&cache=1';
          console.log("link " + resource_link);
        }

        q1 = $scope.q1 = $q.defer(),
            p1 = $scope.q1.promise;

        var data = $q.all([
          p1.then($rootScope.getData)
        ]).then(function (values) {
            $scope.makeLog(4, object_name, 'Retrieved forms data from API');
            $scope.forms_data = values;
        });

        setTimeout(function () {
            $scope.$apply(function () {
                $scope.makeLog(4, object_name, 'Sending forms data to API');
                q1.resolve({
                    method: 'GET',
                    resource_link: $rootScope.config.api_url + resource_link,
                    headers: {
                        'key': $cookies['token']
                    }
                });
            });
        }, service_timeout, this);
    };

    $scope.authenticate = function () {
        if (($rootScope.config.site) && ($rootScope.config.project)) {
            if (($rootScope.config.site.id) && ($rootScope.config.project.id)) {
                var modalInstance = $modal.open({
                    animation: false,
                    templateUrl: 'authentication.html',
                    controller: 'AuthenticationController',
                    keyboard: false,
                    backdrop: 'static',
                    size: 'sm',
                    resolve: {}
                });

                modalInstance.result.then(function () {
                    $scope.makeLog(4, object_name, 'Modal submitted at: ' + new Date());
                }, function () {
                    $scope.makeLog(4, object_name, 'Modal dismissed at: ' + new Date());
                    $scope.redirect('/');
                });
            } else {
                $scope.redirect('/');
            }
        } else {
            $scope.redirect('/');
        }
    };

    $scope.defineProjectsList = function (languages_id) {
        console.log('Set languge to: ' + languages_id);
        $scope.projects_list = [];
        for (var x = 0; x < $scope.projects.length; x++) {
            var this_project = $scope.projects[x];
            if (!Array.isArray($scope.projects_list[this_project.id])) {
                $scope.projects_list[this_project.id] = [];
            }
            $scope.projects_list[this_project.id].push(this_project);
            $scope.projects_list[this_project.id].id = this_project.id;
            if (this_project.languages_id === languages_id) {
                $scope.projects_list[this_project.id].default = {};
                $scope.projects_list[this_project.id].default.title = this_project.title;
                $scope.projects_list[this_project.id].default.description = this_project.description;
            }
        }
    };

    $scope.start = function (sites_id, projects_id) {
        console.log('Starting Site: ' + sites_id);
        console.log('Starting Project: ' + projects_id);
        console.log('Deleting session token: ' + $cookies['token']);
        delete $cookies['token'];
        delete $cookies['language.id'];
        delete $cookies['language.title'];
        $rootScope.config.project = {};
        $rootScope.config.project.id = projects_id;
        $scope.redirect('/start/');
    };

    $scope.parseJson = function(string_to_parse) {
      if(string_to_parse) {
        // var stringified_string = JSON.stringify(string_to_parse);
        return JSON.parse(string_to_parse);
      } else {
        return null;
      }
    }

    $scope.selectSessionLanguage = function (languages_id) {
        q1 = $scope.q1 = $q.defer(),
            p1 = $scope.q1.promise;

        $scope.data = $q.all([
          p1.then($rootScope.getData)
        ]).then(function (values) {
            $scope.makeLog(4, object_name, 'Retrieved language data from API for setting the language');
            $scope.set_language_data = values;
        });

        setTimeout(function () {
            $scope.$apply(function () {
                $scope.makeLog(4, object_name, 'Sending language data to API for setting the language');
                q1.resolve({
                    method: 'POST',
                    resource_link: $rootScope.config.api_url + 'update/sessions/json/',
                    post_data: {
                        'app_name': $rootScope.config.app_name,
                        'languages_id': languages_id
                    },
                    headers: {
                        'key': $cookies['token']
                    }
                });
            });
        }, service_timeout, this);
    };

    $scope.updateAnswer = function(answer_data) {
      q1 = $scope.q1 = $q.defer(),
          p1 = $scope.q1.promise;

      $scope.data = $q.all([
        p1.then($rootScope.getData)
      ]).then(function (values) {
          $scope.makeLog(4, object_name, 'Retrieved responses data from API');
          $scope.responses_data = values;
      });

      setTimeout(function () {
          $scope.$apply(function () {
              $scope.makeLog(4, object_name, 'Sending responses data to API');
              q1.resolve({
                  method: 'POST',
                  resource_link: $rootScope.config.api_url + 'update/responses/json/',
                  post_data: {
                      'app_name': $rootScope.config.app_name,
                      'answer_data': answer_data
                  },
                  headers: {
                      'key': $cookies['token']
                  }
              });
          });
      }, service_timeout, this);
    };

    $scope.updateSessionLanguage = function () {
        $cookies['language.id'] = $rootScope.config.site.selected_language.id;
        if ($rootScope.config.site.preferences_languages.length > 0) {
            for (var x = 0; x < $rootScope.config.site.preferences_languages.length; x++) {
                var this_language = $rootScope.config.site.preferences_languages[x];
                if (this_language.id == $rootScope.config.site.selected_language.id) {
                    $rootScope.config.site.selected_language.title = this_language.title;
                    $rootScope.config.site.selected_language.abbreviation = this_language.abbreviation;
                }
            }

            $scope.makeLog(4, object_name, 'Updating session language information: ', $rootScope.config.site.selected_language);
            $cookies['language.title'] = $rootScope.config.site.selected_language.title;

            $scope.loadProject();
        }
    };

    $scope.begin = function(forms_id, start_from_end) {
      if(!forms_id) {
        $scope.survey_started = true;
        $scope.begin($scope.forms_data[0].data.results[0].id);
      } else {
        $scope.form_started = forms_id;
        for(var x=0;x<$scope.forms_data[0].data.results.length;x++) {
          var this_form = $scope.forms_data[0].data.results[x];

          $rootScope.config.forms.version = this_form.version;

          if(this_form.id == forms_id) {
            $scope.makeLog(4, object_name, 'Matched ' + this_form.id + ' to ' + forms_id);
            this_form.options.show = true;

            if(this_form.sections.length > 0) {
              $scope.sections_count = this_form.sections.length;
              $scope.progress_sections = 0;
              var last_section = null;
              var last_section_assigned = false;
              for(var y=0;y<this_form.sections.length;y++) {
                var this_section = this_form.sections[y];
                if(start_from_end) {
                  if(this_section.parameters.type=='send_to_api') {
                    if(!last_section_assigned) {
                      last_section = this_form.sections.length-2;
                      last_section_assigned = true;
                    }
                  } else {
                    if(!last_section_assigned) {
                      last_section = this_form.sections.length-1;
                    }
                  }

                  $scope.at_section = (y+1);
                  if(y == last_section) {
                    this_section.options.show = true;
                    this_section.options.isOpen = true;
                    this_section.options.isDisabled = true;
                  } else {
                    this_section.options.show = false;
                    this_section.options.isOpen = false;
                    this_section.options.isDisabled = true;
                  }
                } else {
                  $scope.at_section = 1;
                  if(y == 0) {
                    this_section.options.show = true;
                    this_section.options.isOpen = true;
                    this_section.options.isDisabled = true;
                  } else {
                    this_section.options.show = false;
                    this_section.options.isOpen = false;
                    this_section.options.isDisabled = true;
                  }
                }
              }
            }
          } else {
            $scope.makeLog(4, object_name, 'Did not match ' + forms_id);
            this_form.options.show = false;
            if(this_form.sections.length > 0) {
              for(var y=0;y<this_form.sections.length;y++) {
                var this_section = this_form.sections[y];
                this_section.options.show = false;
                this_section.options.isOpen = false;
                this_section.options.isDisabled = true;
              }
            }
          }
        }
      }
    };

    $scope.forms_order = [];
    $scope.sections_order = [];
    $scope.questions_order = [];

    $scope.api_response = false;
    $scope.api_response_data = null;

    $scope.submit_section = function(object_name, this_form, this_section, current_sections_id) {
      if(this_section.id == current_sections_id) {
        $scope.sections_order[this_section.id] = {'section': this_section.id, 'previous_section': this_section.previous_sections_id, 'next_section': this_section.next_sections_id};

        if(!$scope.answer_data[this_form.id][this_section.id]) {
          $scope.answer_data[this_form.id][this_section.id] = {};

          $scope.answer_data[this_form.id][this_section.id].header = {};
          $scope.answer_data[this_form.id][this_section.id].header.forms_id = this_form.id;
          $scope.answer_data[this_form.id][this_section.id].header.sections_id = this_section.id;
          $scope.answer_data[this_form.id][this_section.id].header.languages_id = $rootScope.config.site.selected_language.id;
          $scope.answer_data[this_form.id][this_section.id].header.session = $cookies['token'];
        }

        if(this_section.questions.length > 0) {
          //alert('Questions: ' + this_section.questions.length);
          for(var z=0;z<this_section.questions.length;z++) {
            var this_question = this_section.questions[z];
            $scope.questions_order[this_question.id] = {'question': this_question.id, 'previous_question': this_question.previous_questions_id, 'next_question': this_question.next_questions_id};

            if(!$scope.answer_data[this_form.id][this_section.id][this_question.id]) {
              $scope.answer_data[this_form.id][this_section.id][this_question.id] = {};
            }

            if(this_question.answer_data) {
              if(this_question.answer_data.id) {
                $scope.answer_data[this_form.id][this_section.id][this_question.id] = { 'key': this_question.answer_data.id, 'value': this_question.answer_data.id };
              } else {
                if(this_question.answer_data.value) {
                  $scope.answer_data[this_form.id][this_section.id][this_question.id] = { 'key': null, 'value': this_question.answer_data.value };
                }
              }
            }
          }
        }

        // This is where the app will check to see if the form section is defined as 'send_to_api'
        // It will collect the parameters for the call the API and send data, waiting for a response
        if(this_section.parameters) {
          if(this_section.parameters.type) {
            if(this_section.parameters.type == 'send_to_api') {
              // alert('sending additional data to the API');
              $scope.makeLog(4, object_name, 'Sending additional data to the API for scoring');

              $scope.answer_data[this_form.id][this_section.id].header.external_data = this_section.options;
            }
          }
        }

        $scope.makeLog(4, object_name, 'Sending Responses: ', $scope.answer_data[this_form.id][this_section.id]);
        $scope.updateAnswer($scope.answer_data[this_form.id][this_section.id]);
      }
    };

    $scope.next = function(current_sections_id, move_to_sections_id, backward) {

      // Check to see if any audio or video is playing and pause it
      if($scope.config.media_playing.id) {
        console.log('Pausing media: ' + $scope.config.media_playing.id);
        $scope.controlMedia($scope.config.media_playing.id, 'pause');
      }

      if(!$scope.answer_data) {
        $scope.answer_data = {};
      }

      $scope.config.current_section = current_sections_id;
      if((current_sections_id) && (move_to_sections_id)) {
        //alert('Forms: ' + $scope.forms_data[0].data.results.length);
        for(var x=0;x<$scope.forms_data[0].data.results.length;x++) {
          var this_form = $scope.forms_data[0].data.results[x];
          $scope.forms_order[this_form.id] = {'form': this_form.id, 'previous_form': this_form.previous_forms_id, 'next_form': this_form.next_forms_id};

          if(!is_array($scope.answer_data[this_form.id])) {
            $scope.answer_data[this_form.id] = {};
          }

          if(this_form.id == $scope.form_started) {
            for(var y=0;y<this_form.sections.length;y++) {
              var this_section = this_form.sections[y];

              $scope.submit_section(object_name, this_form, this_section, current_sections_id);

              // If the section in this iteration matches the sections being moved to
              // then we need to set the new sections show and isOpen states to true
              // If this is a step 'backward', then we need to retract the at_section counter
              // and retract progress on the progress bar. The opposite occurs if this is not
              // a step backward (aka forward). If the section in this iteration does
              // not match, then set its show and isOpen states as false. This causes
              // display of the next section, and hides all others
              if(this_section.id == move_to_sections_id) {
                this_section.options.show = true;
                this_section.options.isOpen = true;
                if(backward) {
                  $scope.api_response = false;
                  $scope.api_response_data = null;

                  $scope.at_section--;
                  $scope.progress_sections = $scope.progress_sections - (100 / $scope.sections_count);
                } else {
                  $scope.api_response = false;
                  $scope.api_response_data = null;

                  $scope.at_section++;
                  $scope.progress_sections = (100 / $scope.sections_count) + $scope.progress_sections;
                }
              } else {
                this_section.options.show = false;
                this_section.options.isOpen = false;
              }
            }
          }
        }
      } else {

        for(var x=0;x<$scope.forms_data[0].data.results.length;x++) {
          var this_form = $scope.forms_data[0].data.results[x];
          $scope.forms_order[this_form.id] = {'form': this_form.id, 'previous_form': this_form.previous_forms_id, 'next_form': this_form.next_forms_id};

          if(!is_array($scope.answer_data[this_form.id])) {
            $scope.answer_data[this_form.id] = {};
          }

          if(this_form.id == $scope.form_started) {
            for(var y=0;y<this_form.sections.length;y++) {
              var this_section = this_form.sections[y];
              $scope.submit_section(object_name, this_form, this_section, current_sections_id);
            }

            if(this_form.parameters) {
              if(this_form.parameters.type) {
                if(this_form.parameters.type == 'final_data_submission') {
                  if(!backward) {
                    $scope.progress_sections = (100 / $scope.sections_count) + $scope.progress_sections;

                    var reloading = true;
                    $window.location.reload();
                  }
                }
              }
            } else {
              var reloading = false;
            }
          }
        }


        if(!reloading) {
          $scope.makeLog(4, object_name, 'Start next form: ', $scope.forms_order[$scope.form_started]);
          if(backward) {
            $scope.api_response = false;
            $scope.api_response_data = null;

            $scope.at_form--;
            $scope.progress_forms = $scope.progress_forms - (100 / $scope.forms_count);

            $scope.begin($scope.forms_order[$scope.form_started]['previous_form'], true);
          } else {
            $scope.at_form++;
            $scope.progress_forms = $scope.progress_forms + (100 / $scope.forms_count);

            $scope.begin($scope.forms_order[$scope.form_started]['next_form'], false);
          }

          $scope.api_response = false;
          $scope.api_response_data = null;

          if($scope.at_form > $scope.forms_count) {
            $scope.at_form = $scope.forms_count;
          }
        }
      }
    };

    $scope.$watch('session_data', function () {
        if ($scope.session_data) {
            if ($scope.session_data[0].data.error) {
                $scope.makeLog(4, object_name, 'API replied with session data: ' + $scope.session_data[0].data.message);
                console.log('Deleting session token: ' + $cookies['token']);
                delete $cookies['token'];
                $scope.makeLog(2, object_name, 'API denied session key from cookie, deleting cookie and returning to root');
                $scope.redirect('/');
            } else {
                if ($scope.session_data.length > 0) {
                  if($scope.session_data[0].data.results.length > 0) {
                    $scope.makeLog(4, object_name, 'API returned session data: ', $scope.session_data[0].data.results);
                    if ($cookies['language.id']) {
                        $rootScope.config.site.selected_language = {};
                        $rootScope.config.site.selected_language.id = $scope.session_data[0].data.results[0].languages_id;

                        $scope.updateSessionLanguage();
                    }

                    $scope.enable_language_selection = true;
                    $rootScope.config.project = {};
                    $rootScope.config.project.id = $scope.session_data[0].data.results[0].projects_id;
                  }
                }
            }
        }
    });

    // This watch manages the data retrieved from the $scope.init method
    $scope.$watch('site_data', function () {
        if ($scope.site_data) {
            if ($scope.site_data[0].data.error) {
                $scope.makeLog(2, object_name, 'API replied with site data: ' + $scope.site_data[0].data.message);

                // No data returned from the API, needed to set default configuration
                $scope.site_error = $scope.site_data[0].data.message;
                $scope.site_loaded = false;

                $rootScope.config.site = [];
                $rootScope.config.site.title = 'Site Error';
                $rootScope.config.site.description = $scope.site_error;
            } else {
                $scope.makeLog(4, object_name, 'API returned site data: ', $scope.site_data[0].data.results[0]);
                $scope.site_error = null;
                $scope.site_loaded = true;
                var site_version = $rootScope.config.site.version;
                $rootScope.config.site = $scope.site_data[0].data.results[0];

                if($rootScope.config.site.options.audio_src) {
                  for(var xy=0;xy<$rootScope.config.site.options.audio_src.length;xy++) {
                    $rootScope.config.site.options.audio_src[xy] = JSON.parse($rootScope.config.site.options.audio_src[xy]);
                  }
                }

                $rootScope.config.site.version = site_version;
                $rootScope.config.api.version = $scope.site_data[0].data.version;

                $scope.preferences_languages = $scope.site_data[0].data.results[0].preferences_languages;

                $scope.default_language = "1";
                for (var x = 0; x < $scope.preferences_languages.length; x++) {
                    var this_language = $scope.preferences_languages[x];
                    if (this_language.default == "1") {
                        $scope.default_language = this_language.id;
                    }
                }

                // Group the projects list by id, which should create a list of the projects title in whatever languages were selected
                $scope.projects = $scope.site_data[0].data.results[0].projects;
                $scope.defineProjectsList($scope.default_language);

                if ($cookies['token']) {
                    // Check the token
                    $scope.checkSession();
                } else {
                    // Get a new token
                    if ($scope.perform_authentication) {
                        $scope.authenticate($scope.config.site.id);
                    }
                }
            }
        } else {
            $scope.makeLog(4, object_name, 'No site data was received');
        }
    });

    // This watch manages the data retrieved from the $scope.loadProject method
    $scope.$watch('projects_data', function () {
        if ($scope.projects_data) {
            if ($scope.projects_data[0].data.error) {
                $scope.makeLog(4, object_name, 'API replied with projects data: ' + $scope.projects_data[0].data.message);
                $scope.project_error = $scope.projects_data[0].data.message;
                $scope.project_loaded = false;
            } else {
                if ($scope.projects_data.length > 0) {
                    $scope.makeLog(4, object_name, 'API returned projects data: ', $scope.projects_data[0].data.results);
                    $scope.project_error = null;
                    $scope.project_loaded = true;

                    $rootScope.config.project.title = $scope.projects_data[0].data.results[0].title;
                    $rootScope.config.project.description = $scope.projects_data[0].data.results[0].description;
                    $rootScope.config.project.options = $scope.projects_data[0].data.results[0].options;
                    $rootScope.config.project.parameters = $scope.projects_data[0].data.results[0].parameters;
                    $rootScope.config.project.instructions = JSON.parse($scope.projects_data[0].data.results[0].instructions);
                    $rootScope.config.project.begin = $scope.projects_data[0].data.results[0].begin;

                    $scope.survey_started = false;
                    $scope.progress_forms = 0;
                    $scope.progress_sections = 0;
                    $scope.loadForms();
                }
            }
        }
    });

    // This watch manages the data retrieved from the $scope.loadForms method
    $scope.$watch('forms_data', function () {
        if ($scope.forms_data) {
            if ($scope.forms_data[0].data.error) {
                $scope.makeLog(4, object_name, 'API replied with forms data: ' + $scope.forms_data[0].data.message);
                $scope.forms_error = $scope.forms_data[0].data.message;
                $scope.forms_loaded = false;
            } else {
                if ($scope.forms_data.length > 0) {
                    $scope.makeLog(4, object_name, 'API returned forms data: ', $scope.forms_data[0].data.results);
                    $scope.forms_error = null;
                    $scope.forms_loaded = $scope.forms_data[0].data.results[0].id;

                    $scope.forms_count = $scope.forms_data[0].data.count;
                    $rootScope.config.api.version = $scope.forms_data[0].data.version;
                    $scope.at_form = 1;
                }
            }
        }
    });

    $scope.$watch('responses_data', function() {
      if($scope.responses_data) {
        if($scope.responses_data[0].data.error) {
          $scope.makeLog(4, object_name, 'API replied with setting answer data: ' + $scope.responses_data[0].data.message);
        } else {
          $scope.makeLog(4, object_name, 'API replied with setting answer data: ', $scope.responses_data[0].data.results);
          if($scope.responses_data.length > 0) {
            if($scope.responses_data[0].data.results) {
              if($scope.responses_data[0].data.results.results) {
                console.log('Received a response from the API with scoring data');
                $scope.api_response = true;
                $scope.api_response_data = $scope.responses_data[0].data.results.results;
              } else {
                console.log('Scoring data is loading');
                $scope.api_response = false;
              }
            } else {
              console.log('No scoring data from the API (maybe none expected)');
              $scope.api_response = false;
            }
          } else {
            $scope.got_api_response = false;
          }
        }
      }
    });

    $scope.$watch('set_language_data', function () {
        if ($scope.set_language_data) {
            if ($scope.set_language_data[0].data.error) {
                $scope.makeLog(4, object_name, 'API replied with setting session language data: ' + $scope.set_language_data[0].data.message);
            } else {
                if ($scope.set_language_data.length > 0) {
                    $scope.makeLog(4, object_name, 'API returned setting session language data: ', $scope.set_language_data[0].data.results);
                    $rootScope.config.site.selected_language = {};
                    $rootScope.config.site.selected_language.id = $scope.set_language_data[0].data.results.languages_id;
                    $cookies['language.id'] = $rootScope.config.site.selected_language.id;

                    $scope.updateSessionLanguage();
                }
            }
        }
    });

    $scope.$watch('rootScope.config.site', function () {
        $scope.makeLog(4, object_name, 'Checking Site Data', $rootScope.config.site);
        if ($rootScope.config.site) {
            $scope.makeLog(4, object_name, 'Site data was loaded');
        } else {
            $scope.makeLog(1, object_name, 'No site data was loaded');
        }
    });

    $scope.parseHeaders = function(string) {
        var json_string = JSON.parse(string);
        $scope.makeLog(4, object_name, 'Parsed Headers', json_string);
        return json_string;
    };

    $scope.rankQuestion = function(min, max, number, method) {
      var new_number = null;
      if(method == 'increment') {
        new_number = (number + 1);
      } else if(method == 'decrement') {
        new_number = (number - 1);
      }

      if((new_number >= min) && (new_number <= max)) {
        return new_number;
      } else {
        return number;
      }
    };

    $scope.makeRange = function(min, max) {
      var return_array = [];
      for(var x=min;x<=max;x++) {
        return_array.push(x);
      }
      return return_array;
    }
}]);
