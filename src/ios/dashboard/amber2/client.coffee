define 'js.mobile.amber2.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.amber2.ios.dashboard.callback'
  MobileDashboard = require 'js.mobile.amber2.dashboard'
  ScaleStyleDashboard = require 'js.mobile.ios.scale.style.dashboard'

  class IosClient
    run: ->
      MobileDashboard.getInstance
        callback: new IosCallback()
        scale_style: new ScaleStyleDashboard()
