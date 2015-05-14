require [
    'js.mobile.android.report.client'
    'js.mobile.debug_log'
  ]
  , (AndroidClient, Log) ->
      Log.configure()
      new AndroidClient().run()
