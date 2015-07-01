define 'js.mobile.ios.report.client', (require) ->
  ReportCallback = require 'js.mobile.ios.report.callback'
  MobileReport = require 'js.mobile.report'
  ScaleStyleReport = require 'js.mobile.ios.scale.style.report'

  class ReportClient
    run: ->
      MobileReport.getInstance
        callback: new ReportCallback()
        scale_style: new ScaleStyleReport()
