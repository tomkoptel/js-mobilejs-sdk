require ['js.mobile.amber2.ios.dashboard.client', 'js.mobile.release_log'], (DashboardClient, Log) ->
  Log.configure()
  new DashboardClient().run()
