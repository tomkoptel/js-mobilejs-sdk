require [
    'js.mobile.amber2.android.dashboard.client'
    'js.mobile.release_log'
  ]
  , (AndroidClient, Log) ->
      Log.configure()
      new AndroidClient().run()
