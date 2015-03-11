define 'js.mobile.android.callback.implementor', ['js.mobile.dashboard.callback.implementor'], (DashboardCallbackImplementor) ->
  class AndroidCallbackImplementor extends DashboardCallbackImplementor
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
