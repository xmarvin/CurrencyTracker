class CurrenciesStatsController extends BaseStatsController
  @$inject: ['$scope', 'StatsService', '$q']
  constructor: (@scope, StatsService, @q) ->
    @scope.counts = [0,0]
    @scope.countsLabels = ['Collected', 'Not collected']
    @StatsService  = StatsService
    super(@scope)

  loadStats: =>
    @q.all([@StatsService.getCurrenciesCounts(), @StatsService.getCurrenciesChartData()]).then (results)=>
      @scope.counts = [results[0].data.collected, results[0].data.uncollected]
      @scope.chartData = results[1]

angular.module('trackerApp').controller "CurrenciesStatsController", CurrenciesStatsController