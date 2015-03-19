define 'js.mobile.amber.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.ios.dashboard.callback'
  IosLogger = require 'js.mobile.ios.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber.dashboard'

  class IosClient
    run: ->
      context = new Context
        callback: new IosCallback()
        logger: new IosLogger()

      MobileDashboard.getInstance context
      MobileDashboard.run()
