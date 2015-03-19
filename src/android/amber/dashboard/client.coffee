define 'js.mobile.amber.android.dashboard.client', (require) ->
  MobileClient = require 'js.mobile.client'
  AndroidCallback = require 'js.mobile.android.dashboard.callback'
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber.dashboard'

  class AndroidClient extends MobileClient
    run: ->
      context = new Context
        callback: new AndroidCallback()
        logger: new AndroidLogger()

      MobileDashboard.getInstance context
