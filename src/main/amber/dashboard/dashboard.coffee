define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  DashboardWindow = require 'js.mobile.amber.dashboard.window'

  class MobileDashboard
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileDashboard context

    @wrapScreen: (width, height) ->
      @_instance.wrapScreen width, height

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    constructor: (@context) ->
      @context.callback.onScriptLoaded()

    wrapScreen: (width, height) ->
      window = new DashboardWindow(width, height)
      @context.setWindow window
      @dashboardController = new DashboardController @context
      @dashboardController.initialize()

    minimizeDashlet: ->
      @dashboardController.minimizeDashlet()

  root = window ? exports
  root.MobileDashboard = MobileDashboard