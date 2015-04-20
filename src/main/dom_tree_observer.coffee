define 'js.mobile.dom_tree_observer', ->
  class DOMTreeObserver
    @_instance: null

    @lastModify: (callback) ->
      @_instance = new DOMTreeObserver
      @_instance.callback = callback
      @_instance

    wait: ->
      timeout = null
      jQuery("body").unbind()
      jQuery("body").bind "DOMSubtreeModified", =>
        if timeout?
          window.clearInterval timeout

        timeout = window.setTimeout () =>
            console.log "2"
            window.clearInterval timeout
            jQuery("body").unbind()
            @callback.call(@)
          , 1000

        console.log "1"
