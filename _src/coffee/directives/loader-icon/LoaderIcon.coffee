module.exports = () ->
  restrict: 'E'
  transclude: true
  template:
    '<div class="spinner form-control-feedback loader">
      <div class="bounce1"></div>
      <div class="bounce2"></div>
      <div class="bounce3"></div>
    </div>'
  replace: true
