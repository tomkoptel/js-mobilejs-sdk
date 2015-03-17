define 'js.mobile.amber.android.dashboard.callback', (require) ->
  Callback = require 'js.mobile.amber.dashboard.callback'

  class AndroidCallback extends Callback
    onMaximize: (title) ->
      Android.onMaximize(title)
      return

    onMinimize: ->
      Android.onMinimize()
      return

    onWrapperLoaded: ->
      Android.onWrapperLoaded()
      return

    onDashletsLoaded: ->
      Android.onDashletsLoaded()
      return
