angular.module('trackerApp').directive 'progressChart', () ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    console.log "link"
    $.getJSON '/visits/chart_data.json', (data) ->
      console.log data
      $(element).highcharts('StockChart', {
        rangeSelector: false
        navigator:
          enabled: false
        exportButton:
          enabled: false
        title: {
          text: 'AAPL Stock Price'
        },
        series: [
          {
            name: 'AAPL',
            data: data,
            tooltip: {
              valueDecimals: 2
            }
          }
        ]
      });
