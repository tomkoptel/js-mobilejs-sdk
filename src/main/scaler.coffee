define 'js.mobile.scaler', ->
  class Scaler
    constructor: (options) ->
      {@diagonal} = options

    initialize: ->
      factor = @_calculateFactor()
      @_generateStyles factor
      @_applyScaleToDOM()

    addOriginalScale: ->
      @_getOverlay().addClass "originalDashletInScaledCanvas"

    removeOriginalScale: ->
       @_getOverlay().removeClass "originalDashletInScaledCanvas"

    _getOverlay: ->
      jQuery(".dashboardCanvas > .content > .body div.canvasOverlay")

    _calculateFactor: ->
      @diagonal / 10.1

    _generateStyles: (factor) ->
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
      jQuery('<style id="scale_style"></style>').text(scaledCanvasCss + originalDashletInScaledCanvasCss).appendTo 'head'
      return

    _applyScaleToDOM: ->
      jQuery('.dashboardCanvas').addClass 'scaledCanvas'
