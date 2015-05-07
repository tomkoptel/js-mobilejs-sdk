define 'js.mobile.callback_dispatcher', ->
  class CallbackDispatcher
    constructor: ->
      @queue = []
      @paused = false

    dispatch: (task) ->
      if not @paused
        task.call @
      else
        @queue.push task

    firePendingTasks: ->
      hasPendingTasks = @queue.length > 0
      if not @paused and hasPendingTasks
        while @queue.length > 0
          @queue.pop().call @

    setPause: (@paused) ->
