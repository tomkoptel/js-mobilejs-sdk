define 'js.mobile.android.dashboard.callback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class AndroidCallback extends CallbackDispatcher
    onMaximizeStart: (title) ->
      @dispatch () -> Android.onMaximizeStart(title)
      return

    onMaximizeEnd: (title) ->
      @dispatch () -> Android.onMaximizeEnd(title)
      return

    onMaximizeFailed: (error) ->
      @dispatch () -> Android.onMaximizeFailed(error)
      return

    onMinimizeStart: ->
      @dispatch () -> Android.onMinimizeStart()
      return

    onMinimizeEnd: ->
      @dispatch () -> Android.onMinimizeEnd()
      return

    onMinimizeFailed: (error) ->
      @dispatch () -> Android.onMinimizeFailed(error)
      return

    onScriptLoaded: ->
      @dispatch () -> Android.onScriptLoaded()
      return

    onLoadStart: ->
      @dispatch () -> Android.onLoadStart()
      return

    onLoadDone: (components) ->
      @dispatch () -> Android.onLoadDone()
      return

    onLoadError: (error) ->
      @dispatch () -> Android.onLoadError(error)
      return

    onReportExecution: (data) ->
      @dispatch () -> Android.onReportExecution(data)
      return

    onWindowResizeStart: ->
      @dispatch () -> Android.onWindowResizeStart()
      return

    onWindowResizeEnd: ->
      @dispatch () -> Android.onWindowResizeEnd()
      return
