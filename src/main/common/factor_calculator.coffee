define 'js.mobile.factor.calculator', ->
  class FactorCalculator
    constructor: (@diagonal) ->
      @diagonal || = 10.1

    calculateFactor: ->
      @diagonal / 10.1
