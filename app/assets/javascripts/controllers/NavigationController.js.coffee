angular.module('trackerApp').controller "NavigationController", ($scope, $location) ->
  $scope.activetab = $location.path()[1..-1]
  $scope

