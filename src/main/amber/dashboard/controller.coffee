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
      @scaler.initialize()
      @_removeRedundantArtifacts()
      @_injectViewport()
      @_attachDashletLoadListeners()

    minimizeDashlet: ->
      @logger.log "minimize dashlet"
      @logger.log "Remove original scale"
      @scaler.removeOriginalScale()
      @_disableDashlets()

      @callback.onMinimizeStart()
      DOMTreeObserver.lastModify(@callback.onMinimizeEnd).wait()

      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()

    # Private

    _removeRedundantArtifacts: ->
      @logger.log "remove artifacts"
      customStyle = "
        .header, .dashletToolbar, .show_chartTypeSelector_wrapper {
            display: none !important;
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
      "
      jQuery('<style id="custom_mobile"></style').text(customStyle).appendTo 'head'

    _injectViewport: ->
      @logger.log "inject custom viewport"
      @viewport.configure()

    _attachDashletLoadListeners: ->
      @logger.log "attaching dashlet listener"
      DOMTreeObserver.lastModify(@_configureDashboard).wait()

    _configureDashboard: =>
      @logger.log "_configureDashboard"
      @_createCustomOverlays()
      @_scaleDashboard()
      @_overrideDashletTouches()
      @_disableDashlets()
      @callback.onLoadDone()
      @_setupResizeListener()

    _createCustomOverlays: ->
      @logger.log "_createCustomOverlays"
      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      jQuery.each dashletElements, (key, value) ->
        dashlet = jQuery(value)
        overlay = jQuery("<div></div>")
        overlay.addClass "customOverlay"
        dashlet.prepend overlay

    _scaleDashboard: ->
      @logger.log "_scaleDashboard"
      jQuery('.dashboardCanvas').addClass 'scaledCanvas'

    _setupResizeListener: ->
      @logger.log "set resizer listener"
      jQuery(window).resize () =>
        DOMTreeObserver.lastModify(@callback.onWindowResizeEnd).wait()
        @callback.onWindowResizeStart()

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
      endListener = () => @callback.onMaximizeEnd title
      DOMTreeObserver.lastModify(endListener).wait()

      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()

      @logger.log "Add original scale"
      @scaler.addOriginalScale()
