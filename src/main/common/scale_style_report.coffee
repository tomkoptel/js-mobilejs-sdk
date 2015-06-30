define 'js.mobile.scale.style.report', ->
  class ScaleStyleReport
    applyFor: (factor) ->
      jQuery("#scale_style").remove()

      scaledCanvasCss =
        "#container {     
           transform-origin: 0 0 0;
           -ms-transform-origin: 0 0 0;
           -webkit-transform-origin: 0 0 0;

           transform: scale( #{factor} );
           -ms-transform: scale( #{factor} );
           -webkit-transform: scale( #{factor} );

           width: #{100 / factor}% !important;
           height: #{100 / factor}% !important;
         }"

      jQuery('<style id="scale_style"></style>').text(scaledCanvasCss).appendTo 'head'
      return
