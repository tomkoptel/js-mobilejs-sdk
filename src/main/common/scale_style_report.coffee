define 'js.mobile.scale.style.report', ->
  class ScaleStyleReport
    applyFor: (factor) ->
      jQuery("#scale_style").remove()

      scaledCanvasCss =
        "#container {
           position: absolute;
           width: #{100 / factor}%;
           height: #{100 / factor}%;
         }"

      jQuery('<style id="scale_style"></style>').text(scaledCanvasCss).appendTo 'head'
      return
