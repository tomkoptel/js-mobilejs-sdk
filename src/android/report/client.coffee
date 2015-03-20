define 'js.mobile.android.report.client', (require) ->
  ReportCallback = require 'js.mobile.android.report.callback'
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileReport = require 'js.mobile.report'

  class ReportClient
    run: ->
      context = new Context
        callback: new ReportCallback()
        logger: new AndroidLogger()
      MobileReport.getInstance context
