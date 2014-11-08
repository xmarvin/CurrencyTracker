angular.module('trackerApp').controller "CountriesStatsController", ($scope, StatsService) ->
  $scope.counts = { visited: 0, unvisited: 0 }
  stats_service = new StatsService()
  stats_service.getVisitsCounts().then (response) ->
    $scope.counts = response.data
  $scope