define 'js.mobile.amber2.android.dashboard.client', (require) ->
  MobileClient = require 'js.mobile.client'
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber2.dashboard'
  DashboardCallback = require 'js.mobile.amber2.android.dashboard.callback'

  class DashboardClient extends MobileClient
    run: ->
      callback = new DashboardCallback()
      logger = new AndroidLogger()
      context = new Context callback: callback, logger: logger
      MobileDashboard.getInstance(context)
      callback.onScriptLoaded()
