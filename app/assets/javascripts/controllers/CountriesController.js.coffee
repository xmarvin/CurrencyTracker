angular.module('trackerApp').controller "CountriesController", ($scope, CountriesService) ->
  serverErrorHandler = (res,error) ->
    err = "There was a server error, please reload the page and try again."
    err_data = res.data
    if err_data
      err = err_data[0]
    alert(err)

  $scope.countries = []
  @countriesService = new CountriesService(serverErrorHandler)
  @countriesService.all (res) ->
    $scope.countries = res

  $scope
