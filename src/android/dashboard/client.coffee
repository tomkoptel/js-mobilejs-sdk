define 'js.mobile.android.dashboard.client',
  [
    'js.mobile.client',
    'js.mobile.android.dashboard.callback.implementor',
    'js.mobile.android.logger',
    'js.mobile.context',
    'js.mobile.dashboard.wrapper'
  ],
  (MobileClient, AndroidCallbackImplementor, AndroidLogger, Context, DashboardWrapper) ->
    class AndroidClient extends MobileClient
      run: ->
        callbackImplementor = new AndroidCallbackImplementor()
        logger = new AndroidLogger()
        context = new Context callback: callbackImplementor, logger: logger
        DashboardWrapper.getInstance(context)
        callbackImplementor.onWrapperLoaded()
