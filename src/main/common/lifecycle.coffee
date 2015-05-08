define 'js.mobile.lifecycle', ->
  lifecycle =
    dashboardController:
      instanceMethods:
        pause: ->
          @callback.setPause true
        resume: ->
          @callback.setPause false
          @callback.firePendingTasks()
    dashboard:
      staticMethods:
        pause: ->
          @_instance._pause()
        resume: ->
          @_instance._resume()
      instanceMethods:
        _pause: ->
          @_controller.pause()
        _resume: ->
          @_controller.resume()
  lifecycle['report'] = lifecycle['dashboard']
  lifecycle['reportController'] = lifecycle['dashboardController']
  return lifecycle
