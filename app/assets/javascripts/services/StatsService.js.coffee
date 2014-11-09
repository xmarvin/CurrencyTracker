angular.module('trackerApp').factory 'StatsService', ($q, $http) ->

  getVisitsCounts: () =>
    $http
      method: 'get',
      url: 'countries/counts.json'

  getCurrenciesCounts: () =>
    $http
      method: 'get',
      url: 'countries/counts.json'

  getCurrenciesCounts: () =>
    $http
      method: 'get',
      url: 'currencies/counts.json'

  getCurrenciesChartData: () ->
    $.getJSON 'currencies/chart_data.json'

  getVisitsChartData: () ->
    $.getJSON 'countries/chart_data.json'