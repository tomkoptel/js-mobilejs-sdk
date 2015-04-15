define 'js.mobile.amber.android.dashboard.client', (require) ->
  AndroidCallback = require 'js.mobile.android.dashboard.callback'
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber.dashboard'
  Viewport = require 'js.mobile.android.viewport.dashboard.amber'

  class AndroidClient
    run: ->
      context = new Context
        callback: new AndroidCallback()
        logger: new AndroidLogger()
      viewport = new Viewport()

      MobileDashboard.getInstance context, viewport
      MobileDashboard.run()
