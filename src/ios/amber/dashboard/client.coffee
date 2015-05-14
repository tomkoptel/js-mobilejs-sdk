define 'js.mobile.amber.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.ios.callbacks.IosCallback'
  MobileDashboard = require 'js.mobile.amber.dashboard'
  Viewport = require 'js.mobile.ios.viewport.dashboard.amber'

  class IosClient
    run: ->
      MobileDashboard.newInstance
        callback: new IosCallback()
        viewport: new Viewport()
