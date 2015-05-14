define 'js.mobile.release_log', ->
  class Log
    @configure: ->
      window.js_mobile = {}
      window.js_mobile.log = () ->
