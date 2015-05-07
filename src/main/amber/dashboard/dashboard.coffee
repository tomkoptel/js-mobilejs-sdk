define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  DashboardWindow = require 'js.mobile.amber.dashboard.window'
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

    @pause: ->
      @_instance._pause()

    @resume: ->
      @_instance._resume()

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

    _pause: ->
      @dashboardController.pause()

    _resume: ->
      @dashboardController.resume()

  window.MobileDashboard = MobileDashboard
