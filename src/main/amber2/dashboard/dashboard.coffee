define 'js.mobile.amber2.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber2.dashboard.controller'
  Session = require 'js.mobile.session'
  Scaler = require 'js.mobile.scaler'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileDashboard extends Module
    @include lifecycle.dashboard.instanceMethods
    @extend lifecycle.dashboard.staticMethods
    @_instance: null

    @getInstance: (args) ->
      @_instance ||= new MobileDashboard args

    # 'diagonal' refers to native device physical property
    @configure: (configs) ->
      @_instance._configure(configs)
      @_instance

    _configure: (configs) ->
      @scaler = new Scaler
        diagonal: configs.diagonal

    # 'uri' represents dashboard adress
    @run: (params) ->
      @_instance.run params

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
      {@callback} = args
      @scaler = new Scaler {}
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
