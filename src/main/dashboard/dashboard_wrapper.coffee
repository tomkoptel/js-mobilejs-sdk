define 'js.mobile.dashboard.wrapper', ['js.mobile.dashboard.controller', 'js.mobile.dashboard.window'], (DashboardController, DashboardWindow) ->
  class DashboardWrapper
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new DashboardWrapper context

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
  root.DashboardWrapper = DashboardWrapper
