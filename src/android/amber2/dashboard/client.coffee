define 'js.mobile.amber2.android.dashboard.client', (require) ->
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileDashboard = require 'js.mobile.amber2.dashboard'
  DashboardCallback = require 'js.mobile.android.dashboard.callback'

  class DashboardClient
    run: ->
      context = new Context
        callback: new DashboardCallback()
        logger: new AndroidLogger()

      MobileDashboard.getInstance context
