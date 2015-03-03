define 'js.mobile.android.logger', ['js.mobile.logger'], (Logger) ->
  class AndroidLogger extends Logger
    log: (message) ->
