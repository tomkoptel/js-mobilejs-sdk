define 'js.mobile.amber2.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber2.dashboard.controller'
  Session = require 'js.mobile.session'

  class MobileDashboard
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileDashboard context

    @run: (options) ->
      @_instance.run options

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    @refreshDashlet: ->
      @_instance.refreshDashlet()

    @refresh: ->
      @_instance.refresh()

    constructor: (@context) ->
      @context.callback.onScriptLoaded()

    run: (options) ->
      options.session = new Session options
      options.context = @context
      @dashboardController = new DashboardController options
      @dashboardController.runDashboard()

    minimizeDashlet: ->
      @dashboardController.minimizeDashlet()

    refreshDashlet: ->
      @dashboardController.refreshDashlet()

    refresh: ->
      @dashboardController.refresh()

  root = window ? exports
  root.MobileDashboard = MobileDashboard
