require [
    'js.mobile.ios.report.client'
    'js.mobile.debug_log'
  ]
  , (IosClient, Log) ->
    Log.configure()
    new IosClient().run()
