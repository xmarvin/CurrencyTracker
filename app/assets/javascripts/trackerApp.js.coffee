trackerApp = angular.module('trackerApp', ['ngResource', 'ngRoute'])
trackerApp.config ($httpProvider, $parseProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  $parseProvider.unwrapPromises(true)

trackerApp.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/',  templateUrl: '/templates/info.html'
  $routeProvider.when '/countries',  templateUrl: '/templates/countries.html', controller: 'CountriesController'
  $routeProvider.when '/currencies',  templateUrl: '/templates/currencies.html', controller: 'CurrenciesController'


angular.element(document).ready () ->
  angular.bootstrap($('body').get(0), ['trackerApp']);