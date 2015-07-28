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
      @_showDashlets()
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
      @_setGlobalErrorListener()
      @_scaleDashboard()
      @callback.onLoadStart()
      if @session?
        visualize @session.authOptions(), @_executeDashboard, @_processErrors
      else
        js_mobile.log "Without session"
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
            click: @_processLinkClicks
        error: @_processErrors

    _processSuccess: (dashboard) =>
      @data = dashboard.data()
      @components = @data.components
      @container = dashboard.container()
      @_configureComponents()
      @_defineComponentsClickEvent()
      @callback.onLoadDone(@components)

    _processErrors: (error) =>
      js_mobile.log JSON.stringify error
      if error.errorCode is "authentication.error"
        @callback.onAuthError error.message
      else
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
      @_getDashlets(dashboardId).on 'click', () ->
        $('.show_chartTypeSelector_wrapper').show()

        dashlet = $(this)
        id = dashlet.attr dashboardId
        component = self._getComponentById id
        self._hideDashlets(dashboardId, dashlet)

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
  	
    _processLinkClicks: (event, link, defaultHandler) =>
      type = link.type
      js_mobile.log "_processLinkClicks: #{JSON.stringify link}"
      js_mobile.log "type: #{type}"
      
      switch type
        when "ReportExecution" then @_startReportExecution link
        when "Reference" then @_openRemoteLink link
        when "LocalAnchor" then defaultHandler.call @
        when "LocalPage" then defaultHandler.call @
        when "AdHocExecution" then @_adHocHandler link, defaultHandler
        else defaultHandler.call @
    
    _startReportExecution: (link) =>
      js_mobile.log "_startReportExecution"
      js_mobile.log "resource: #{link.parameters._report}"
      data = 
        resource : link.parameters._report
        params : @_collectReportParams link
      @callback.onReportExecution data  

    _collectReportParams: (link) ->
      params = {}
      for key of link.parameters
        if key != '_report'
          parameters = link.parameters[key]
          isValueNotArray = Object::toString.call(parameters) != '[object Array]'          
          params[key] = if isValueNotArray then [parameters] else parameters
      params
      
    _openRemoteLink: (link) =>
      js_mobile.log "_openRemoteLink"
      href = link.href
      @callback.onReferenceClick href

    _adHocHandler: (link, defaultHandler) =>
      js_mobile.log "_adHocHandler"        
      defaultHandler.call @

    _getDashlets: (dashboardId) ->
      if dashboardId?
        $(@container).find("[#{dashboardId}] > .dashlet").parent()
      else
        $(@container).find(".dashlet").parent()

    _hideDashlets: (dashboardId, dashlet) ->
      @_getDashlets(dashboardId).not(dashlet).css("opacity", 0)

    _showDashlets: ->
      document.activeElement.blur()
      @_getDashlets().css("opacity", 1)

    _setGlobalErrorListener: ->
      window.onerror = (errorMsg, url, lineNumber) =>
        @callback.onWindowError(errorMsg);
