# Description

A collection of directives for combining angular and bootstrap validation.

Demo: http://polyptychon.github.io/poly-form-validation

# Requirements

- [AngularJS](http://angularjs.org/)
- [JQuery](http://jquery.com/)
- [Bootstrap](https://github.com/twbs/bootstrap/)

## Install

You can install this package either with `npm` or with `bower`.

### npm

```shell
npm install --save polyptychon/poly-form-validation
```
Add a stylesheet to your `index.html` head:
```html
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/node_modules/poly-form-validation/lib/css/poly-form-validation.css">
```

Add a `<script>` to your `index.html`:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.0/angular.min.js"></script>

<script src="/node_modules/poly-form-validation/lib/js/poly-form-validation.min.js"></script>
```

Then add `poly-form-validation` as a dependency for your app:

```javascript
angular.module('myApp', ['poly-form-validation']);
```

Note that this package is in CommonJS format, so you can `require('poly-form-validation')`

### bower

```shell
bower install polyptychon/poly-form-validation
```

Add a stylesheet to your `index.html` head:
```html
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/bower_components/poly-form-validation/lib/css/poly-form-validation.css">
```

Add a `<script>` to your `index.html`:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.0/angular.min.js"></script>

<script src="/bower_components/poly-form-validation/lib/js/poly-form-validation.min.js"></script>
```

Then add `poly-form-validation` as a dependency for your app:

```javascript
angular.module('myApp', ['poly-form-validation']);
```

## Documentation

### Directives

| Name                                  | Description |
| :-------------------------------------| :----- |
| formTabs `<form-tabs>`                | Use it as an element to organize controls into tabs. |
| formTab  `<form-tab>`                 | Allow you to add tabs to a form in combination with form-tabs as a parent. |
| formControl `<form-control>`          | Group a form control with other validation elements. |
| inputGroup `<input-group>`            | Use it to replace bootstrap `<div class="input-group">` |
| inputGroupAddon `<input-group-addon>` | Use it to replace bootstrap `<div class="input-group-addon">` |
| validIcon  `<valid-icon>`             | Use it to replace bootstrap `<span class="valid-icon glyphicon glyphicon-ok form-control-feedback"></span>` |
| loaderIcon `<loader-icon>`            | Use it inside `<form-control>` to display a loader icon inside an input field. |


### Example

```html
<form-control class="col-md-6">
  <label for="minLength4">Min Length</label>
  <input name="minLength"
    id="minLength4"
    type="text"
    placeholder="Min Length"
    class="form-control"
    ng-model="myForm.minLength"
    ng-required="true"
    ng-minlength="3">

  <valid-icon></valid-icon>
  <error-message class="ng-required">Field is required</error-message>
  <error-message class="ng-minlength">Please type more than 3 characters</error-message>

</form-control>
```

```html
<form-control class="col-md-6">
  <label for="remoteValidation11">remoteValidation</label>
  <input name="remoteValidation"
    id="remoteValidation11"
    autocomplete="remoteValidation"
    type="text"
    placeholder="remoteValidation"
    class="form-control"
    ng-model="myForm.remoteValidation"
    remote-validation="remoteValidation.json"
    ng-required="true">

  <valid-icon></valid-icon>
  <loader-icon></loader-icon>
  <error-message class="ng-required">Field is required</error-message>
  <error-message class="remote-validation">Remote Error</error-message>

</form-control>
```
