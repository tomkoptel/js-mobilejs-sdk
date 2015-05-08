define 'js.mobile.ios.callbacks.IosCallback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class IosCallback extends CallbackDispatcher
    onMaximizeStart: (title) ->
      @_makeCallback "command:maximize&title:#{title}"
      return

    onMaximizeEnd: (title) ->
      return

    onMinimizeStart: ->
      return

    onMinimizeEnd: ->
      return

    onScriptLoaded: ->
      @_makeCallback "command:didScriptLoad"
      return

    onLoadStart: ->
      return

    onLoadDone: ->
      @_makeCallback "command:didEndLoading"
      return

    onLoadError: (error) ->
      return

    onWindowResizeStart: ->
      @_makeCallback "command:didWindowResizeStart"
      return

    onWindowResizeEnd: ->
      @_makeCallback "command:didWindowResizeEnd"
      return

    _makeCallback: (command) ->
      @dispatch () -> 
        window.location.href = "http://jaspermobile.callback/" + command
