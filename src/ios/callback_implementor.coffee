root = window ? exports
root.JasperMobile or= {}

class JasperMobile.IosCallbackImplementor
  requestScreenSize: ->
    # ????
    return

  onMaximize: (title) ->
    _call("command:maximize&title:" + title)

  onLoaded: ->
    _call("command:didEndLoading")

# Private

  _call: (data) ->
    window.location.href = "http://jaspermobile.callback/" + data
    return
