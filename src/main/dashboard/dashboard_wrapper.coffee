define 'js.mobile.dashboard.wrapper', ->
  class DashboardWrapper
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new DashboardWrapper context

    @wrapScreen: (width, height) ->
      @_instance.wrapScreen width, height

    constructor: (@context) ->

    wrapScreen: (width, height) ->
      window = new DashboardWindow(width, height)
      @context.setWindow window
      @dashboardController = new DashboardController @context
      dashboardController.injectViewport()
      dashboardController.scaleDashboard()
      dashboardController.attachDashletLoadListeners()

    minimizeDashlet: ->
      @dashboardController.minimizeDashlet()
