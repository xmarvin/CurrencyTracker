class CountriesController extends BaseCollectionController
  @$inject: ['$scope', '$timeout','CountriesService', 'VisitsService']
  constructor: (@scope, @timeout, CountriesService, VisitsService) ->
    super(@scope, @timeout)

    @scope.countries = []

    changedCountries = =>
      $.grep @scope.countries, (c) -> c.checked != c.visited

    @scope.changedCountriesCount = () =>
      changedCountries().length

    @scope.markVisited = () =>
      options = $.map changedCountries(), (country) -> {code: country.code, checked: country.checked}
      @scope.isLoading = true
      VisitsService.bulkUpdate(options).then =>
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