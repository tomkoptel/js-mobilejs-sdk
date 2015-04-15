define 'js.mobile.ios.viewport.dashboard.amber', ->
  class Viewport
    configure: ->
      viewPort = document.querySelector 'meta[name=viewport]'
      viewPort.setAttribute 'content',
       "width=device-width, minimum-scale=0.1, maximum-scale=1, user-scalable=yes"
