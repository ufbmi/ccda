app.controller('ProjectsController', ['$scope', '$rootScope', function ($scope, $rootScope) {
	var object_name = 'ProjectsController';
    $scope.makeLog(4, object_name, 'Starting ' + object_name);
	$scope.authenticate = true;

	$scope.table_width = 100;
	$scope.table_question_width = 50;
	$scope.init($scope.authenticate);
}]);
