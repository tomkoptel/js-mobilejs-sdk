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
            window.clearInterval timeout
            jQuery("body").unbind()
            @callback.call(@)
          , 2000
