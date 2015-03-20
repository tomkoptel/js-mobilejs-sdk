define 'js.mobile.scaller', ->
  class Scaller
    scale: (factor) ->
      jQuery("#scale_style").remove()

      scaledCanvasCss =
        ".scaledCanvas {
           transform-origin: 0 0 0;
           -ms-transform-origin: 0 0 0;
           -webkit-transform-origin: 0 0 0;

           transform: scale( #{factor} );
           -ms-transform: scale( #{factor} );
           -webkit-transform: scale( #{factor} );

           width: #{100 / factor}% !important;
           height: #{100 / factor}% !important;
         }"
      originalDashletInScaledCanvasCss =
        ".dashboardCanvas > .content > .body div.canvasOverlay.originalDashletInScaledCanvas {
          transform-origin: 0 0 0;
          -ms-transform-origin: 0 0 0;
          -webkit-transform-origin: 0 0 0;

          transform: scale( #{1 / factor} );
          -ms-transform: scale( #{1 / factor} );
          -webkit-transform: scale( #{1 / factor} );

          width: #{100 * factor}% !important;
          height: #{100 * factor}% !important;
        }"
      jQuery('<style id="scale_style"></style').text(scaledCanvasCss + originalDashletInScaledCanvasCss).appendTo 'head'
      return
