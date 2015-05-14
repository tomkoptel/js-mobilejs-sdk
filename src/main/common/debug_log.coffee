define 'js.mobile.debug_log', ->
  class Log
    @configure: ->
      window.js_mobile = {}
      window.js_mobile.log = console.log.bind(console)
