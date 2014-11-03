if jQuery then $ = jQuery else $ = require "jquery"
_ = require "lodash"
formElements = require "../../utils/FormElements.coffee"
requestAnimFrame = require "animationframe"

module.exports = () ->
  restrict: 'E'
  transclude: true
  scope:
    tabTitle: '@'
    nextTabButtonLabel: '@'
    showNextButton: '@'
    directiveScope: "="
  template: require './form-tab.jade'
  replace: true
  require: ['^form', '^formTabs']

  link: (scope, element, attrs, ctrls, transclude) ->
    scope.directiveScope = scope if (attrs.directiveScope)
    form = ctrls[0];
    formTabs = ctrls[1];
    return if (formTabs == null)

    removeIndex = -1
    controlElements = element.find(formElements)
    controls = []

    scope.showNextButton = true

    if (attrs.ngShow)
      scope.$parent.$watch(attrs.ngShow, (value) ->
        togglePane(value)
      )

    if (attrs.ngHide)
      scope.$parent.$watch(attrs.ngHide, (value) ->
        togglePane(!value)
      )
    attrs.$observe("tabTitle", (value) ->
      scope.tabTitle = "Title" unless (value?)
    )

    attrs.$observe("nextTabButtonLabel", (value) ->
      scope.nextTabButtonLabel = value
    )

    attrs.$observe("showNextButton", (value) ->
      scope.showNextButton = (if value=="false" then false else true )
    )

    formTabs.addPane(scope);

    scope.isLastPane = () ->
      formTabs.isLastPane(scope)

    scope.getNextPane = () ->
      formTabs.getNextPane(scope)

    scope.selectNextPane = () ->
      formTabs.selectNextPane(scope)

    toggleValidation = (value) ->
      scope.$evalAsync(() ->
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

    togglePane = (value) ->
      scope.$evalAsync(() ->
        if (value)
          formTabs.addPaneAt(scope, removeIndex)
        else
          removeIndex = formTabs.getPaneIndex(scope)
          formTabs.removePane(scope)

        toggleValidation(value)
      )

  controller:
    [
      '$scope'
      '$element'
      ($scope, $element) ->
        $scope.disabled = true
        $scope.isPaneInValid = true

        formControls = $scope.formControls = []

        isPaneValid = () ->
          nextPane = $scope.getNextPane()
          $scope.isPaneInValid = false
          enabledElements = formElements.split(", ").join(":enabled, ") + ":enabled"
          $($element).find(enabledElements).each(() ->
            $scope.isPaneInValid = true if ($(@).hasClass("ng-invalid"))
          )

          nextPane.disabled = $scope.isPaneInValid if (nextPane)
          $scope.$digest()

          return $scope.isPaneInValid

        $scope.$evalAsync(() ->
          requestAnimFrame ( () ->
            isPaneValid()
          )
          $($element).find(formElements).bind("keyup input blur change click", () ->
            requestAnimFrame ( () ->
              isPaneValid()
            )
          )
        )

        $scope.setFocus = () ->
          requestAnimFrame ( () ->
            $($element).find(formElements).first().focus()
          )

        @addFormControl = (formControl) ->
          formControls.push(formControl)
    ]
