define 'js.mobile.context', ->
  class Context
    constructor: (@bridge) ->
      @logger = @bridge.logger

    setWindow: (window) ->
      @window = window
