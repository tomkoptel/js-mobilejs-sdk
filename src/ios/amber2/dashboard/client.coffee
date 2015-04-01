define 'js.mobile.amber2.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.ios.callbacks.WebKitCallback'
  IosLogger = require 'js.mobile.ios.loggers.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber2.dashboard'

  class IosClient
    run: ->
      context = new Context
        callback: new IosCallback()
        logger: new IosLogger()

      MobileDashboard.getInstance context
