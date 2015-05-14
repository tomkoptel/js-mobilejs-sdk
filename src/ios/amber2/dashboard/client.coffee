define 'js.mobile.amber2.ios.dashboard.client', (require) ->
  IosCallback = require 'js.mobile.ios.callbacks.WebKitCallback'
  MobileDashboard = require 'js.mobile.amber2.dashboard'

  class IosClient
    run: ->
      MobileDashboard.getInstance
        callback: new IosCallback()
