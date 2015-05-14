require [
    'js.mobile.ios.report.client'
    'js.mobile.release_log'
  ]
  , (IosClient, Log) ->
    Log.configure()
    new IosClient().run()
