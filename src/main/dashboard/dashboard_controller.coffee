define 'js.mobile.dashboard.controller', ->
  class JasperMobile.DashboardController

    constructor: (@context) ->
      @logger = @context.bridge.logger
      @callback = @context.bridge
      @container = new View(jQuery('#frame'), @context)

    injectViewport: ->
      viewPort = document.querySelector('meta[name=viewport]')
      viewPort.setAttribute 'content', 'width=device-width; minimum-scale=0.1; maximum-scale=1; user-scalable=yes'

    scaleDashboard: ->
      @container.scaleView()

    attachDashletLoadListeners: ->
      _self = @
      timeInterval = setInterval((->
        dashlets = jQuery('.dashlet')

        if dashlets.length > 0
          _self.callback.onLoaded()
          _disableDashlets()

          window.clearInterval timeInterval
          timeIntervalDashletContent = setInterval((->
            dashletContent = jQuery('.dashletContent > div.content')
            #var dashboardContentLength = jQuery.trim( dashletContent.html() ).length;
            if dashletContent.length == dashlets.length
              _overrideDashletTouches()
              window.clearInterval timeIntervalDashletContent
            return
          ), 100)
        return
      ), 100)

    _disableDashlets: ->
      dashletElements = jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent())
      elements = new View(dashletElements, @context)
      elements.disable()

    minimizeDashlet: ->
      @logger.log "minimize dashlet"
      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()
      scaleDashboard()
      _disableDashlets()

    maximizeDashlet: (dashlet) ->
      dashletView = new View(dashlet, @context)
      dashletView.enable()

      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()
      return

  # Private

    _overrideDashletTouches: ->
      elems = jQuery('div.dashboardCanvas > div.content > div.body > div')
      elems.unbind()
      _self = @

      elems.click ->
        title = jQuery(this).find('.innerLabel > p')[0].textContent
        _self.callback.onMaximize(title)
        #_castElSizeToScreenSize("#frame", "200%", "200%")
        _self.maximizeDashlet(this)
        return
