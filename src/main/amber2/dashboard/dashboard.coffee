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

    @getInstance: (context) ->
      @_instance ||= new MobileDashboard context

    @run: (options) ->
      @_instance.run options

    @destroy: ->
      @_instance.destroy()

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    @refreshDashlet: ->
      @_instance.refreshDashlet()

    @refresh: ->
      @_instance.refresh()

    # Auth {'username': '%@', 'password': '%@', 'organization': '%@'}
    authorize: (options) ->
      @session = new Session options

    @authorize: (options) ->
      @_instance.authorize options

    constructor: (@context) ->
      @context.callback.onScriptLoaded()

    destroy: ->
      @_controller.destroyDashboard()

    # Run {'uri': '%@'}
    run: (options) ->
      options.session = @session
      options.context = @context
      options.scaler = new Scaler options

      @_controller = new DashboardController options
      @_controller.runDashboard()

    minimizeDashlet: ->
      @_controller.minimizeDashlet()

    refreshDashlet: ->
      @_controller.refreshDashlet()

    refresh: ->
      @_controller.refresh()

  root = window ? exports
  root.MobileDashboard = MobileDashboard
