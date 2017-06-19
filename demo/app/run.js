app.run(['$rootScope','LoggerService', function ($rootScope, LoggerService) {
	$rootScope.config = root_config;
	$rootScope.makeLog = function (level, name, message, object) {
		LoggerService.makeLog(level, name, message, object);
	};
}]);
