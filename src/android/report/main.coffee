require [
    'js.mobile.android.report.client'
    'js.mobile.release_log'
  ]
  , (AndroidClient, Log) ->
      Log.configure()
      new AndroidClient().run()
