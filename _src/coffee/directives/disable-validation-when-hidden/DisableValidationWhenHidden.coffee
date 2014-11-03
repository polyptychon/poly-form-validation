if jQuery then $ = jQuery else $ = require "jquery"
formElements = require "../../utils/FormElements.coffee"
_ = require "lodash"
requestAnimFrame = require "animationframe"

module.exports = () ->
  restrict: 'A'
  require: ['^form', '?^formTab']
  scope:
    isUniqueQuietMillis: '@'
    isUniqueMapData: '@'
  link: (scope, elm, attrs, ctrls) ->
    form = ctrls[0]
    formTab = ctrls[1]

    controlElements = elm.find(formElements)
    controls = []

    if (formTab?.scope?.disabled?)
      formTab.scope.$watch("disabled", (value) ->
        update(scope.$eval(attrs.ngShow)) if (attrs.ngShow?)
        update(scope.$eval(attrs.ngHide)) if (attrs.ngHide?)
        update(scope.$eval(attrs.ngDisabled)) if (attrs.ngDisabled?)
      )

    if (attrs.ngShow?)
      scope.$parent.$watch(attrs.ngShow, (value) ->
        update(value)
      )

    if (attrs.ngHide?)
      scope.$parent.$watch(attrs.ngHide, (value) ->
        update(!value)
      )

    if (attrs.ngDisabled?)
      scope.$parent.$watch(attrs.ngDisabled, (value) ->
        update(!value)
      )

    update = (value) ->
      scope.$evalAsync ( () ->
        controlElements.each(
          (index) ->
            element = $(@);
            control = form[element.attr("name")]
            controls.push(control) unless _.contains(controls, control)
            if (value)
              $(element).removeAttr('disabled')
            else
              $(element).attr('disabled', 'disabled')
        )
        _.forEach(controls,
          (control) ->
            return unless (control?)
            if (value)
              form.$addControl(control)
              angular.forEach(control.$error, (validity, validationToken) ->
                form.$setValidity(validationToken, !validity, control)
              )
            else
              form.$removeControl(control)
        )
      )
