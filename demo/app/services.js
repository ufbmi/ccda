app.service('LoggerService', ['$log', function ($log) {

	function getLevel(level) {
		var error_types = ['DEBUG', 'WARN', 'ERROR', 'INFO', 'LOG'];
		return error_types[level];
	}

	this.makeLog = function (level, name, message, object) {
		if (!level) {
			level = 4;
		}
		var level = '[' + getLevel(level) + ']';
		var name = '[' + name + ']';
		var message = level + name + ' ' + message;
		if (level === 0) {
			$log.debug(message);
		} else if (level === 1) {
			$log.warn(message);
		} else if (level === 2) {
			$log.error(message);
		} else if (level === 3) {
			$log.info(message);
		} else {
			$log.log(message);
		}

		if ((typeof (object) == 'object') && (debug_mode)) {
			$log.info(object);
		}
	};
}]);

app.service('GetDataService', ['$http', 'LoggerService', function ($http, LoggerService) {
	var object_name = 'GetDataService';
	var getData = {};
	getData.data = {};

	this.getResult = function (method, url, params, headers, is_array) {
		LoggerService.makeLog(4, object_name, 'Getting data from: ' + url);
		var promise = $http({
			cache: false,
			method: method,
			url: url,
			params: params,
			headers: headers,
			is_array: is_array
		}).success(function (data) {
			LoggerService.makeLog(3, object_name, 'Retrieving data from: ' + url, data);
			var site_data = data[0];
			return site_data;
		});

		return promise;
	};
}]);

app.factory('JSONFactory', ['$resource', 'LoggerService', '$rootScope', function ($resource, LoggerService, $rootScope) {
	var object_name = 'JSONFactory';
		LoggerService.makeLog(3, object_name, 'Retrieving data from: ' + $rootScope.config.api_url);
    var resource = $resource($rootScope.config.api_url + ':controller/:script', {}, {
        get: {
            method: 'GET',
            isArray: false
        }
    });

    return resource;
}]);
