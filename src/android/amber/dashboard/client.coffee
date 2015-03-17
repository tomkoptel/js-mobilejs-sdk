define 'js.mobile.amber.android.dashboard.client',
  [
    'js.mobile.client',
    'js.mobile.amber.android.dashboard.callback',
    'js.mobile.android.logger',
    'js.mobile.context',
    'js.mobile.amber.dashboard'
  ],
  (MobileClient, AndroidCallback, AndroidLogger, Context, MobileDashboard) ->
    class AndroidClient extends MobileClient
      run: ->
        callbackImplementor = new AndroidCallback()
        logger = new AndroidLogger()
        context = new Context callback: callbackImplementor, logger: logger
        MobileDashboard.getInstance(context)
        callbackImplementor.onWrapperLoaded()
