define 'js.mobile.ios.callbacks.WebKitCallback', (require) ->
  class IosCallback
    onMaximize: (title) ->
      @_makeCallback {"command" : "onMaximize", "properties" : {"title" : title} }
      return

    onMinimize: ->
      @_makeCallback {"command" : "onMinimize", "properties" : {}}
      return

    onScriptLoaded: ->
      @_makeCallback {"command" : "onScriptLoaded", "properties" : {}}
      return

    onLoadStart: ->
      @_makeCallback {"command" : "onLoadStart", "properties" : {}}
      return

    onLoadDone: ->
      @_makeCallback {"command" : "onLoadDone", "properties" : {}}
      return

    onLoadError: (error) ->
      return

    _makeCallback: (command) ->
      console.log "callback"
      window.webkit.messageHandlers.callback.postMessage(command)
