define 'js.mobile.amber.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber.dashboard.controller'
  Scaler = require 'js.mobile.dashboard.scaler'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileDashboard extends Module
    @include lifecycle.dashboard.instanceMethods
    @extend lifecycle.dashboard.staticMethods

    @_instance: null

    @newInstance: (args) ->
      @_instance ||= new MobileDashboard args

    @configure: (options) ->
      @_instance.options = options
      @_instance

    @run: ->
      @_instance.run()

    @minimizeDashlet: ->
      @_instance._minimizeDashlet()

    constructor: (@args) ->
      @args.callback.onScriptLoaded()

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
      @args.scaler = new Scaler @options
      @_controller = new DashboardController @args
      @_controller.initialize()

  window.MobileDashboard = MobileDashboard
