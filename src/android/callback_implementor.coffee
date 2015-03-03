define 'js.mobile.android.callback.implementor', ['js.mobile.callback.implementor'], (CallbackImplementor) ->
  class AndroidCallbackImplementor extends CallbackImplementor
    onMaximize: (title) ->
      # Android.onMaximize(title)
      return

    onLoaded: ->
      # Android.onLoaded()
      return
