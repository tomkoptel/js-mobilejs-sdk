define 'js.mobile.amber.dashboard.controller',(require) ->
  View = require 'js.mobile.amber.dashboard.view'
  DOMTreeObserver = require 'js.mobile.dom_tree_observer'

  class DashboardController
    constructor: (options) ->
      {@context, @viewport, @scaler} = options
      @logger = @context.logger
      @callback = @context.callback

    initialize: ->
      @callback.onLoadStart()
      jQuery( document ).ready( () =>
        @logger.log "document ready"
        @scaler.initialize()
        @_removeRedundantArtifacts()
        @_injectViewport()
        @_attachDashletLoadListeners()
      )

    minimizeDashlet: ->
      @logger.log "minimize dashlet"
      @logger.log "Remove original scale"
      @_removeOriginalScale()
      @_disableDashlets()
      @_hideDashletChartTypeSelector()

      @callback.onMinimizeStart()
      DOMTreeObserver.lastModify( () =>
        @_hideDashletChartTypeSelector()
        @callback.onMinimizeEnd()
      ).wait()

      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()

    pause: ->
      @callback.setPause true

    resume: ->
      @callback.setPause false
      @callback.firePendingTasks()

    # Private

    _removeRedundantArtifacts: ->
      @logger.log "remove artifacts"
      customStyle = "
        .header, .dashletToolbar {
            display: none !important;
        }
        .show_chartTypeSelector_wrapper {
            display: none;
        }
        .column.decorated {
            margin: 0 !important;
            border: none !important;
        }
        .dashboardViewer.dashboardContainer>.content>.body,
        .column.decorated>.content>.body,
        .column>.content>.body {
              top: 0 !important;
        }
        #mainNavigation{
          display: none !important;
        }
        .customOverlay {
          position: absolute;
          width: 100%;
          height: 100%;
          z-index: 1000;
        }
        .dashboardCanvas .dashlet > .dashletContent > .content {
          -webkit-overflow-scrolling : auto !important;
        }
        .component_show {
          display: block;
        }
      "
      jQuery('<style id="custom_mobile"></style>').text(customStyle).appendTo 'head'

    _hideDashletChartTypeSelector: ->
      @logger.log "hide dashlet chart type selector"
      jQuery('.show_chartTypeSelector_wrapper').removeClass('component_show')

    _showDashletChartTypeSelector: ->
      @logger.log "show dashlet chart type selector"
      jQuery('.show_chartTypeSelector_wrapper').addClass('component_show')

    _injectViewport: ->
      @logger.log "inject custom viewport"
      @viewport.configure()

    _attachDashletLoadListeners: ->
      @logger.log "attaching dashlet listener"

      dashboardElInterval = window.setInterval () =>
        dashboardContainer = jQuery('.dashboardCanvas')

        if dashboardContainer.length > 0
          window.clearInterval dashboardElInterval
          @_scaleDashboard()
          DOMTreeObserver.lastModify(@_configureDashboard).wait()

      , 500

    _configureDashboard: =>
      @logger.log "_configureDashboard"
      @_createCustomOverlays()
      @_overrideDashletTouches()
      @_disableDashlets()
      @_setupResizeListener()
      @callback.onLoadDone()

    _scaleDashboard: ->
      @logger.log "_scaleDashboard #{jQuery('.dashboardCanvas').length}"
      jQuery('.dashboardCanvas').addClass 'scaledCanvas'

    _createCustomOverlays: ->
      @logger.log "_createCustomOverlays"
      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      @logger.log "dashletElements #{dashletElements.length}"
      jQuery.each dashletElements, (key, value) ->
        dashlet = jQuery(value)
        overlay = jQuery("<div></div>")
        overlay.addClass "customOverlay"
        dashlet.prepend overlay

    _setupResizeListener: ->
      @logger.log "set resizer listener"
      jQuery(window).resize () =>
        @logger.log "inside resize callback"
        @callback.onWindowResizeStart()
        DOMTreeObserver.lastModify(@callback.onWindowResizeEnd).wait()

    _disableDashlets: ->
      @logger.log "disable dashlet touches"
      jQuery('.customOverlay').css 'display', 'block'

    _enableDashlets: ->
      @logger.log "enable dashlet touches"
      jQuery('.customOverlay').css 'display', 'none'

    _overrideDashletTouches: =>
      @logger.log "override dashlet touches"

      dashlets = jQuery('.customOverlay')
      dashlets.unbind()
      self = @

      dashlets.click ->
        dashlet = jQuery(@).parent()
        innerLabel = dashlet.find('.innerLabel > p')
        if innerLabel? and innerLabel.text?
          title = innerLabel.text()
          if title? and title.length > 0
            self._maximizeDashlet dashlet, title

    _maximizeDashlet: (dashlet, title) ->
      @logger.log "maximizing dashlet"
      @_enableDashlets()

      @callback.onMaximizeStart title
      endListener = () =>
        @_showDashletChartTypeSelector()
        @callback.onMaximizeEnd title

      DOMTreeObserver.lastModify(endListener).wait()

      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()

      @logger.log "Add original scale"
      @_addOriginalScale()

    _addOriginalScale: ->
      @_getOverlay().addClass "originalDashletInScaledCanvas"

    _removeOriginalScale: ->
       @_getOverlay().removeClass "originalDashletInScaledCanvas"

    _getOverlay: ->
      jQuery(".dashboardCanvas > .content > .body div.canvasOverlay")
