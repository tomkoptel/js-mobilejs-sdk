define 'js.mobile.amber2.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber2.dashboard.controller'
  Session = require 'js.mobile.session'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileDashboard extends Module
    @include lifecycle.dashboard.instanceMethods
    @extend lifecycle.dashboard.staticMethods
    @_instance: null

    @getInstance: (args) ->
      @_instance ||= new MobileDashboard args

    # Deprecated. We are not using auth explicitly!
    # Auth {'username': '%@', 'password': '%@', 'organization': '%@'}
    @authorize: (options) ->
      @_instance._authorize options

    _authorize: (options) ->
      @session = new Session options

    # 'diagonal' refers to native device physical property
    @configure: (configs) ->
      @_instance._configure(configs)
      @_instance

    _configure: (configs) ->
      @scaler = ScaleManager.getDashboardManager configs.diagonal

    # Deprecated. We will not expose run as class method in future.
    # 'uri' represents dashboard adress
    @run: (params) ->
      @_instance._legacyRun params

    # It is temp solution. Remove this config as soon as @authorize will be removed
    _legacyRun: (params) ->
      params.session = @session
      scaler = ScaleManager.getDashboardManager params.diagonal

      @_controller = new DashboardController @callback, scaler, params
      @_controller.runDashboard()

    run: (params) ->
      @_controller = new DashboardController @callback, @scaler, params
      @_controller.runDashboard()

    @destroy: ->
      @_instance._destroy()

    @minimizeDashlet: ->
      @_instance._minimizeDashlet()

    @refreshDashlet: ->
      @_instance._refreshDashlet()

    @refresh: ->
      @_instance._refresh()

    constructor: (args) ->
      {@callback, @scaler} = args
      @callback.onScriptLoaded()

    # Private methods
    _destroy: ->
      @_controller.destroyDashboard()

    _minimizeDashlet: ->
      @_controller.minimizeDashlet()

    _refreshDashlet: ->
      @_controller.refreshDashlet()

    _refresh: ->
      @_controller.refresh()

  window.MobileDashboard = MobileDashboard
