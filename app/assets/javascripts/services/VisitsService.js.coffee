angular.module('trackerApp').factory 'VisitsService', ($http) ->
  bulkUpdate: (options) ->
    $http
      method: 'post',
      url: 'visits/bulk_update.json',
      data:
        bulk: options