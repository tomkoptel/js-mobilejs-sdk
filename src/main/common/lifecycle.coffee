define 'js.mobile.lifecycle', ->
  return {
    pause: ->
      @callback.setPause true
    resume: ->
      @callback.setPause false
      @callback.firePendingTasks()
  }
