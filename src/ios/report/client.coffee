define 'js.mobile.ios.report.client', (require) ->
  ReportCallback = require 'js.mobile.ios.report.callback'
  IosLogger = require 'js.mobile.ios.loggers.logger'
  Context = require 'js.mobile.context'
  MobileReport = require 'js.mobile.report'

  class ReportClient
    run: ->
      callbackImplementor = new ReportCallback()
      logger = new IosLogger()
      context = new Context callback: callbackImplementor, logger: logger
      MobileReport.getInstance(context)
      callbackImplementor.onScriptLoaded()
