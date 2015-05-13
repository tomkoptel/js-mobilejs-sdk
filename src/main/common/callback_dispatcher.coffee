define 'js.mobile.callback_dispatcher', ->
  class CallbackDispatcher
    constructor: ->
      @queue = []
      @paused = false

    dispatch: (task) ->
      if not @paused
        @queue.push task
        @_processEventLoop()
      else
        @queue.push task

    firePendingTasks: ->
      if not @paused
        while @queue.length > 0
          @queue.pop().call @

    pause: ->
      @paused = true

    resume: ->
      @paused = false

    _processEventLoop: ->
      if not @dispatchTimeInterval?
        @_createInterval @_processQueue

    _processQueue: =>
      if @queue.length == 0
        @_removeInterval()
      else
        @queue.pop().call @

    _createInterval: (eventLoop) ->
      @dispatchTimeInterval = window.setInterval eventLoop, 200

    _removeInterval: ->
      window.clearInterval @dispatchTimeInterval
      @dispatchTimeInterval = null
