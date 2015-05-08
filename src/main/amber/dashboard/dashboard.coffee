define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  DashboardWindow = require 'js.mobile.amber.dashboard.window'
  Scaler = require 'js.mobile.scaler'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileDashboard extends Module
    @include lifecycle.dashboard.instanceMethods
    @extend lifecycle.dashboard.staticMethods

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
      if not @_controller?
        alert "MobileDashboard not initialized"
      else
        @_controller.minimizeDashlet()

    # Private methods
    _initController: ->
      scaler = new Scaler @options
      @_controller = new DashboardController
       context: @context
       viewport: @viewport
       scaler: scaler

      @_controller.initialize()

  window.MobileDashboard = MobileDashboard
