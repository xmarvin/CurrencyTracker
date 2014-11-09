class CountriesStatsController extends BaseStatsController
  @$inject: ['$scope', 'StatsService', '$q']
  constructor: (@scope, StatsService, @q) ->
    @scope.counts = [0,0]
    @scope.countsLabels = ['Visited', 'Not visited']
    @StatsService  = StatsService
    super(@scope)

  loadStats: =>
    @q.all([@StatsService.getVisitsCounts(), @StatsService.getVisitsChartData()]).then (results)=>
      @scope.counts = [results[0].data.visited, results[0].data.unvisited]
      @scope.chartData = results[1]


angular.module('trackerApp').controller "CountriesStatsController", CountriesStatsController