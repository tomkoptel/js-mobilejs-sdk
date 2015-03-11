define 'js.mobile.android.report.client', (require) ->
  MobileClient = require 'js.mobile.client'
  ReportCallback = require 'js.mobile.android.report.callback'
  AndroidLogger = require 'js.mobile.android.logger'
  Context = require 'js.mobile.context'
  MobileReport = require 'js.mobile.report'

  class ReportClient extends MobileClient
    run: ->
      callbackImplementor = new ReportCallback()
      logger = new AndroidLogger()
      context = new Context callback: callbackImplementor, logger: logger
      MobileReport.getInstance(context)
