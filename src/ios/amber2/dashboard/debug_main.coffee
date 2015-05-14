require [
    'js.mobile.amber2.ios.dashboard.client'
    'js.mobile.debug_log'
  ]
  , (IosClient, Log) ->
    Log.configure()
    new IosClient().run()
