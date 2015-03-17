define 'js.mobile.amber2.android.dashboard.callback', ->

  class DashboardCallback
    onScriptLoaded: ->
      Android.onScriptLoaded()
      return

    onLoadStart: ->
      Android.onLoadStart()
      return

    onLoadDone: ->
      Android.onLoadDone()
      return

    onLoadError: (error) ->
      Android.onLoadError(error)
      return
