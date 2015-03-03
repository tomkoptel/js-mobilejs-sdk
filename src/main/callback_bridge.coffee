define 'js.mobile.callback.bridge', ->
  class CallbackBridge
    constructor: (@concreteImplementor, @logger) ->

    onMaximize: (title) ->
      @concreteImplementor.onMaximize(title)

    onLoaded: ->
      @concreteImplementor.onLoaded()
