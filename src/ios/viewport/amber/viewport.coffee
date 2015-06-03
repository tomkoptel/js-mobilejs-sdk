define 'js.mobile.ios.viewport.dashboard.amber', ->
  class Viewport
    configure: ->
      viewPort = document.querySelector 'meta[name=viewport]'
      viewPort.setAttribute 'content',
       "initial-scale=1, width=device-width, minimum-scale=0.1, maximum-scale=3, user-scalable=yes"
