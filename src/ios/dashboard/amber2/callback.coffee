define 'js.mobile.amber2.ios.dashboard.callback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class IosCallback extends CallbackDispatcher
    onMaximizeStart: (title) ->
      @_makeCallback {"command" : "onMaximizeStart", "parameters" : {"title" : title} }
      return

    onMaximizeEnd: (title) ->
      @_makeCallback {"command" : "onMaximizeEnd", "parameters" : {"title" : title} }
      return

    onMaximizeFailed: (error) ->
      @_makeCallback {"command" : "onMaximizeFailed", "parameters" : {"error" : error} }
      return

    onMinimizeStart: ->
      @_makeCallback {"command" : "onMinimizeStart", "parameters" : {}}
      return

    onMinimizeEnd: ->
      @_makeCallback {"command" : "onMinimizeEnd", "parameters" : {}}
      return

    onMinimizeFailed: ->
      @_makeCallback {"command" : "onMinimizeFailed", "parameters" : {"error" : error} }
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

    onAuthError: (error) ->
      @_makeCallback {"command" : "onAuthError", "parameters" : {"error" : error}}
      return

    onLoadError: (error) ->
      @_makeCallback {"command" : "onLoadError", "parameters" : {"error" : error}}
      return

    onWindowResizeStart: ->
      @_makeCallback {"command" : "onWindowResizeStart", "parameters" : {}}
      return

    onWindowResizeEnd: =>
      @_makeCallback {"command" : "onWindowResizeEnd", "parameters" : {}}
      return

    onReportExecution: (data) ->
      @_makeCallback {"command" : "onReportExecution", "parameters" : data}
      
    onReferenceClick: (href) ->
      @_makeCallback {"command" : "onReferenceClick", "parameters" : {"href": href}}
      
    onAdHocExecution: ->
      @_makeCallback {"command" : "onAdHocExecution", "parameters" : {}}

    onWindowError: (error) ->
      @_makeCallback {"command" : "onAdHocExecution", "onWindowError" : {"error": error}}

    _makeCallback: (command) ->
      @dispatch () ->
        window.location.href = "http://jaspermobile.callback/json&" + JSON.stringify command
