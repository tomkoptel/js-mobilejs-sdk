define 'js.mobile.amber2.android.dashboard.client', (require) ->
  MobileDashboard = require 'js.mobile.amber2.dashboard'
  DashboardCallback = require 'js.mobile.android.dashboard.callback'

  class DashboardClient
    run: ->
      MobileDashboard.getInstance
        callback: new DashboardCallback()
