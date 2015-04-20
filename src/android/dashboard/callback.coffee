define 'js.mobile.android.dashboard.callback', (require) ->
  class AndroidCallback
    onMaximizeStart: (title) ->
      Android.onMaximizeStart(title)
      return

    onMaximizeEnd: (title) ->
      Android.onMaximizeEnd(title)
      return

    onMaximizeFailed: (error) ->
      Android.onMaximizeFailed(error)
      return

    onMinimizeStart: ->
      Android.onMinimizeStart()
      return

    onMinimizeEnd: ->
      Android.onMinimizeEnd()
      return

    onMinimizeFailed: (error) ->
      Android.onMinimizeFailed(error)
      return

    onScriptLoaded: ->
      console.log "onScriptLoaded"
      Android.onScriptLoaded()
      return

    onLoadStart: ->
      console.log "onLoadStart"
      Android.onLoadStart()
      return

    onLoadDone: (components) ->
      console.log "onLoadDone"
      Android.onLoadDone()
      return

    onLoadError: (error) ->
      Android.onLoadError(error)
      return

    onReportExecution: (data) ->
      Android.onReportExecution(data)
      return

    onWindowResizeStart: ->
      Android.onWindowResizeStart()
      return

    onWindowResizeEnd: ->
      Android.onWindowResizeEnd()
      return
