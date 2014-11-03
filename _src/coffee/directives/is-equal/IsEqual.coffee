if jQuery then $ = jQuery else $ = require "jquery"

module.exports = () ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, elm, attrs, ngModel) ->

    scope.$evalAsync(
      () ->
        $(attrs.isEqual).bind("keyup input blur",
          () ->
            validatorFn(ngModel.$modelValue)
            scope.$digest()
          )
    )

    validatorFn = (viewValue) ->
      itemToObserveValue = $(attrs.isEqual);
      value = (if itemToObserveValue.length==0 then "" else itemToObserveValue.val())
      if (viewValue==value)
        ngModel.$setValidity('isEqual', true);
      else
        ngModel.$setValidity('isEqual', false);

      return viewValue;

    ngModel.$parsers.unshift(validatorFn)
