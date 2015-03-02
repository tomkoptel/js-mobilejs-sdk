root = window ? exports
root.JasperMobile or= {}

MobileClient = JasperMobile.MobileClient
AndroidCallbackImplementor = JasperMobile.AndroidCallbackImplementor
AndroidLogger = JasperMobile.AndroidLogger
CallbackBridge = JasperMobile.CallbackBridge
Context = JasperMobile.Context
DashboardWrapper = JasperMobile.DashboardWrapper

class JasperMobile.AndroidClient extends MobileClient
  run: ->
    callbackImplementor = new AndroidCallbackImplementor()
    logger = new AndroidLogger()
    callbackBridge = new CallbackBridge(callbackImplementor, logger)
    context = new Context(callbackBridge)
    DashboardWrapper.getInstance(context)
