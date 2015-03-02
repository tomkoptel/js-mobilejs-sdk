root = window ? exports
root.JasperMobile or= {}

Logger = JasperMobile.Logger

class JasperMobile.IosLogger extends Logger
  log: (message) ->
    xhr = new XMLHttpRequest();
    xhr.open('GET', "http://debugger/" + encodeURIComponent(message))
    xhr.send(null)
