if jQuery then $ = jQuery else $ = require "jquery"

module.exports = () ->
  restrict: 'E'
  transclude: true
  template: require './form-tabs.jade'
  replace: true
  scope:
    selectFormTabIndex: '@'
  controller:
    [
      '$scope'
      '$element'
      '$attrs'
      ($scope, $element, $attrs) ->
        panes = $scope.panes = [];

        $attrs.$observe('selectFormTabIndex', (newValue) ->
          $scope.select(panes[newValue])
        )

        $scope.select = (pane) ->
          $scope.$parent.selectFormTabIndex = $scope.getPaneIndex(pane);
          return unless (pane?)
          angular.forEach(panes, (pane) ->
            pane.selected = false
          )
          pane.disabled = false
          pane.selected = true

        $scope.getPaneIndex = @getPaneIndex = (currentPane) ->
          return -1 unless (currentPane?)
          for pane,index in panes
            if (pane == currentPane)
              return index;
          return -1

        @getNextPane = (pane) ->
          panes[$scope.getPaneIndex(pane) + 1]

        @selectNextPane = (pane) ->
          nextPane = @getNextPane(pane);
          $scope.select(nextPane);

          $scope.$evalAsync(()  ->
            nextPane.setFocus();
          )

        @isLastPane = (pane) ->
          $scope.getPaneIndex(pane) == panes.length - 1 || @getNextPane()==null

        @addPane = (pane) ->
          @addPaneAt(pane, panes.length)

        @addPaneAt = (pane, index) ->
          $scope.select(pane) if (panes.length == 0)
          panes.splice(index, 0, pane) if ($scope.getPaneIndex(pane) < 0)


        @removePane = (current_pane) ->
          return false unless (current_pane?)

          for pane,index in panes
            if (pane == current_pane)
              current_pane.disabled = true
              panes.splice(index, 1)
              return true
    ]
