define 'client', ->
  class MobileClient
    constructor: (@bridge) ->
      @logger = @bridge.logger

    setWindow: (window) ->
      @window = window
