angular.module('trackerApp').controller "CountriesStatsController", ($scope, StatsService) ->
  $scope.counts = [0,0]
  $scope.countsLabels = ['Visited', 'Not visited']
  StatsService.getVisitsCounts().then (response) ->
    $scope.counts = [response.data.visited, response.data.unvisited]
  StatsService.getVisitsChartData().then (data) ->
    $scope.chartData = data
  $scope