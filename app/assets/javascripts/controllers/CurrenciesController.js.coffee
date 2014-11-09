class CurrenciesController extends BaseCollectionController
  @$inject: ['$scope', '$timeout','CurrenciesService', 'VisitsService']
  constructor: (@scope, @timeout, CollectionService, VisitsService) ->
    super(@scope, @timeout)

    @scope.currencies = []

    changedCurrencies = => $.grep @scope.currencies, (c) -> c.checked != c.collected

    @scope.changedCurrenciesCount = () =>
      changedCurrencies().length

    @scope.markCollected = () =>
      options = $.map changedCurrencies(), (currency) -> {code: currency.country_id, checked: currency.checked}
      @scope.isLoading = true
      VisitsService.bulkUpdate(options).then =>
        @scope.$broadcast('visits:new')
        @loadCollection(@currentPage(), @scope.searchText)

    @collectionService = new CollectionService(BaseCollectionController.serverErrorHandler)

    @loadCollection()

  checkAll: () =>
    super()
    angular.forEach @scope.currencies, (item) => item.checked = @scope.selectedAll

  loadCollection: (page = 1, q = '') =>
    super()
    @collectionService.search page, q, @onCollectionLoaded

  onCollectionLoaded: (res) =>
    super(res)
    @scope.currencies = $.map res.currencies, (currency) =>
      @scope.selectedAll = @scope.selectedAll && currency.collected
      currency.checked = currency.collected
      currency

angular.module('trackerApp').controller "CurrenciesController", CurrenciesController
