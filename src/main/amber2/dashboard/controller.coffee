define 'js.mobile.amber2.dashboard.controller', (require) ->
  $ = require 'jquery'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class DashboardController extends Module
    @include lifecycle.dashboardController.instanceMethods

    constructor: (@callback, @scaler, params) ->
      {@uri, @session} = params
      @scaler.applyScale()

    destroyDashboard: ->
      @dashboard.destroy()

    refreshDashlet: ->
      if @maximizedComponent
        @dashboard.refresh(@maximizedComponent.id)

    refresh: ->
      @components.forEach (component) =>
        @dashboard.refresh(component.id)

    minimizeDashlet: ->
      $('.show_chartTypeSelector_wrapper').hide()

      dashboardId = @v.dashboard.componentIdDomAttribute
      component = @maximizedComponent

      $(@dashboard.container())
        .find("[#{dashboardId}='#{component.id}']")
        .removeClass 'originalDashletInScaledCanvas'

      @callback.onMinimizeStart()
      @dashboard.updateComponent component.id,
        maximized: false
        interactive: false
        , () =>
          @callback.onMinimizeEnd()
        , (error) =>
          @callback.onMinimizeFailed(error)

    runDashboard: ->
      @_scaleDashboard()
      @callback.onLoadStart()
      if @session?
        visualize @session.authOptions(), @_executeDashboard, @_processErrors
      else
        visualize @_executeDashboard, @_processErrors

    _executeDashboard: (@v) =>
      processSuccess = @_processSuccess
      @dashboard = @v.dashboard
        report:
          chart:
            animation: false
            zoom: false
        container: '#container'
        resource: @uri
        success: -> processSuccess @
        linkOptions:
          events:
            click: self._clickCallback
        error: @_processErrors

    _processSuccess: (dashboard) =>
      @data = dashboard.data()
      @components = @data.components
      @container = dashboard.container()
      @_configureComponents()
      @_defineComponentsClickEvent()
      @callback.onLoadDone(@components)

    _processErrors: (error) ->
      js_mobile.log JSON.stringify error
      @callback.onLoadError error.message

    _scaleDashboard: ->
      js_mobile.log "Scale dashboard"
      $('#container').addClass 'scaledCanvas'

    _configureComponents: ->
      js_mobile.log "Iterate components"
      @components.forEach (component) =>
        if component.type != 'inputControl'
          @dashboard.updateComponent component.id,
            interactive: false
            toolbar: false
        return

    _defineComponentsClickEvent: ->
      js_mobile.log "Apply click events"
      dashboardId = @v.dashboard.componentIdDomAttribute

      self = @
      $(@container).find("[#{dashboardId}]").on 'click', () ->
        $('.show_chartTypeSelector_wrapper').show()

        id = $(this).attr dashboardId
        component = self._getComponentById id

        if component and !component.maximized
          $(self.container)
            .find("[#{dashboardId}='#{id}']")
            .addClass 'originalDashletInScaledCanvas'

          self.callback.onMaximizeStart component.name
          self.dashboard.updateComponent id,
            maximized: true
            interactive: true
            , () ->
              self.maximizedComponent = component
              self.callback.onMaximizeEnd component.name
            , (error) ->
              self.callback.onMaximizeFailed error

        return

    _getComponentById: (id) ->
      @dashboard.data().components.filter((c) ->
        c.id == id
      )[0]

# Click events

    _clickCallback: (event, link) =>
      if link.type is "ReportExecution"
        data =
          resource: link.parameters._report
          params: @_collectReportParams link
        dataString = JSON.stringify(data, null, 4)
        @callback.onReportExecution dataString

    _collectReportParams: (link) ->
        params = {}
        for key of link.parameters
          if key != '_report'
            isValueNotArray = Object::toString.call(link.parameters[key]) != '[object Array]'
            params[key] = if isValueNotArray then [ link.parameters[key] ] else link.parameters[key]
        params
