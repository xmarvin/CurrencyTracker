angular.module('trackerApp').factory 'CountriesService', ($resource, $q, $http) ->

  class TeamService
    constructor: (errorHandler) ->
      @service = $resource('/countries/:id.json',
        {id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    search: (page, q, successCallback) =>
      @service.get {page: page, q: q}, (res) =>
        successCallback(res)
      , @errorHandler