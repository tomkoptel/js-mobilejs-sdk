define 'js.mobile.android.scale.style.report', ->
  class ScaleStyleReport
    applyFor: (factor) ->
      jQuery("#scale_style").remove()

      scaledCanvasCss = "#container {}"

      jQuery('<style id="scale_style"></style>').text(scaledCanvasCss).appendTo 'head'
      return
