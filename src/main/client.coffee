define 'js.mobile.client', ->
  class Client
    constructor: (@bridge) ->
      @logger = @bridge.logger

    setWindow: (window) ->
      @window = window
