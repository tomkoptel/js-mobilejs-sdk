root = window ? exports
root.JasperMobile or= {}

class JasperMobile.Context
  constructor: (@bridge) ->
    @logger = @bridge.logger

  setWindow: (window) ->
    @window = window
