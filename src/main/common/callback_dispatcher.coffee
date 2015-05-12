define 'js.mobile.callback_dispatcher', ->
  class CallbackDispatcher
    constructor: ->
      @queue = []
      @paused = false

    dispatch: (task) ->
      if not @paused
        @queue.push task
        dispatchTimeInterval = window.setInterval () =>
          if @queue.length == 0
            window.clearInterval dispatchTimeInterval
          else 
            @queue.pop().call @
        , 1000
      else
        @queue.push task

    firePendingTasks: ->
      if not @paused
        while @queue.length > 0
          @queue.pop().call @

    setPause: (@paused) ->
