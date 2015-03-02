root = window ? exports
root.JasperMobile or= {}

MobileClient = JasperMobile.MobileClient

class JasperMobile.IosClient extends MobileClient
  init: ->
    callbackImplementor = new IosCallbackImplementor()
    logger = new IosLogger()
    callbackBridge = new CallbackBridge(callbackImplementor, logger)
    context = new Context(callbackBridge)
    dashboardFacade = new DashboardFacade(context)
    dashboardFacade.init()
