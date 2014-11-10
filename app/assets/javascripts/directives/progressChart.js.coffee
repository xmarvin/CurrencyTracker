angular.module('trackerApp').directive 'progressChart', () ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    chart_options =
      rangeSelector: false
      navigator:
        enabled: false
      exportButton:
        enabled: false
      title:
        text: attrs.title
      series: [
        name: 'Counts',
        data: (scope.chartData || []),
        tooltip:
          valueDecimals: 2
      ]
    $(element).highcharts('StockChart', chart_options)

    scope.$watch 'chartData', (data) ->
      chart = $(element).highcharts()
      chart.series[0].setVisible(false)
      if data
        chart.series[0].setData(data)
        chart.series[0].setVisible(true, true)
    , true
