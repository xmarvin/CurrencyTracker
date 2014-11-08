angular.module('trackerApp').controller "CountriesController", ($scope, CountriesService, $http, $timeout) ->
  serverErrorHandler = (res,error) ->
    err = "There was a server error, please reload the page and try again."
    err_data = res.data
    if err_data
      err = err_data[0]
    alert(err)

  $scope.countries = []
  $scope.pagination = {}

  $scope.changedCountriesCount = () ->
    changed_countries = $.grep $scope.countries, (c) -> c.checked != c.visited
    changed_countries.length

  $scope.checkAll = () ->
    if $scope.selectedAll
      $scope.selectedAll = false
    else
      $scope.selectedAll = true

    angular.forEach $scope.countries, (item) ->
      item.checked = $scope.selectedAll

  $scope.markVisited = () ->
    changed_countries = $.grep $scope.countries, (c) -> c.checked != c.visited
    options = $.map changed_countries, (country) -> {code: country.code, checked: country.checked}
    console.log options
    $scope.isLoading = true
    request = $http
      method: 'post',
      url: 'visits/bulk_update.json',
      data:
        bulk: options
    request.then ->
      loadCountries(currentPage(), $scope.searchText)

  @countriesService = new CountriesService(serverErrorHandler)

  loadCountries = (page = 1, q = '') =>
    $scope.isLoading = true
    $scope.selectedAll = true
    @countriesService.search page, q, (res) =>
      $scope.isLoading = false
      $scope.pagination = res.pagination
      $scope.countries = $.map res.countries, (country) ->
        $scope.selectedAll = $scope.selectedAll && country.visited
        country.checked = country.visited
        country

  $scope.nextPage = () =>
    page = currentPage()
    total_pages = $scope.pagination.total_pages

    if page < total_pages
      loadCountries(page + 1, $scope.searchText)

  $scope.prevPage = () =>
    page = currentPage()
    if page > 1
      loadCountries(page - 1, $scope.searchText)

  currentPage = ->
    $scope.pagination.current_page

  loadCountries()
  filterTextTimeout = null
  $scope.$watch 'searchText', (val) ->
    $timeout.cancel filterTextTimeout  if filterTextTimeout
    filterTextTimeout = $timeout(->
      if $scope.searchText isnt undefined
        loadCountries(1, $scope.searchText)
    , 800)
  $scope
