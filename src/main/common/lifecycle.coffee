define 'js.mobile.lifecycle', ->
  return {
    dashboardController:
      instanceMethods:
        pause: ->
          console.log "pause"
          @callback.setPause true
        resume: ->
          console.log "resume"
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
  }
