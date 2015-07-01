define 'js.mobile.scale.manager', ->
  ScaleFactor = require 'js.mobile.factor.calculator'

  class ScaleManager
    constructor: (configs) ->
      {@scale_style, diagonal} = configs
      @calculator = new ScaleFactor diagonal

    applyScale: ->
      factor = @calculator.calculateFactor()
      @scale_style.applyFor factor
