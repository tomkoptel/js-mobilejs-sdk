define 'js.mobile.context', ->
  class Context
    constructor: (options) ->
      {@logger, @callback} = options

    setWindow: (@window) ->
