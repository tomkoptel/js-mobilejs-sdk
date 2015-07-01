define 'js.mobile.amber.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.amber.ios.dashboard.callback'
  MobileDashboard = require 'js.mobile.amber.dashboard'
  Viewport = require 'js.mobile.ios.viewport.dashboard.amber'
  ScaleStyleDashboard = require 'js.mobile.ios.scale.style.dashboard'

  class IosClient
    run: ->
      MobileDashboard.newInstance
        callback: new IosCallback()
        viewport: new Viewport()
        scale_style: new ScaleStyleDashboard()
