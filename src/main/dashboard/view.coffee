define 'js.mobile.dashboard.view', ->
  class View
    constructor: (options) ->
      {@context, @el} = options
      @logger = @context.logger

    scaleView: ->
      windowWidth = @context.window.width
      windowHeight = @context.window.height
      @setSize windowWidth, windowHeight

    setSize: (width, height) ->
      @logger.log "Set size. Width: #{width}. Height: #{height}"
      @el.css 'width', width
      @el.css 'height', height

    disable: ->
      @_setInteractive false

    enable: ->
      @_setInteractive true

    # Private

    _setInteractive: (enable) ->
      pointerMode = if enable then "auto" else "none"
      @logger.log "Toggle interaction: " + pointerMode
      @el.css "pointer-events", pointerMode
