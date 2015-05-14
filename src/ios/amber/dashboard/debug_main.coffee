require [
    'js.mobile.amber.ios.dashboard.client'
    'js.mobile.debug_log'
  ]
  , (IosClient, Log) ->
    (($) ->
      Log.configure()
      new IosClient().run()
    ) jQuery
