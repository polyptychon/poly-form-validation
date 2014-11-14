module.exports = (options, scope, $compile, templ) ->
  template = templ || require "./form-control-example.jade"
  element = $("<div></div>").html(template({ options: options }))
  $compile(element)(scope)
  scope.$digest()
  return element
