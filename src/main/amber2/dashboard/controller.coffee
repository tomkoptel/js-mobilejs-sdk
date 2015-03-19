define 'js.mobile.amber2.dashboard.controller', (require) ->
  $ = require 'jquery'

  class DashboardController

    constructor: (options) ->
      {@context, @session, @uri} = options
      @callback = @context.callback
      @logger = @context.logger

    runDashboard: ->
      @callback.onLoadStart()

      self = @
      visualize @session.authOptions(), (v) ->
        self.v = v
        self.generateScalingClasses 0.5

        self.dashboard = v.dashboard
          animation: false
          container: '#container'
          resource: self.uri
          success: ->
            self.logger.log "Scale dashboard"
            self.components = @data().components
            $(@container()).find('.dashboardCanvas').addClass 'scaledCanvas'

            self.logger.log "Iterate components"
            @data().components.forEach (component) ->
              if component.type != 'inputControl'
                self.dashboard.updateComponent component.id,
                  interactive: false
                  toolbar: false
              return

            self.logger.log "Apply click events"
            dashboardId = self.v.dashboard.componentIdDomAttribute

            $(@container()).find("[#{dashboardId}]").on 'click', () ->
              $('.show_chartTypeSelector_wrapper').show()

              id = $(this).attr dashboardId
              component = self.getComponentById id

              if component and !component.maximized
                $(self.dashboard.container())
                  .find("[#{dashboardId}='#{id}']")
                  .addClass 'originalDashletInScaledCanvas'

                self.dashboard.updateComponent id,
                  maximized: true
                  interactive: true

                self.maximizedComponent = component
                self.logger.log "onMaximize"
                self.callback.onMaximize component.name

              return

            self.callback.onLoadDone()

            return
          error: (e) ->
            self.logger.log error
            self.callback.onLoadError error
            return

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

    getComponentById: (id) ->
      @dashboard.data().components.filter((c) ->
        c.id == id
      )[0]

    generateScalingClasses: (factor) ->
      scaledCanvasCss =
        ".scaledCanvas {
           transform-origin: 0 0 0;
           -ms-transform-origin: 0 0 0;
           -webkit-transform-origin: 0 0 0;

           transform: scale( #{factor} );
           -ms-transform: scale( #{factor} );
           -webkit-transform: scale( #{factor} );

           width: #{100 / factor}% !important;
           height: #{100 / factor}% !important;
         }"
      originalDashletInScaledCanvasCss =
        ".dashboardCanvas > .content > .body div.canvasOverlay.originalDashletInScaledCanvas {
          transform-origin: 0 0 0;
          -ms-transform-origin: 0 0 0;
          -webkit-transform-origin: 0 0 0;

          transform: scale( #{1 / factor} );
          -ms-transform: scale( #{1 / factor} );
          -webkit-transform: scale( #{1 / factor} );

          width: #{100 * factor}% !important;
          height: #{100 * factor}% !important;
        }"
      $('<style></style').text(scaledCanvasCss + originalDashletInScaledCanvasCss).appendTo 'head'
      return