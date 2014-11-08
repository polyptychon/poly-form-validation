mapDataToURL = require "../../utils/MapDataToURL.coffee"

module.exports = ($timeout, $http) ->
  restrict: 'A'
  require: ['?ngModel', '^?formControl']
  scope:
    isUniqueQuietMillis: '@'
    isUniqueMapData: '@'
    isUniqueDataType: '@'
  link: (scope, elm, attrs, ctrls) ->
    ngModel = ctrls[0]
    formControl = ctrls[1]
    timeoutPromise = null
    timeoutDigest = -1
    quietMillis = if (attrs.isUniqueQuietMillis != null && !isNaN(attrs.isUniqueQuietMillis)) then attrs.isUniqueQuietMillis else 500

    scope.$watch(
      () ->
        ngModel.$viewValue
      (newValue) ->
        if (newValue != ngModel.$modelValue)
          elm.addClass("ng-is-unique-pending")
    ) #watch

    scope.$watch(
      () ->
        ngModel.$modelValue
      (newValue) ->
        clearTimeout(timeoutDigest)
        $timeout.cancel(timeoutPromise)
        elm.removeClass("ng-is-unique-error-loading")

        if (!newValue? || newValue.length < 2 || attrs.isUnique == "" || attrs.isUnique.length < 2)
          elm.removeClass("ng-is-unique-loading")
          elm.removeClass("ng-loading")
          return

        elm.removeClass("ng-is-unique-pending");
        elm.addClass("ng-is-unique-loading");
        elm.addClass("ng-loading");

        timeoutPromise = $timeout(
          () ->
            url = mapDataToURL(attrs.isUnique, attrs.isUniqueMapData, scope.$parent)
            dataType = attrs.isUniqueDataType || "json"

            if (dataType == "jsonp")
              if (url.indexOf("?") < 0)
                url += "?callback=JSON_CALLBACK"
              else
                if (url.indexOf("callback=JSON_CALLBACK") < 0)
                  url = url.replace(/\?/gi, "?callback=JSON_CALLBACK&")

              $http.jsonp(url).success((response) ->
                onSuccess(response)
              ).error(() ->
                onError()
              ).then(() ->
                onDefault()
              )
            else
              $http (
                method: 'GET'
                url: url
              )
              .success(
                (data) ->
                  onSuccess(data)
              )
              .error(() ->
                onError()
              )
              .then(() ->
                onDefault()
              )

            onSuccess =
              (data) ->
                elm.removeClass("ng-is-unique-error-loading")
                return unless (data?)
                validatorFn(newValue, data)
                update()

            onError =
              () ->
                elm.addClass("ng-is-unique-error-loading")
                validatorFn(newValue, true);
                update()

            onDefault =
              () ->
                elm.removeClass("ng-is-unique-pending")
                elm.removeClass("ng-is-unique-loading")
                elm.removeClass("ng-loading")
                update()

            update = () ->
              formControl.copyChildClassesToParent(elm) if formControl?

        , quietMillis)
    ) #watch

    validatorFn = (modelValue, value) ->
      if (value)
        ngModel.$setValidity('isUnique', true);
      else
        ngModel.$setValidity('isUnique', false);
      modelValue;

    ngModel.$parsers.unshift(validatorFn);
