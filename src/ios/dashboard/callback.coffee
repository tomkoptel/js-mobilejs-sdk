define 'js.mobile.ios.dashboard.callback', (require) ->
  class IosCallback
    onMaximize: (title) ->
      @_makeCallback "command:maximize&title:#{title}"
      return

    onMinimize: ->
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
