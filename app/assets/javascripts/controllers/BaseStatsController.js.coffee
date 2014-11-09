class @BaseStatsController
  @$inject: ['$scope']

  constructor: (@scope) ->
    @scope.$on 'visits:new', @loadStats
    @loadStats()