require ['js.mobile.android.dashboard.client', 'fastclick'], (AndroidClient, FastClick) ->
  (($) ->
    FastClick.attach document.body
    new AndroidClient().run()
  ) jQuery
