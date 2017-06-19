app.run(['$rootScope', '$q', 'LoggerService', 'GetDataService', '$location', function ($rootScope, $q, LoggerService, GetDataService, $location) {

	$rootScope.config = root_config;

	$rootScope.makeLog = function (level, name, message, object) {
		LoggerService.makeLog(level, name, message, object);
	};

	$rootScope.getData = function(values) {
    	var returned_data = GetDataService.getResult(values.method, values.resource_link, values.params, values.post_data, values.headers, false).then(function(data) {
			return data;
		});

        return returned_data;
    };
}]);
