app.controller('WelcomeController', ['$scope', '$rootScope', function ($scope, $rootScope) {
	var object_name = 'WelcomeController';
    $scope.makeLog(4, object_name, 'Starting ' + object_name);
	$scope.authenticate = false;
	
	$scope.init($scope.authenticate);
}]);