define 'js.mobile.android.report.client',
  [
    'js.mobile.client',
    'js.mobile.report.callback.implementor',
    'js.mobile.android.logger',
    'js.mobile.context',
    'js.mobile.report.wrapper'
  ],
  (MobileClient, ReportCallbackImplementor, AndroidLogger, Context, ReportWrapper) ->
    class ReportClient extends MobileClient
      run: ->
        callbackImplementor = new ReportCallbackImplementor()
        logger = new AndroidLogger()
        context = new Context callback: callbackImplementor, logger: logger
        ReportWrapper.getInstance(context)
