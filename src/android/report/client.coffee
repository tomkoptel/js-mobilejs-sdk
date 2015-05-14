define 'js.mobile.android.report.client', (require) ->
  ReportCallback = require 'js.mobile.android.report.callback'
  MobileReport = require 'js.mobile.report'

  class ReportClient
    run: ->
      MobileReport.getInstance
        callback: new ReportCallback()
