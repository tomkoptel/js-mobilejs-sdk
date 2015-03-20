define 'js.mobile.amber.android.dashboard.client', (require) ->
  AndroidCallback = require 'js.mobile.android.dashboard.callback'
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber.dashboard'

  class AndroidClient
    run: ->
      context = new Context
        callback: new AndroidCallback()
        logger: new AndroidLogger()

      MobileDashboard.getInstance context
      MobileDashboard.run()
