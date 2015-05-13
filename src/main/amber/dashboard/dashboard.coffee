define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  Scaler = require 'js.mobile.scaler'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileDashboard extends Module
    @include lifecycle.dashboard.instanceMethods
    @extend lifecycle.dashboard.staticMethods

    @_instance: null

    @newInstance: (context, viewport) ->
      @_instance ||= new MobileDashboard context, viewport

    @configure: (options) ->
      @_instance.options = options
      @_instance

    @run: ->
      @_instance.run()

    @minimizeDashlet: ->
      @_instance._minimizeDashlet()

    constructor: (@context, @viewport) ->
      @context.callback.onScriptLoaded()

    run: ->
      if not @options?
        alert "Run was called without options"
      else
        @_initController()

    # Private methods

    _minimizeDashlet: ->
      if not @_controller?
        alert "MobileDashboard not initialized"
      else
        @_controller.minimizeDashlet()

    _initController: ->
      scaler = new Scaler @options
      @_controller = new DashboardController
       context: @context
       viewport: @viewport
       scaler: scaler

      @_controller.initialize()

  window.MobileDashboard = MobileDashboard
