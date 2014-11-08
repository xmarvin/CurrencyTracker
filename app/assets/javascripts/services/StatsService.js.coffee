angular.module('trackerApp').factory 'StatsService', ($q, $http) ->

  class StatsService
    constructor: () ->

    getVisitsCounts: () =>
      request = $http
        method: 'get',
        url: 'visits/counts.json'
