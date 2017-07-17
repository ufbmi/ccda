app.directive('myGreeting', function ($rootScope, $interval, $filter, dateFilter) {
    return function (scope, element, attrs) {

    };
});

app.directive('loading', ['$rootScope', function ($rootScope) {
  return {
    restrict: 'E',
    scope: {
      text: '@',
      type: '@'
    },
    templateUrl: 'assets/templates/loading.html',
    link: function(scope) {
      var object_name = 'LoadingDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('formpanel', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/formpanel.html',
    link: function() {
      var object_name = 'FormPanelDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('datatable', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/dataTable.html',
    link: function() {
      var object_name = 'DataTableDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('dataunorderedlist', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/dataUnorderedList.html',
    link: function() {
      var object_name = 'DataListDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('sections', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/sections.html',
    link: function() {
      var object_name = 'SectionsDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('mp4video', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_mp4video.html',
    link: function() {
      var object_name = 'Mp4Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('audioplayer', ['$rootScope', function ($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/audioPlayer.html',
    link: function(scope) {
      var object_name = 'AudioPlayerDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('imagine', ['$rootScope', function ($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/imagine.html',
    link: function(scope) {
      var object_name = 'ImagineDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('questionsmp3audio', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_mp3audio.html',
    link: function() {
      var object_name = 'Questions_Mp3Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('datatablemp3audio', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/dataTable_mp3audio.html',
    link: function() {
      var object_name = 'DataTable_Mp3Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('sectionsmp3audio', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/sections_mp3audio.html',
    link: function() {
      var object_name = 'Sections_Mp3Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('formsmp3audio', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/forms_mp3audio.html',
    link: function() {
      var object_name = 'Forms_Mp3Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('projectsmp3audio', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/projects_mp3audio.html',
    link: function() {
      var object_name = 'Projects_Mp3Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);

    }
  };
}]);

app.directive('sitesmp3audio', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/sites_mp3audio.html',
    link: function() {
      var object_name = 'Sites_Mp3Directive';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);

    }
  };
}]);

app.directive('youtubevideo', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_youtubevideo.html',
    link: function() {
      var object_name = 'YouTubeDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('questionstextbox', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_textbox.html',
    link: function() {
      var object_name = 'QuestionsTextboxDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('questionsdropdown', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_dropdown.html',
    link: function() {
      var object_name = 'QuestionsDropdownDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('questionsradiobutton', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_radiobutton.html',
    link: function() {
      var object_name = 'QuestionsRadioButtonDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('questionsranking', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_ranking.html',
    link: function() {
      var object_name = 'QuestionsRankingDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('questionscheckbox', ['$rootScope', function($rootScope) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'assets/templates/questions_checkbox.html',
    link: function() {
      var object_name = 'QuestionsCheckboxDirective';
      $rootScope.makeLog(4, object_name, 'Starting ' + object_name);
    }
  };
}]);

app.directive('focusMe', function($timeout) {
  return {
    scope: { trigger: '@focusMe' },
    link: function(scope, element) {
      scope.$watch('trigger', function(value) {
        if(value === "true") {
          $timeout(function() {
            element[0].focus();
          });
        }
      });
    }
  };
});

app.directive('project', function ($rootScope, $cookies, $q, GetDataService) {
  return {
    restrict: 'E',
    scope: false,
    templateUrl: 'app/views/projects.html',
    link: function($scope) {
      var object_name = 'ProjectDirective';

      $scope.project_loaded = false;
      $scope.load_project = function() {
      	var q1 = $scope.q1 = $q.defer(), p1 = $scope.q1.promise;

      	$scope.data = $q.all([
      		p1.then($rootScope.getData)
      	]).then(function(values) {
      		$scope.makeLog(4, object_name, 'Retrieved project data from API for session check');
      		$scope.project_data = values;
      	});

      	setTimeout(function () {
      		$scope.$apply( function() {
      			$scope.makeLog(4, object_name, 'Sending project data to API for session check');
      			q1.resolve({
      				method: 'GET',
      				resource_link: $rootScope.config.api_url + 'get/projects/projects_id=' + $scope.selected_project + '&languages_id=' + $scope.selected_language['id'],
      				headers: { 'key': $cookies['token'] }
      			});
      		});
      	}, 500, this);
      };

      $scope.$watch('project_data', function() {
    		if($scope.project_data) {
    			if($scope.project_data[0].data.error) {
    				$scope.makeLog(4, object_name, 'API replied with project data: ' + $scope.project_data[0].data.message);
            $scope.project_loaded = false;
    			} else {
    				if($scope.project_data.length > 0) {
    					$scope.makeLog(4, object_name, 'API returned project data: ', $scope.project_data[0].data.results);
              $rootScope.config.short_title = $scope.project_data[0].data.results[0].title;
              $scope.project_loaded = true;
    				}
    			}
    		}
      });

  	  $scope.load_project();
    }
  };
});

app.directive('autoplayonoff', function() {
    return {
    link: function($scope, $element, $attrs) {
        $scope.$watch(
            function () { return $element.attr('autoplay-attr-on'); },
            function (newVal) {
                var attr = $element.attr('autoplay-attr-name');

                if(!eval(newVal)) {
                    $element.removeAttr(attr);
                }
                else {
                    $element.attr(attr, attr);
                }
            }
        );
        }
    };
});

app.directive('controlsonoff', function() {
    return {
    link: function($scope, $element, $attrs) {
        $scope.$watch(
            function () { return $element.attr('controls-attr-on'); },
            function (newVal) {
                var attr = $element.attr('controls-attr-name');

                if(!eval(newVal)) {
                    $element.removeAttr(attr);
                }
                else {
                    $element.attr(attr, attr);
                }
            }
        );
        }
    };
});

app.directive('looponoff', function() {
    return {
    link: function($scope, $element, $attrs) {
        $scope.$watch(
            function () { return $element.attr('loop-attr-on'); },
            function (newVal) {
                var attr = $element.attr('loop-attr-name');

                if(!eval(newVal)) {
                    $element.removeAttr(attr);
                }
                else {
                    $element.attr(attr, attr);
                }
            }
        );
        }
    };
});

app.directive('audiocontrol', function(){
  return {
    scope: true,
    restrict: 'A',
    link: function(scope, element, attrs) {
      scope.$watch(attrs.audiocontrol, function() {
          var audio = element[0];
          if(audio.autoplay) {
            $(audio).bind('play', function() {
              // scope.controlMedia(audio.id, 'play');
            });
          }

          $(audio).bind('ended', function() {
            console.log('Unsetting current audio. Last clip was: ' + audio.id);
            scope.controlMedia(audio.id, 'stop');
            scope.$apply();
          });
      });
    }
  };
});

app.directive('videocontrol', function(){
  return function (scope, element, attrs) {
      scope.$watch(attrs.videoLoader, function(){
          var video = element[0];

          $(video).bind('play', function() {
            scope.controlMedia(video.id, 'play');
            scope.$apply();
          });

          $(video).bind('ended', function() {
            console.log('Unsetting current video. Last clip was: ' + video.id);
            scope.controlMedia(video.id, 'stop');
            scope.$apply();
          });
      });
  }
});

app.directive('ngEnter', function($document) {
   return {
     scope: {
       ngEnter: "&"
     },
     link: function(scope, element, attrs) {
       var enterWatcher = function(event) {
         if (event.which === 13) {
           scope.ngEnter();
           scope.$apply();
           console.log('ENTER');
           event.preventDefault();
           $document.unbind("keydown keypress", enterWatcher);
         }
       };
       $document.bind("keydown keypress", enterWatcher);
     }
   }
 });
