define 'js.mobile.ios.callbacks.IosCallback', (require) ->
  class IosCallback
    onMaximizeStart: (title) ->
      @_makeCallback "command:maximize&title:#{title}"
      return

    onMinimizeStart: ->
      return

    onScriptLoaded: ->
      return

    onLoadStart: ->
      return

    onLoadDone: ->
      @_makeCallback "command:didEndLoading"
      return

    onLoadError: (error) ->
      return

    _makeCallback: (command) ->
      window.location.href = "http://jaspermobile.callback/" + command
