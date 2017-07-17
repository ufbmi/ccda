app.controller('AdminController', ['$scope', '$rootScope', function ($scope, $rootScope) {
	var object_name = 'AdminController';
    $scope.makeLog(4, object_name, 'Starting ' + object_name);
	$scope.authenticate = true;
	
	$scope.init($scope.authenticate);
}]);