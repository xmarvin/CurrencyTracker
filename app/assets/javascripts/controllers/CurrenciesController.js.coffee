console.log "CurrenciesController"

class CurrenciesController extends BaseCollectionController
  @$inject: ['$scope']
  constructor: (@scope) ->
    super(@scope)


angular.module('trackerApp').controller "CurrenciesController", CurrenciesController
