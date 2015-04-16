define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  DashboardWindow = require 'js.mobile.amber.dashboard.window'
  Scaler = require 'js.mobile.scaler'

  class MobileDashboard
    @_instance: null

    @getInstance: (context, viewport) ->
      @_instance ||= new MobileDashboard context, viewport

    @configure: (options) ->
      @_instance.options = options
      @_instance

    @run: ->
      @_instance.run()

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    constructor: (@context, @viewport) ->
      @context.callback.onScriptLoaded()

    run: ->
      scaler = new Scaler @options
      @dashboardController = new DashboardController
       context: @context
       viewport: @viewport
       scaler: scaler

      @dashboardController.initialize()

    minimizeDashlet: ->
      @dashboardController.minimizeDashlet()

  root = window ? exports
  root.MobileDashboard = MobileDashboard
