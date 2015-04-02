define 'js.mobile.android.dashboard.callback', (require) ->
  class AndroidCallback
    onMaximize: (title) ->
      Android.onMaximize(title)
      return

    onMinimize: ->
      Android.onMinimize()
      return

    onScriptLoaded: ->
      Android.onScriptLoaded()
      return

    onLoadStart: ->
      Android.onLoadStart()
      return

    onLoadDone: (components) ->
      Android.onLoadDone()
      return

    onLoadError: (error) ->
      Android.onLoadError(error)
      return
