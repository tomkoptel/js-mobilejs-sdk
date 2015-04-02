define 'js.mobile.amber2.dashboard.controller', (require) ->
  $ = require 'jquery'
  Scaler = require 'js.mobile.scaler'

  class DashboardController
    constructor: (options) ->
      {@context, @session, @uri} = options
      @callback = @context.callback
      @logger = @context.logger
      @scaler = new Scaler

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

      @dashboard.updateComponent component.id,
        maximized: false
        interactive: false

      @logger.log "onMinimize"
      @callback.onMinimize()

    runDashboard: ->
      @callback.onLoadStart()

      self = @
      visualize @session.authOptions(), (v) ->
        self.v = v
        self.scaler.scale 0.25

        self.dashboard = v.dashboard
          report:
            chart:
              animation: false
              zoom: false
          container: '#container'
          resource: self.uri
          success: ->
            self.selfDashboard = @
            self.data = @data()
            self.components = @data().components
            self.container = @container()
            self._scaleContainer()
            self._configureComponents()
            self._defineComponentsClickEvent()
            self.callback.onLoadDone()
          error: (e) ->
            self.logger.log error
            self.callback.onLoadError error
            return

    _scaleContainer: ->
      @logger.log "Scale dashboard"
      $(@container).find('.dashboardCanvas').addClass 'scaledCanvas'

    _configureComponents: ->
      @logger.log "Iterate components"
      @components.forEach (component) =>
        if component.type != 'inputControl'
          @dashboard.updateComponent component.id,
            interactive: false
            toolbar: false
        return

    _defineComponentsClickEvent: ->
      @logger.log "Apply click events"
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

          self.dashboard.updateComponent id,
            maximized: true
            interactive: true

          self.maximizedComponent = component
          self.callback.onMaximize component.name

        return

    _getComponentById: (id) ->
      @dashboard.data().components.filter((c) ->
        c.id == id
      )[0]
