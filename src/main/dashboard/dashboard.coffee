define 'js.mobile.dashboard', ['js.mobile.dashboard.controller', 'js.mobile.dashboard.window'], (DashboardController, DashboardWindow) ->
  class MobileDashboard
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileDashboard context

    @wrapScreen: (width, height) ->
      @_instance.wrapScreen width, height

    @minimizeDashlet: ->
      @_instance.minimizeDashlet()

    constructor: (@context) ->
      @context.callback.onDashletsLoaded()

    wrapScreen: (width, height) ->
      window = new DashboardWindow(width, height)
      @context.setWindow window
      @dashboardController = new DashboardController @context
      @dashboardController.initialize()

    minimizeDashlet: ->
      @dashboardController.minimizeDashlet()

  root = window ? exports
  root.MobileDashboard = MobileDashboard
