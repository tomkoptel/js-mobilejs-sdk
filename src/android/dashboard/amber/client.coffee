define 'js.mobile.amber.android.dashboard.client', (require) ->
  AndroidCallback = require 'js.mobile.android.dashboard.callback'
  MobileDashboard = require 'js.mobile.amber.dashboard'
  Viewport = require 'js.mobile.android.viewport.dashboard.amber'

  class AndroidClient
    run: ->
      MobileDashboard.newInstance
        viewport: new Viewport()
        callback: new AndroidCallback()
