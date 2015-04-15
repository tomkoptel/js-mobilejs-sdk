define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  DashboardWindow = require 'js.mobile.amber.dashboard.window'

  class MobileDashboard
    @_instance: null

    @getInstance: (context, viewport) ->
      @_instance ||= new MobileDashboard context, viewport

    @run: ->
      @_instance.run()

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    constructor: (@context, @viewport) ->
      @context.callback.onScriptLoaded()

    run: ->
      window = new DashboardWindow('100%', '100%')
      @context.setWindow window
      @dashboardController = new DashboardController @context, @viewport
      @dashboardController.initialize()

    minimizeDashlet: ->
      @dashboardController.minimizeDashlet()

  root = window ? exports
  root.MobileDashboard = MobileDashboard
