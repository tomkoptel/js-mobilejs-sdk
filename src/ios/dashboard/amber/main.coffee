require ['js.mobile.amber.ios.dashboard.client', 'js.mobile.release_log'], (IosClient, Log) ->
  (($) ->
    Log.configure()
    new IosClient().run()
  ) jQuery
