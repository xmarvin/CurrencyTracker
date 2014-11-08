angular.module('trackerApp').directive 'simplePie', () ->
  restrict: 'A'

  url = "http://chart.googleapis.com/chart?cht=p3&chs=300x100&chco=0000FF&chd=t:7,237&chdl=Visited|Not%20Visited"

  link: (scope, element, attrs) ->
    width = attrs.width
    height = attrs.height
    labels = ['Visited', 'Not Visited']
    values = [scope.counts.visisted, scope.counts.unvisited]
    scope.$watch 'counts', (counts) ->
      console.log counts
      values = [counts.visited, counts.unvisited]
      console.log values
      $(element).html(getImage())

    getImage = () ->
      img = document.createElement('img');
      img.setAttribute('width', width);
      img.setAttribute('height', height);
      img.setAttribute('src', image_url());
      img

    image_url = () ->
      url = "http://chart.googleapis.com/chart?"
      url += "cht=p3"
      url += "&chs=" + width + 'x' + height
      url += "&chco=0000FF"

      url += "&chd=t:" + values.join();
      url += "&chdl=" + labels.join('|');
      url

