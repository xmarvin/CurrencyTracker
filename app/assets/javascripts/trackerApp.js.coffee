trackerApp = angular.module('trackerApp', ['ngResource', 'ngRoute'])
trackerApp.config ($httpProvider, $parseProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  $parseProvider.unwrapPromises(true)

trackerApp.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/',  templateUrl: '/templates/countries.html', controller: 'CountriesController'
  $routeProvider.when '/countries',  templateUrl: '/templates/countries.html', controller: 'CountriesController'
  $routeProvider.when '/currencies',  templateUrl: '/templates/countries.html', controller: 'CountriesController'