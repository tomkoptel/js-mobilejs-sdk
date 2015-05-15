define 'js.mobile.scale.calculator', ->
  class ScaleCalculator
    constructor: (@diagonal) ->
      @diagonal || = 10.1

    calculateFactor: ->
      @diagonal / 10.1
