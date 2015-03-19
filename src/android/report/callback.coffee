define 'js.mobile.android.report.callback', (require) ->
  Callback = require 'js.mobile.report.callback'

  class ReportCallback extends Callback
    onScriptLoaded: ->
      Android.onScriptLoaded()
      return

    onLoadStart: ->
      Android.onLoadStart()
      return

    onLoadDone: (parameters) ->
      Android.onLoadDone(parameters)
      return

    onLoadError: (error) ->
      Android.onLoadError(error)
      return

    onTotalPagesLoaded: (pages) ->
      Android.onTotalPagesLoaded(pages)
      return

    onPageChange: (page) ->
      Android.onPageChange(page)
      return

    onReferenceClick: (location) ->
      Android.onReferenceClick(location)
      return

    onReportExecutionClick: (reportUri, params) ->
      Android.onReportExecutionClick(reportUri, params)
      return