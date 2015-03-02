class DashletView extends View
    constructor: (@el, @context) ->
      super(@el, @context)
      @container = new View jQuery("#frame"), @context

    minimizeDashlet: ->
      @context.logger.log "minimize dashlet"
      jQuery("div.dashboardCanvas > div.content > div.body > div").find(".minimizeDashlet")[0].click()
      @container.setSize "#frame"
      setInteractive(false)
      jQuery('.dashlet').not(jQuery('.inputControlWrapper').parentsUntil('.dashlet').parent()).css("pointer-events", "none")

    maximizeDashlet: (dashlet) ->
      jQuery('.dashlet').css 'pointer-events', 'auto'
      button = jQuery(jQuery(dashlet).find('div.dashletToolbar > div.content div.buttons > .maximizeDashletButton')[0])
      button.click()
      return
