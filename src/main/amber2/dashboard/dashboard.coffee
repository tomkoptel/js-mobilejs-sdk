define 'js.mobile.amber2.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber2.dashboard.controller'
  Session = require 'js.mobile.session'
  ScaleManager = require 'js.mobile.scale.manager'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileDashboard extends Module
    @include lifecycle.dashboard.instanceMethods
    @extend lifecycle.dashboard.staticMethods
    @_instance: null

    @getInstance: (args) ->
      @_instance ||= new MobileDashboard args

    @run: (options) ->
      @_instance._run options

    @destroy: ->
      @_instance._destroy()

    @minimizeDashlet: ->
      @_instance._minimizeDashlet()

    @refreshDashlet: ->
      @_instance._refreshDashlet()

    @refresh: ->
      @_instance._refresh()

    @authorize: (options) ->
      @_instance._authorize options

    constructor: (@args) ->
      @args.callback.onScriptLoaded()

    # Private methods

    # Run {'uri': '%@'}
    _run: (options) ->
      options.session = @session
      options.callback = @args.callback
      options.scaler = ScaleManager.getDashboardManager options.diagonal

      @_controller = new DashboardController options
      @_controller.runDashboard()

    _destroy: ->
      @_controller.destroyDashboard()

    _minimizeDashlet: ->
      @_controller.minimizeDashlet()

    _refreshDashlet: ->
      @_controller.refreshDashlet()

    _refresh: ->
      @_controller.refresh()

    # Auth {'username': '%@', 'password': '%@', 'organization': '%@'}
    _authorize: (options) ->
      @session = new Session options

  window.MobileDashboard = MobileDashboard
