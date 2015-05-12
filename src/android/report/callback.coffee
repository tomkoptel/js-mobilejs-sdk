define 'js.mobile.android.report.callback', (require) ->
  class ReportCallback
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

    onReportCompleted: (status, pages, error) ->
      Android.onReportCompleted(status, pages, error)
      return

    onTotalPagesLoaded: (pages) ->
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

    onExportGetResourcePath: (link) ->
      Android.onExportGetResourcePath(link)
      return

    onRefreshSuccess: ->
      Android.onRefreshSuccess()
      return

    onRefreshError: (error) ->
      Android.onRefreshError(error)
      return

    onEmptyReportEvent: () ->
      Android.onEmptyReportEvent()
      return
