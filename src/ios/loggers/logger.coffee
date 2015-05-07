define 'js.mobile.ios.loggers.logger', ->
  class IosLogger
    log: (message) ->
      console.log message
      # xhr = new XMLHttpRequest();
      # xhr.open('GET', "http://debugger/" + encodeURIComponent(message))
      # xhr.send(null)
