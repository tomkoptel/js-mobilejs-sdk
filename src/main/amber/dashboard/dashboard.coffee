define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  Scaler = require 'js.mobile.scaler'

  class MobileDashboard
    @_instance: null

    @newInstance: (context, viewport) ->
      @_instance ||= new MobileDashboard context, viewport

    constructor: (@context, @viewport) ->
      @context.callback.onScriptLoaded()

    @configure: (options) ->
      @_instance.options = options
      @_instance

    @run: ->
      @_instance.run()

    run: ->
      if not @options?
        alert "Run was called without options"
      else
        @_initController()

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    minimizeDashlet: ->
      if not @dashboardController?
        alert "MobileDashboard not initialized"
      else
        @dashboardController.minimizeDashlet()

    # Private methods
    _initController: ->
      scaler = new Scaler @options
      @dashboardController = new DashboardController
       context: @context
       viewport: @viewport
       scaler: scaler

      @dashboardController.initialize()

  root = window ? exports
  window.MobileDashboard = MobileDashboard
