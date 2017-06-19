app.controller('AuthenticationController', ['$scope', '$rootScope', '$modalInstance', '$q', '$cookies', function ($scope, $rootScope, $modalInstance, $q, $cookies) {
	var object_name = 'AuthenticationController';
	$scope.makeLog(4, object_name, 'Starting ' + object_name);

	$scope.alerts = [];
	$scope.retry_text = 'Please wait...';
	$scope.login_data = null;
	$scope.authorize_data = null;

	$scope.preAuthorize = function() {
		q1 = $scope.q1 = $q.defer(),
		p1 = $scope.q1.promise;

		$scope.data = $q.all([
			p1.then($rootScope.getData)
		]).then(function(values) {
			$scope.makeLog(4, object_name, 'Retrieved login data from API for pre-authorization');
			$scope.login_data = values;
		});

		setTimeout(function () {
			$scope.$apply( function() {
				$scope.makeLog(4, object_name, 'Sending login data to API for pre-authorization');
				q1.resolve({
					method: 'POST',
					resource_link: $rootScope.config.api_url + 'authorize/',
					post_data: {
						'app_name': $rootScope.config.app_name,
						'sites_id': $rootScope.config.site.id,
						'projects_id': $rootScope.config.project.id
						},
					headers: { 'key': $rootScope.config.api_key }
				});
			});
		}, 100, this);
	};

	$scope.preAuthorize();

	$scope.authorize = function() {
		q1 = $scope.q1 = $q.defer(),
		p1 = $scope.q1.promise;

		$scope.data = $q.all([
			p1.then($rootScope.getData)
		]).then(function(values) {
			$scope.makeLog(4, object_name, 'Retrieved authorize data from API');
			$scope.authorize_data = values;
		});

		setTimeout(function () {
			$scope.$apply( function() {
				$scope.makeLog(4, object_name, 'Sending authorize data to API');
				q1.resolve({
					method: 'POST',
					resource_link: $rootScope.config.api_url + 'authorize/',
					post_data: {
						'app_name': $rootScope.config.app_name,
						'sites_id': $rootScope.config.site.id,
						'projects_id': $rootScope.config.project.id,
						'passkey': $scope.passkey,
						'passid': $scope.passid
						},
					headers: { 'key': $rootScope.config.api_key }
				});
			});
		}, 100, this);
	};

	$scope.$watch('login_data', function() {
		if($scope.login_data) {
			if($scope.login_data[0].data.error) {
				$scope.makeLog(4, object_name, 'API replied with login data: ' + $scope.login_data[0].data.message);
				$scope.addAlert('danger', $scope.login_data[0].data.message);
				$scope.retry_text = 'Retry';
			} else {
				$scope.clearAlerts();
				if($scope.login_data.length > 0) {
					$scope.makeLog(4, object_name, 'API returned login data: ', $scope.login_data[0].data.results);
					$scope.passid = $scope.login_data[0].data.results[0].passid;
					$scope.got_passes = true;
					$scope.focused = true;
				}
			}
		}
	});

	$scope.$watch('authorize_data', function() {
		if($scope.authorize_data) {
			if($scope.authorize_data[0].data.error) {
				$scope.makeLog(4, object_name, 'API replied with api data: ' + $scope.authorize_data[0].data.message);
				$scope.addAlert('warning', $scope.authorize_data[0].data.message);
				$scope.authorizing = false;
			} else {
				$scope.clearAlerts();
				$scope.makeLog(4, object_name, 'API returned api data: ',$scope.authorize_data[0].data.results);
				$cookies['token'] = $scope.authorize_data[0].data.results.token;
				console.log('Setting session token: ' + $cookies['token']);
				$scope.addAlert('success', $scope.authorize_data[0].data.message);
				setTimeout(function () {
					$modalInstance.close();
					$rootScope.redirect('/projects/');
				}, 500, this);
			}
		}
	});

	// Modal Button Methods
	// Pass the passid & passkey back to the API for authentication
	$scope.ok = function () {
		$scope.makeLog(4, object_name, 'Checking: ' + $scope.passid);
		$scope.authorizing = true;
		$scope.authorize();
	};

	// Close the modal instance
	$scope.cancel = function () {
		$modalInstance.dismiss('cancel');
	};

	// Modal Retry Method, used to regenerate a session request
	$scope.retry = function() {
		if($rootScope.retries < $rootScope.config.max_retries) {
			$rootScope.retries += 1;
			$scope.retry_text = 'Please wait...';
			$scope.preAuthorize();
		} else {
			$rootScope.redirect('/');
		}
	};

	// Manage the Modal Alerts
	// Add a new alert
	$scope.addAlert = function(alert_type, message) {
		$scope.alerts = [];
		$scope.alerts.push({'type': alert_type, 'msg': message });
	};

	// Clear all the alerts
	$scope.clearAlerts = function() {
		$scope.alerts = null;
	};

	// Close a single alert (would only be triggered if the user clicked the X on the alert inside the modal)
	$scope.closeAlert = function(index) {
		$scope.alerts.splice(index, 1);
	};
}]);
