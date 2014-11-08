angular.module('trackerApp').controller "CountriesController", ($scope, CountriesService, $http) ->
  serverErrorHandler = (res,error) ->
    err = "There was a server error, please reload the page and try again."
    err_data = res.data
    if err_data
      err = err_data[0]
    alert(err)

  $scope.countries = []
  $scope.changedCountriesCount = () ->
    console.log 'changedCountriesCount'
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
    console.log "mark visited"
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
      loadCountries()

  @countriesService = new CountriesService(serverErrorHandler)

  loadCountries = =>
    $scope.isLoading = true
    $scope.selectedAll = true
    @countriesService.all (res) =>
      $scope.isLoading = false
      $scope.countries = $.map res, (country) ->
        $scope.selectedAll = $scope.selectedAll && country.visited
        country.checked = country.visited
        country

  loadCountries()
  $scope
