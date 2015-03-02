root = window ? exports
root.JasperMobile or= {}

class JasperMobile.CallbackBridge
  constructor: (@concreteImplementor, @logger) ->

  onMaximize: (title) ->
    @concreteImplementor.onMaximize(title)

  onLoaded: ->
    @concreteImplementor.onLoaded()
