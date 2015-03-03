define 'js.mobile.android.client',
  [
    'js.mobile.client',
    'js.mobile.android.callback.implementor',
    'js.mobile.android.logger',
    'js.mobile.callback.bridge',
    'js.mobile.context',
    'js.mobile.dashboard.wrapper'
  ],
  (MobileClient, AndroidCallbackImplementor, AndroidLogger, CallbackBridge, Context, DashboardWrapper) ->

    class AndroidClient extends MobileClient
      run: ->
        callbackImplementor = new AndroidCallbackImplementor()
        logger = new AndroidLogger()
        callbackBridge = new CallbackBridge(callbackImplementor, logger)
        context = new Context(callbackBridge)
        DashboardWrapper.getInstance(context)
