define 'js.mobile.android.viewport.dashboard.amber', ->
  class Viewport
    configure: ->
      viewPort = document.querySelector 'meta[name=viewport]'
      viewPort.setAttribute 'content',
       "target-densitydpi=device-dpi, height=device-height, width=device-width, user-scalable=yes"
