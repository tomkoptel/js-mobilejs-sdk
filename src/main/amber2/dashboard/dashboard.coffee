define 'js.mobile.amber2.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber2.dashboard.controller'
  Session = require 'js.mobile.session'

  class MobileDashboard
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileDashboard context

    @run: (options) ->
      @_instance.run options

    constructor: (@context) ->
      @context.callback.onScriptLoaded()

    run: (options) ->
      options.session = new Session options
      options.context = @context
      @dashboardController = new DashboardController options
      @dashboardController.runDashboard()

  root = window ? exports
  root.MobileDashboard = MobileDashboard
