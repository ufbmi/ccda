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
		} else {
			if(typeof(object) != 'undefined') {
				$log.info('Data passed to logger service is not an object');
				$log.info(typeof(object));
				$log.info(object);
			}
		}
	};
}]);

app.service('GetDataService', ['$http', 'LoggerService', function ($http, LoggerService) {
	var object_name = 'GetDataService';
	var getData = {};
	getData.data = {};

	this.getResult = function (method, url, params, post_data, headers, is_array) {
		LoggerService.makeLog(4, object_name, 'Getting data from: ' + url);
		//LoggerService.makeLog(4, object_name, 'Posting data:', post_data);
		var promise = $http({
			cache: false,
			method: method,
			url: url,
			params: params,
			data: post_data,
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