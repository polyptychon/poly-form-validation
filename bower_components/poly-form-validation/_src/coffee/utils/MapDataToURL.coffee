formatStringURL = require "./FormatStringURL.coffee"

module.exports = (url, mapData, scope) ->
  obj = {}
  obj = scope.$eval(mapData) if mapData?
  formatStringURL(url, obj)
