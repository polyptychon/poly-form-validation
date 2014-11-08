requestAnimFrame = require "animationframe"
module.exports = ($parse) ->
  restrict: 'E'
  require: ['?ngModel']
  link: (scope, element, attrs, ngModel) ->

    if (attrs.ngModel && attrs.checked)
      requestAnimFrame(() ->
        $parse(attrs.ngModel).assign(scope, attrs.checked)
        element.trigger("change")
      )
    else if (attrs.ngModel && attrs.value)
      if attrs.type=="select2-input" || attrs.uiSelect2?
        requestAnimFrame(() ->
          requestAnimFrame(()->
            if attrs.multiple? && attrs.multiple == true
              values = []
              a = attrs.value.split(",")
              angular.forEach(a, (item) ->
                values.push({id: item, text: item})
              )
              $(element).select2("data", values)
            else
              $(element).select2("data", {id: attrs.value, text:attrs.value})

            requestAnimFrame(() ->
              element.trigger("change")
            )
          )
        )

      else
        requestAnimFrame(() ->
          element.val(attrs.value)
          element.trigger("change")
        )

