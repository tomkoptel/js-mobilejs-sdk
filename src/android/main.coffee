require ['js.mobile.android.client'], (AndroidClient) ->
  (($) ->
    new AndroidClient().run()
  ) jQuery
