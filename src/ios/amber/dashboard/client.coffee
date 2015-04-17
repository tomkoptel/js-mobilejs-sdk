define 'js.mobile.amber.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.ios.callbacks.IosCallback'
  IosLogger = require 'js.mobile.ios.loggers.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber.dashboard'
  Viewport = require 'js.mobile.ios.viewport.dashboard.amber'

  class IosClient
    run: ->
      context = new Context
        callback: new IosCallback()
        logger: new IosLogger()
      viewport = new Viewport()

      MobileDashboard.newInstance context, viewport
