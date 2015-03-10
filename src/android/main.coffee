require ['js.mobile.android.client', 'fastclick'], (AndroidClient, FastClick) ->
  (($) ->
    FastClick.attach document.body
    new AndroidClient().run()
  ) jQuery
