angular.module('trackerApp').controller "CurrenciesStatsController", ($scope, StatsService) ->
  $scope.counts = [0,0]
  $scope.countsLabels = ['Collected', 'Not collected']
  StatsService.getCurrenciesCounts().then (response) ->
    $scope.counts = [response.data.collected, response.data.uncollected]
  StatsService.getCurrenciesChartData().then (data) ->
    $scope.chartData = data
  $scope