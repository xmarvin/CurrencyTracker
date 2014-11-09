class @BaseCollectionController
  @$inject: ['$scope', '$timeout']
  @serverErrorHandler: (res,error) ->
    err = "There was a server error, please reload the page and try again."
    err_data = res.data
    if err_data
      err = err_data[0]
    alert(err)

  constructor: (@scope, @timeout) ->
    @scope.pagination = {}

    @scope.nextPage = () =>
      page = @currentPage()
      total_pages = @scope.pagination.total_pages

      if page < total_pages
        @loadCollection(page + 1, @scope.searchText)

    @scope.prevPage = () =>
      page = @currentPage()
      if page > 1
        @loadCollection(page - 1, @scope.searchText)

    filterTextTimeout = null
    @scope.$watch 'searchText', (val) =>
      @timeout.cancel filterTextTimeout  if filterTextTimeout
      filterTextTimeout = @timeout(=>
        if @scope.searchText isnt undefined
          @loadCollection(1, @scope.searchText)
      , 800)

  currentPage: =>
    @scope.pagination.current_page

  checkAll: =>
    @scope.selectedAll = @scope.selectedAll != true

  loadCollection: () ->
    @scope.isLoading = true
    @scope.selectedAll = true

  onCollectionLoaded: (res) ->
    @scope.isLoading = false
    @scope.pagination = res.pagination