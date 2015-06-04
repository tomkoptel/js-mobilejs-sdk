define 'js.mobile.amber.dashboard.controller',(require) ->
  DOMTreeObserver = require 'js.mobile.dom_tree_observer'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class DashboardController extends Module
    @include lifecycle.dashboardController.instanceMethods

    constructor: (args) ->
      {@callback, @viewport, @scaler} = args

    initialize: ->
      @_injectViewport()
      @callback.onLoadStart()      
      jQuery( document ).ready( () =>
        js_mobile.log "document ready"
        @_attachDashletLoadListeners()        
        @_removeRedundantArtifacts()
      )

    minimizeDashlet: ->
      js_mobile.log "minimize dashlet"
      js_mobile.log "Remove original scale"
      @_removeOriginalScale()
      @_disableDashlets()
      @_hideDashletChartTypeSelector()

      @callback.onMinimizeStart()
      DOMTreeObserver.lastModify( () =>
        @_hideDashletChartTypeSelector()
        @callback.onMinimizeEnd()
      ).wait()

      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()

    # Private

    _removeRedundantArtifacts: ->
      js_mobile.log "remove artifacts"
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
      js_mobile.log "hide dashlet chart type selector"
      jQuery('.show_chartTypeSelector_wrapper').removeClass('component_show')

    _showDashletChartTypeSelector: ->
      js_mobile.log "show dashlet chart type selector"
      jQuery('.show_chartTypeSelector_wrapper').addClass('component_show')

    _injectViewport: ->
      js_mobile.log "inject custom viewport"
      @viewport.configure()

    _attachDashletLoadListeners: ->
      js_mobile.log "attaching dashlet listener"
      dashboardElInterval = window.setInterval () =>
        dashboardContainer = jQuery('.dashboardCanvas')
        
        if dashboardContainer.length > 0
          window.clearInterval dashboardElInterval
          DOMTreeObserver.lastModify(@_configureDashboard).wait()
          @_scaleDashboard()
      , 50

    _configureDashboard: =>
      js_mobile.log "_configureDashboard"
      @_createCustomOverlays()
      @_overrideDashletTouches()
      @_disableDashlets()
      @_setupResizeListener()
      @callback.onLoadDone()

    _scaleDashboard: ->
      @scaler.applyScale()
      js_mobile.log "_scaleDashboard #{jQuery('.dashboardCanvas').length}"
      jQuery('.dashboardCanvas').addClass 'scaledCanvas'

    _createCustomOverlays: ->
      js_mobile.log "_createCustomOverlays"
      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      js_mobile.log "dashletElements #{dashletElements.length}"
      jQuery.each dashletElements, (key, value) ->
        dashlet = jQuery(value)
        overlay = jQuery("<div></div>")
        overlay.addClass "customOverlay"
        dashlet.prepend overlay

    _setupResizeListener: ->
      js_mobile.log "set resizer listener"
      jQuery(window).resize () =>
        js_mobile.log "inside resize callback"
        @callback.onWindowResizeStart()
        DOMTreeObserver.lastModify(@callback.onWindowResizeEnd).wait()

    _disableDashlets: ->
      js_mobile.log "disable dashlet touches"
      jQuery('.customOverlay').css 'display', 'block'

    _enableDashlets: ->
      js_mobile.log "enable dashlet touches"
      jQuery('.customOverlay').css 'display', 'none'

    _overrideDashletTouches: =>
      js_mobile.log "override dashlet touches"

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
      js_mobile.log "maximizing dashlet"
      @_enableDashlets()

      @callback.onMaximizeStart title
      endListener = () =>
        @_showDashletChartTypeSelector()
        @callback.onMaximizeEnd title

      DOMTreeObserver.lastModify(endListener).wait()

      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()

      js_mobile.log "Add original scale"
      @_addOriginalScale()

    _addOriginalScale: ->
      @_getOverlay().addClass "originalDashletInScaledCanvas"

    _removeOriginalScale: ->
       @_getOverlay().removeClass "originalDashletInScaledCanvas"

    _getOverlay: ->
      jQuery(".dashboardCanvas > .content > .body div.canvasOverlay")      
