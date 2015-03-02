root = window ? exports
root.JasperMobile or= {}

class JasperMobile.View
  constructor: (@context, @el) ->

  setSize: (width, height) ->
    @context.logger.log 'set size ' + @el.toString()
    @el.css 'width', width
    @el.css 'height', height

  scaleView: ->
    windowWidth = @context.window.width
    windowHeight = @context.window.height
    setSize windowWidth, windowHeight

  disable: ->
    _setInteractive false

  enable: ->
    _setInteractive true

  _setInteractive: (enable) ->
    @logger.log "set interection " + @el.toString()
    pointerMode = if enable then "auto" else "none"
    @el.css("pointer-events", pointerMode)
