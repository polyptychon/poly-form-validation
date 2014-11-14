require "../../../_src/coffee/main.coffee"
require "angular-mocks/angular-mocks"
compileTemplate = require "./compileTemplate.coffee"

module.exports = (type)->
  describe('validation attributes', ->
    angular.module('myApp', ['PolyForm'])


    $compile = null
    $rootScope = null
    element = null
    scope = null

    compileElement = (options) ->
      element = compileTemplate(options, scope, $compile)

    beforeEach(angular.mock.module("myApp"))

    beforeEach(inject((_$rootScope_, _$compile_) ->
      $rootScope = _$rootScope_
      $compile = _$compile_
      scope = $rootScope
    ))

    describe('ng-required', ->
      it("should have attribute ng-required with value true", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, ngRequired: 'true'})
        expect($(element).find('input').attr('ng-required')).toBe 'true'
      )
      it("should not have attribute ng-required", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, ngRequired: 'false'})
        expect($(element).find('input').attr('ng-required')).toBeUndefined()
      )
    )
    describe('ng-minlength', ->
      it("should have attibute ng-minlength with value 3", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, ngMinlength: 3})
        expect($(element).find('input').attr('ng-minlength')).toBe '3'
      )
      it("should not have attibute ng-minlength", ->
        compileElement({name:'dateInput',label:'dateInput',type:type})
        expect($(element).find('input').attr('ng-minlength')).toBeUndefined()
      )
    )
    describe('ng-maxlength', ->
      it("should have attibute ng-maxlength with value 3", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, ngMaxlength: 3})
        expect($(element).find('input').attr('ng-maxlength')).toBe '3'
      )
      it("should not have attibute ng-maxlength", ->
        compileElement({name:'dateInput',label:'dateInput',type:type})
        expect($(element).find('input').attr('ng-maxlength')).toBeUndefined()
      )
    )
    describe('ng-pattern', ->
      it("should have attribute ng-pattern with value /((?=.*[a-z])(?=.*[A-Z]).{8,64})/", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, ngPattern: "/((?=.*[a-z])(?=.*[A-Z]).{8,64})/"})
        expect($(element).find('input').attr('ng-pattern')).toBe '/((?=.*[a-z])(?=.*[A-Z]).{8,64})/'
      )
      it("should not have attibute ng-pattern", ->
        compileElement({name:'dateInput',label:'dateInput',type:'dateInput'})
        expect($(element).find('input').attr('ng-pattern')).toBeUndefined()
      )
    )

    describe('ui-validate', ->
      it("should have attribute ui-validate with $value=test", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, uiValidate: "'$value==test'"})
        expect($(element).find('input').attr('ui-validate')).toBe "'$value==test'"
      )
      it("should not have attibute ui-validate", ->
        compileElement({name:'dateInput',label:'dateInput',type:'dateInput'})
        expect($(element).find('input').attr('ui-validate')).toBeUndefined()
      )
    )
    describe('ui-validate-watch', ->
      it("should have attribute ui-validate-watch with test", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, uiValidateWatch: "'test'"})
        expect($(element).find('input').attr('ui-validate-watch')).toBe "'test'"
      )
      it("should not have attibute ui-validate-watch", ->
        compileElement({name:'dateInput',label:'dateInput',type:'dateInput'})
        expect($(element).find('input').attr('ui-validate-watch')).toBeUndefined()
      )
    )
    describe('is-unique', ->
      it("should have attribute is-unique with value test.json", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, isUnique: "test.json"})
        expect($(element).find('input').attr('is-unique')).toBe "test.json"
      )
      it("should not have attibute is-unique", ->
        compileElement({name:'dateInput',label:'dateInput',type:'dateInput'})
        expect($(element).find('input').attr('is-unique')).toBeUndefined()
      )
    )
    describe('is-unique-map-data', ->
      it("should have attribute is-unique-map-data with value {test:'true'}", ->
        compileElement({name:'dateInput',label:'dateInput',type:type, mapData: "{test:'true'}"})
        expect($(element).find('input').attr('is-unique-map-data')).toBe "{test:'true'}"
      )
      it("should not have attibute is-unique", ->
        compileElement({name:'dateInput',label:'dateInput',type:type})
        expect($(element).find('input').attr('is-unique-map-data')).toBeUndefined()
      )
    )
  )
