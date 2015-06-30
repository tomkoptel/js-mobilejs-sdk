define 'js.mobile.android.report.client', (require) ->
  ReportCallback = require 'js.mobile.android.report.callback'
  MobileReport = require 'js.mobile.report'
  ScaleStyleReport = require 'js.mobile.android.scale.style.report'

  class ReportClient
    run: ->
      MobileReport.getInstance
        callback: new ReportCallback()
        scaler: new ScaleStyleReport()
