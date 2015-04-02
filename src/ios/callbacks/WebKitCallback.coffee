define 'js.mobile.ios.callbacks.WebKitCallback', (require) ->
  class IosCallback
    onMaximize: (title) ->
      @_makeCallback {"command" : "onMaximize", "parameters" : {"title" : title} }
      return

    onMinimize: ->
      @_makeCallback {"command" : "onMinimize", "parameters" : {}}
      return

    onScriptLoaded: ->
      @_makeCallback {"command" : "onScriptLoaded", "parameters" : {}}
      return

    onLoadStart: ->
      @_makeCallback {"command" : "onLoadStart", "parameters" : {}}
      return

    onLoadDone: (components) ->
      @_makeCallback {"command" : "onLoadDone", "parameters" : {"components" : components}}
      return

    onLoadError: (error) ->
      @_makeCallback {"command" : "onLoadError", "parameters" : {"error" : error}}
      return

    _makeCallback: (command) ->
      console.log "callback"
      window.webkit.messageHandlers.callback.postMessage(command)
