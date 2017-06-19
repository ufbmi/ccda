app.controller('MainController', ['$scope', '$rootScope', '$routeParams', 'GetDataService', 'LoggerService', '$q', '$interval', 'JSONFactory', '$location', '$cookies', function ($scope, $rootScope, $routeParams, GetDataService, LoggerService, $q, $interval, JSONFactory, $location, $cookies) {
	var object_name = 'MainController';

  $scope.responses = [];
	$scope.makeLog = function (level, name, message, object) {
		LoggerService.makeLog(level, name, message, object);
	};

	$scope.getParam = function (param) {
		if ($routeParams) {
			if ($routeParams[param]) {
				return $routeParams[param];
			}
		}
	};

	$scope.redirectToRoot = function () {
		window.location = '/';
	};

	$scope.makeLog(4, object_name, 'Starting ' + object_name);
  $scope.getLanguage = function(lang_abbreviation) {
    var language_name = null;
    for(var l=0;l<$rootScope.config.languages.length;l++) {
      var this_language = $rootScope.config.languages[l];
      if(this_language.abbr === lang_abbreviation) {
        language_name = this_language.name;
      }
    }

    return language_name;
  };

  $scope.setLanguage = function(lang_abbreviation) {
    $rootScope.config.language = {};
    $rootScope.config.language.abbr = lang_abbreviation;
    $rootScope.config.language.name = $scope.getLanguage($rootScope.config.language.abbr);
    $cookies['config.language'] = $rootScope.config.language.abbr;
    $scope.makeLog(4, object_name, 'Setting language to: ' + $rootScope.config.language.name);
  };

  $scope.configLanguage = function(lang_abbreviation) {
    $scope.setLanguage(lang_abbreviation);
    $location.path('/start/');
  };
}]);

app.controller('WelcomeController', ['$scope', '$rootScope', '$location', '$cookies', function ($scope, $rootScope, $location, $cookies) {
	var object_name = 'WelcomeController';
	$scope.makeLog(4, object_name, 'Starting ' + object_name);

  if($cookies['config.language']) {
    $location.path('/start/');
  } else {
    $location.path('/');
  }
}]);

app.controller('StartController', ['$scope', '$rootScope', '$location', '$cookies', function ($scope, $rootScope, $location, $cookies) {
	var object_name = 'StartController';
	$scope.makeLog(4, object_name, 'Starting ' + object_name);

  if($cookies['config.language']) {
    $scope.setLanguage($cookies['config.language']);
  } else  {
    $location.path('/');
  }

  $scope.begin = function() {
    $location.path('/forms/1');
  };
}]);

app.controller('FormsController', ['$scope', '$rootScope', '$location', '$cookies', function ($scope, $rootScope, $location, $cookies) {
	var object_name = 'FormsController';
	$scope.makeLog(4, object_name, 'Starting ' + object_name);

  $rootScope.config.progress.value = 1;

  if($cookies['config.language']) {
    $scope.setLanguage($cookies['config.language']);
  } else  {
    $location.path('/start/');
  }

  $scope.form_id = $scope.getParam('form_id');
  $scope.form_data = $rootScope.config.forms[$scope.form_id];
  $scope.answered_questions = [];
  $scope.form_disabled = true;

  $scope.answerQuestion = function(question_id) {
    if($scope.answered_questions.indexOf(question_id) < 0) {
      $rootScope.config.progress.value += Math.round(99 / $scope.form_data.questions.length);
      $scope.answered_questions.push(question_id);

      if($scope.answered_questions.length === $scope.form_data.questions.length) {
        $scope.form_disabled = false;
      }
    }
  };

  $scope.finish = function() {
    $scope.makeLog(4, object_name, 'Storing Data in ' + object_name, $scope.form_data.questions);
    $location.path('/finish/');
  };
}]);

app.controller('FinishController', ['$scope', '$rootScope', '$location', '$cookies', function ($scope, $rootScope, $location, $cookies) {
	var object_name = 'FinishController';
	$scope.makeLog(4, object_name, 'Starting ' + object_name);

  $rootScope.config.progress.value = 0;

  if($cookies['config.language']) {
    $scope.setLanguage($cookies['config.language']);
  } else  {
    $location.path('/');
  }
}]);
