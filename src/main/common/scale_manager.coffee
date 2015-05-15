define 'js.mobile.scale.manager', (require) ->
  ScaleCalculator = require 'js.mobile.scale.calculator'
  ScaleStyleReport = require 'js.mobile.scale.style.report'
  ScaleStyleDashboard = require 'js.mobile.scale.style.dashboard'

  class ScaleManager
    @getReportManager: (diagonal) ->
      diagonal ||= 10.1
      new ScaleManager diagonal, new ScaleStyleReport()

    @getDashboardManager: (diagonal) ->
      diagonal ||= 10.1
      new ScaleManager diagonal, new ScaleStyleDashboard()

    constructor: (diagonal, @scaleStyle) ->
      @calculator = new ScaleCalculator diagonal

    applyScale: ->
      factor = @calculator.calculateFactor()
      @scaleStyle.applyFor factor
