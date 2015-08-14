require ['js.mobile.amber.android.dashboard.client', 'js.mobile.release_log'], (AndroidClient, Log) ->
  (($) ->
    Log.configure()
    new AndroidClient().run()
  ) jQuery
