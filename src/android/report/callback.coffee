define 'js.mobile.android.report.callback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class ReportCallback extends CallbackDispatcher
    onScriptLoaded: =>
      @dispatch () -> Android.onScriptLoaded()
      return

    onLoadStart: =>
      @dispatch () -> Android.onLoadStart()
      return

    onLoadDone: (parameters) =>
      @dispatch () -> Android.onLoadDone(parameters)
      return

    onLoadError: (error) =>
      @dispatch () -> Android.onLoadError(error)
      return

    onReportCompleted: (status, pages, error) =>
      Android.onReportCompleted(status, pages, error)
      return

    onTotalPagesLoaded: (pages) =>
      return

    onPageChange: (page) =>
      @dispatch () -> Android.onPageChange(page)
      return

    onReferenceClick: (location) =>
      @dispatch () -> Android.onReferenceClick(location)
      return

    onReportExecution: (data) =>
      @dispatch () -> Android.onReportExecutionClick(data)
      return

    onExportGetResourcePath: (link) =>
      @dispatch () -> Android.onExportGetResourcePath(link)
      return

    onRefreshSuccess: =>
      @dispatch () -> Android.onRefreshSuccess()
      return

    onRefreshError: (error) =>
      @dispatch () -> Android.onRefreshError(error)
      return

    onMultiPageStateObtained: (isMultiPage) =>
      @dispatch () -> Android.onMultiPageStateObtained(isMultiPage)
      return

    onWindowError: (message) =>
      @dispatch () -> Android.onWindowError(message)
      return
