define 'context', ->
  class Context
    constructor: (@bridge) ->
      @logger = @bridge.logger

    setWindow: (window) ->
      @window = window
