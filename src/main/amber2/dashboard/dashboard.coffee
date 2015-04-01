define 'js.mobile.amber2.dashboard', (require) ->
  DashboardController = require 'js.mobile.amber2.dashboard.controller'
  Session = require 'js.mobile.session'

  class MobileDashboard
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
      @dashboardController.destroyDashboard()

    # Run {'uri': '%@'}
    run: (options) ->
      options.session = @session
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
