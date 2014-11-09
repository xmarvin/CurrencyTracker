class CountriesController extends BaseCollectionController
  @$inject: ['$scope', '$timeout','CountriesService', '$http']
  constructor: (@scope, @timeout, CountriesService, @http) ->
    super(@scope, @timeout)

    @scope.countries = []

    @scope.changedCountriesCount = () =>
      changed_countries = $.grep @scope.countries, (c) -> c.checked != c.visited
      changed_countries.length

    @scope.checkAll = @checkAll

    @scope.markVisited = () =>
      changed_countries = $.grep @scope.countries, (c) -> c.checked != c.visited
      options = $.map changed_countries, (country) -> {code: country.code, checked: country.checked}
      console.log options
      @scope.isLoading = true
      request = @http
        method: 'post',
        url: 'visits/bulk_update.json',
        data:
          bulk: options
      request.then =>
        @loadCollection(@currentPage(), @scope.searchText)
    @countriesService = new CountriesService(BaseCollectionController.serverErrorHandler)

    @loadCollection()

  checkAll: () =>
    super()
    angular.forEach @scope.countries, (item) => item.checked = @scope.selectedAll

  loadCollection: (page = 1, q = '') =>
    super()
    @countriesService.search page, q, @onCollectionLoaded

  onCollectionLoaded: (res) =>
    super(res)
    @scope.countries = $.map res.countries, (country) =>
      @scope.selectedAll = @scope.selectedAll && country.visited
      country.checked = country.visited
      country

angular.module('trackerApp').controller "CountriesController", CountriesController