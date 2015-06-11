define 'js.mobile.ios.callbacks.IosCallback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class IosCallback extends CallbackDispatcher
    onMaximizeStart: (title) ->
      @_makeCallback "didStartMaximazeDashlet&title=#{title}"
      return

    onMaximizeEnd: (title) ->
      return

    onMinimizeStart: ->
      return

    onMinimizeEnd: ->
      return

    onScriptLoaded: ->
      @_makeCallback "scriptDidLoad"
      return

    onLoadStart: ->
      return

    onLoadDone: ->
      @_makeCallback "onLoadDone"
      return

    onLoadError: (error) ->
      return

    onWindowResizeStart: ->
      @_makeCallback "windowDidStartResize"
      return

    onWindowResizeEnd: =>
      @_makeCallback "windowDidEndResize"
      return

    _makeCallback: (command) ->
      @dispatch () ->
        window.location.href = "http://jaspermobile.callback/" + command
