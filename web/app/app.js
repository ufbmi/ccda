'use strict';
var app = angular.module('CCDAA', ['ngRoute', 'ui.bootstrap', 'ngResource', 'ngCookies', 'ngSanitize']);

app.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/', {
        templateUrl: 'app/views/welcome.html',
        controller: 'WelcomeController'
    }).when('/start/', {
        templateUrl: 'app/views/start.html',
        controller: 'StartController'
    }).when('/projects/:sections_id?', {
        templateUrl: 'app/views/projects.html',
        controller: 'ProjectsController'
    }).when('/admin/', {
        templateUrl: 'app/views/admin.html',
        controller: 'AdminController'
    }).otherwise({
        redirectTo: '/'
    });
}]);
