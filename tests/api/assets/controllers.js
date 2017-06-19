app.controller('MainController', ['$scope', '$rootScope', '$q', function ($scope, $rootScope, $q) {
  var object_name = 'MainController';
  $scope.makeLog(4, object_name, 'Starting ' + object_name);

  $scope.data_loaded = false;
  $scope.init = function () {
      q1 = $scope.q1 = $q.defer(),
          p1 = $scope.q1.promise;

      $scope.data = $q.all([
        p1.then($rootScope.getData)
      ]).then(function (values) {
        $scope.makeLog(4, object_name, 'Retrieved results from JSON data request');
        $scope.json_data = values;
      });

      setTimeout(function () {
          $scope.$apply(function () {
              $scope.makeLog(4, object_name, 'Sending request to retrieve JSON data');
              q1.resolve({
                  method: 'GET',
                  resource_link: $rootScope.config.api_url,
              });
          });
      }, 500, this);
  };

  $scope.$watch('json_data', function() {
    if($scope.json_data) {
      console.log($scope.json_data);
      $scope.data_loaded = true;
      $scope.suites_loaded = false;

      $scope.suite = $scope.json_data[0].data[0];
      $scope.suite.suites = {};
      $rootScope.config.title += ': ' + $scope.suite.suite;

      $scope.suite.passed = 0;
      $scope.suite.failed = 0;
      $scope.suite.errors = 0;

      for(var i=1; i<$scope.json_data[0].data.length;i++) {
        var this_event = $scope.json_data[0].data[i];
        if($scope.json_data[0].data[i+1]) {
          var next_event = $scope.json_data[0].data[i+1];
        }
        if(this_event.event == 'suiteStart') {
          $scope.suite.suites[this_event.suite] = [];
          $scope.suite.suites[this_event.suite].suite = this_event.suite;
          $scope.suite.suites[this_event.suite].event = this_event.event;
          $scope.suite.suites[this_event.suite].passed = 0;
          $scope.suite.suites[this_event.suite].failed = 0;
          $scope.suite.suites[this_event.suite].errors = 0;
        } else if(this_event.event == 'testStart') {
          if(!$scope.suite.suites[this_event.suite].tests) {
            $scope.suite.suites[this_event.suite].tests = [];
          }

          if(next_event) {
            if(next_event.status) {
              if(next_event.status == 'pass') {
                $scope.suite.passed++;
                $scope.suite.suites[this_event.suite].passed++;
              } else if(next_event.status == 'fail') {
                $scope.suite.failed++;
                $scope.suite.suites[this_event.suite].failed++;
              } else if(next_event.status == 'error') {
                $scope.suite.errors++;
                $scope.suite.suites[this_event.suite].errors++;
              }
            }

            next_event.test = next_event.test.replace(next_event.suite + '::','');
            var parts = next_event.test.split('_');
            next_event.parts = [];
            next_event.parts['method'] = parts[1];
            next_event.parts['intent'] = parts[2];
            if(next_event.time) {
              next_event.time = next_event.time.toFixed(4);              
            }

            $scope.suite.suites[this_event.suite].tests.push(next_event);
          }
        }
      }

      $scope.suites_loaded = true;
      console.log($scope.suite.suites);
    }
  })

  $scope.init();
}]);
