angular.module('trackerApp').factory 'CurrenciesService', ($resource, $q, $http) ->

  class CurrenciesService
    constructor: (errorHandler) ->
      @service = $resource('/currencies/:id.json')
      @errorHandler = errorHandler

    search: (page, q, successCallback) =>
      @service.get {page: page, q: q}, (res) =>
        successCallback(res)
      , @errorHandler