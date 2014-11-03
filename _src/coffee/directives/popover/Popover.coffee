if jQuery then $ = jQuery else $ = require "jquery"
formElements = require "../../utils/FormElements.coffee"

module.exports = () ->
  restrict: 'E'
  transclude: true
  template: require './popover.jade'
  replace: false
  scope:
    preventCloseOnPopOverClick: '@'
    title:      '@'
    animation:  '@'
    container:  '@'
    placement:  '@'
    delay:      '@'
    trigger:    '@'
    viewport:   '@'

  link: (scope, elm, attrs) ->
    elm.hide()
    formControl = elm.parent().find(formElements).first()
    formControl = $(attrs.selector) if (attrs.selector)

    content = elm.find("[ng-transclude]")
    title = (if (content.find("h3").length>0) then content.find("h3").remove().text() else null)
    content = content.html()

    formControl.popover(
      {
        animation: attrs.animation=="true" || false
        container: attrs.container || null
        placement: attrs.placement || "top"
        delay: (if (attrs.delay && isNaN(parseInt(attrs.delay))) then parseInt(attrs.delay) else 0)
        trigger: attrs.trigger || "focus"
        viewport: attrs.viewport || { selector: 'body', padding: 0 }
        title: title
        content: content
        html: true
        template: elm.html()
      }
    )

    if (attrs.preventCloseOnPopOverClick=="true")
      formControl.bind(attrs.trigger || "focus", () ->
        formControl.parent().find(".popover").bind("mousedown", () ->
          formControl.bind("hide.bs.popover", cancelPopOverClose)
        )
        formControl.parent().find(".popover").bind("click", () ->
          formControl.unbind("hide.bs.popover", cancelPopOverClose)
          formControl.focus();
        )
      )

    cancelPopOverClose = (e) ->
      e.preventDefault()
