'use strict';
var app = angular.module('CCDAA', ['ngRoute', 'ui.bootstrap', 'ngResource', 'ngCookies']);

app.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/', {
        templateUrl: 'app/views/welcome.html',
        controller: 'WelcomeController'
    }).when('/start/', {
        templateUrl: 'app/views/start.html',
        controller: 'StartController'
    }).when('/forms/:form_id', {
        templateUrl: 'app/views/form.html',
        controller: 'FormsController'
    }).when('/finish/', {
        templateUrl: 'app/views/finish.html',
        controller: 'FinishController'
    }).otherwise({
        redirectTo: '/'
    });
}]);
