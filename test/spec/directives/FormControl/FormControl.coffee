require "../../../../_src/coffee/main.coffee"
require "angular-mocks/angular-mocks"
compileTemplate = require "../../utils/compileTemplate.coffee"
waitForNextFrame = require "../../utils/waitForNextFrame.coffee"

describe('FormControl', ->
  angular.module('myApp', ['poly-form-validation'])


  $compile = null
  $rootScope = null
  element = null
  scope = null
  formControlElement = null

  compileElement = (options) ->
    element = compileTemplate(options, scope, $compile)

  beforeEach(angular.mock.module("myApp"))

  beforeEach(inject((_$rootScope_, _$compile_) ->
    $rootScope = _$rootScope_
    $compile = _$compile_
    scope = $rootScope

    compileElement({name:'test',label:'test',type:'text',model:'testForm.testModel'})
    formControlElement = $(element).find('.has-feedback')
  ))

  it("should have input control", ->
    expect($(element).find('input').length).toBe 1
  )
  it("should have ng-model with name testForm.test", ->
    expect($(element).find('input').attr("ng-model")).toBe "testForm.testModel"
  )
  it("should have value of model undefined initially", ->
    expect(scope.testForm.testModel).toBeUndefined()
  )

  describe('on input value change', ->
    beforeEach(()->
      input = $(element).find("input")
      input.val("test")
      input.trigger("change")
    )
    it("should have value test", ->
      expect(scope.testForm.testModel).toBe "test"
    )
    it("should copy ng class from input to form-control", ->
      waitForNextFrame()
      runs(()->
        input = $(element).find("input")
        ngInputClasses = input.attr("class").match(/ng-.+/gi).join("")
        formGroup = $(element).find(".form-group")
        ngFormGroupClasses = formGroup.attr("class").match(/ng-.+/gi).join("")
        expect(ngFormGroupClasses == ngInputClasses).toBeTruthy()
      )
    )
    it("should be dirty", ->
      waitForNextFrame()
      runs(()->
        input = $(element).find("input")
        formGroup = $(element).find(".form-group")
        expect(input.hasClass("ng-dirty")).toBeTruthy()
        expect(formGroup.hasClass("ng-dirty")).toBeTruthy()
      )
    )
    describe('when is valid', ->
      it("should have class ng-valid and has-success", ->
        waitForNextFrame()
        runs(()->
          input = $(element).find("input")
          formGroup = $(element).find(".form-group")
          expect(scope.testForm.$valid).toBeTruthy()
          expect(scope.testForm.$invalid).toBeFalsy()
          expect(input.hasClass("ng-valid")).toBeTruthy()
          expect(formGroup.hasClass("ng-valid")).toBeTruthy()
          expect(formGroup.hasClass("has-success")).toBeTruthy()
        )
      )
    )
    describe('when is invalid', ->
      beforeEach(()->
        input = $(element).find("input")
        input.val("")
        input.trigger("change")
      )
      it("should have class ng-invalid and has-error", ->
        waitForNextFrame()
        runs(()->
          input = $(element).find("input")
          formGroup = $(element).find(".form-group")
          expect(scope.testForm.$valid).toBeFalsy()
          expect(scope.testForm.$invalid).toBeTruthy()
          expect(input.hasClass("ng-invalid")).toBeTruthy()
          expect(formGroup.hasClass("ng-invalid")).toBeTruthy()
          expect(formGroup.hasClass("has-error")).toBeTruthy()
        )
      )
    )
  )
)
