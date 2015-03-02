root = window ? exports
root.JasperMobile or= {}

Logger = JasperMobile.Logger

class JasperMobile.AndroidLogger extends Logger
  log: (message) ->
