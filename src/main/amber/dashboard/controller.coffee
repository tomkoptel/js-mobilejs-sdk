define 'js.mobile.amber.dashboard.controller', ['js.mobile.amber.dashboard.view'], (View) ->
  class DashboardController

    constructor: (@context) ->
      @logger = @context.logger
      @callback = @context.callback
      @container = new View el: jQuery('#frame'), context: @context
      @dashletsLoaded = false

    initialize: ->
      @_injectViewport()
      @_scaleDashboard()
      @_attachDashletLoadListeners()

    minimizeDashlet: ->
      @logger.log "minimize dashlet"
      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()

      @_disableDashlets()
      @callback.onMinimize()

    # Private

    _injectViewport: ->
      viewPort = document.querySelector 'meta[name=viewport]'
      viewPort.setAttribute 'content', "width=device-width, height=device-height, user-scalable=yes"

    _scaleDashboard: ->
      @container.scaleView()

    _attachDashletLoadListeners: ->
      timeInterval = window.setInterval () =>
        window.clearInterval timeInterval

        timeIntervalDashletContent = window.setInterval () =>
          dashlets = jQuery('.dashlet')
          @_removeRedundantArtifacts()

          if dashlets.length > 0
            @_disableDashlets()
            dashletContent = jQuery('.dashletContent > div.content')

            if dashletContent.length is dashlets.length
              @_configureDashboard()
              window.clearInterval timeIntervalDashletContent
        , 100
      , 100

    _configureDashboard: ->
      @_overrideDashletTouches()
      @_disableDashlets()
      @_removeRedundantArtifacts()
      @callback.onDashletsLoaded()

    _removeRedundantArtifacts: ->
      jQuery('.header').hide()
      jQuery('.dashletToolbar').hide()
      jQuery('.show_chartTypeSelector_wrapper').hide()
      jQuery('.column.decorated').css 'margin', '0px'
      jQuery('.column.decorated').css 'border', 'none'
      jQuery('.dashboardViewer .dashboardContainer > .content > .body').css 'top', '0px'
      jQuery('.column.decorated > .content > .body').css 'top', '0px'
      jQuery('.column > .content > .body').css 'top', '0px'
      jQuery('body').css '-webkit-transform', 'translateZ(0) !important'
      jQuery('body').css '-webkit-backface-visibility', 'hidden !important'


    _disableDashlets: ->
      @logger.log "disable dashlet touches"
      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      dashlets = new View el: dashletElements, context: @context
      dashlets.disable()

    _overrideDashletTouches: ->
      @logger.log "override dashlet touches"

      dashlets = jQuery('div.dashboardCanvas > div.content > div.body > div')
      dashlets.unbind()
      self = @

      dashlets.click ->
        dashlet = jQuery(@)
        innerLabel = dashlet.find('.innerLabel > p')
        if innerLabel? and innerLabel.text?
          title = innerLabel.text()
          if title? and title.length > 0
            self._maximizeDashlet dashlet, title

    _maximizeDashlet: (dashlet, title) ->
      @logger.log "maximizing dashlet"
      @logger.log "context: " + @context

      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      dashlets = new View el: dashletElements, context: @context
      dashlets.enable()

      @callback.onMaximize title

      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()
