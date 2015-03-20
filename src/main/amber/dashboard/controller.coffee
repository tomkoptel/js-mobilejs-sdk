define 'js.mobile.amber.dashboard.controller',(require) ->
  View = require 'js.mobile.amber.dashboard.view'
  Scaler = require 'js.mobile.scaler'

  class DashboardController
    constructor: (@context) ->
      @logger = @context.logger
      @callback = @context.callback
      @container = new View el: jQuery('#frame'), context: @context
      @scaler = new Scaler

    initialize: ->
      @callback.onLoadStart()
      @scaler.scale 0.25

      @_removeRedundantArtifacts()
      @_injectViewport()
      @_attachDashletLoadListeners()

    minimizeDashlet: ->
      @logger.log "minimize dashlet"
      @logger.log "Remove original scale"
      jQuery(".dashboardCanvas > .content > .body div.canvasOverlay").removeClass "originalDashletInScaledCanvas"
      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()

      @_disableDashlets()
      @callback.onMinimize()

    # Private

    _injectViewport: ->
      viewPort = document.querySelector 'meta[name=viewport]'
      viewPort.setAttribute 'content', "width=device-width, height=device-height, user-scalable=yes"

    _scaleDashboard: ->
      jQuery('.dashboardCanvas').addClass 'scaledCanvas'

    _attachDashletLoadListeners: ->
      timeInterval = window.setInterval () =>
        window.clearInterval timeInterval

        timeIntervalDashletContent = window.setInterval () =>
          dashlets = jQuery('.dashlet')

          if dashlets.length > 0
            dashletContent = jQuery('.dashletContent > div.content')

            if dashletContent.length is dashlets.length
              @_configureDashboard()
              window.clearInterval timeIntervalDashletContent
        , 100
      , 100

    _configureDashboard: ->
      @_scaleDashboard()
      @_overrideDashletTouches()
      @_disableDashlets()
      @callback.onLoadDone()

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
      "
      jQuery('<style id="custom_mobile"></style').text(customStyle).appendTo 'head'


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

      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      dashlets = new View el: dashletElements, context: @context
      dashlets.enable()

      @callback.onMaximize title

      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()

      @logger.log "Add original scale"
      jQuery(".dashboardCanvas > .content > .body div.canvasOverlay").addClass "originalDashletInScaledCanvas"
