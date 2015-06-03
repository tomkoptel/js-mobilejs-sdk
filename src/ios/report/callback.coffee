define 'js.mobile.ios.report.callback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class ReportCallback extends CallbackDispatcher
    onScriptLoaded: ->
      @dispatch () ->
        @_makeCallback "DOMContentLoaded"
      return

    onLoadStart: ->
      return

    onLoadDone: (parameters) ->
      @dispatch () ->
        @_makeCallback "reportDidEndRenderSuccessful"
      return

    onLoadError: (error) ->
      @dispatch () ->
        @_makeCallback "reportDidEndRenderFailured&error=" + error
      return

    onReportCompleted: (status, pages, error) ->
      @dispatch () ->
        @_makeCallback "reportRunDidCompleted&status=#{status}&pages=#{pages}&error=#{error}"
      return

    onPageChange: (page) ->
      return

    onReferenceClick: (location) ->
      @dispatch () ->
        @_makeCallback "handleReferenceClick&location=" + location
      return

    onReportExecutionClick: (reportUri, params) ->
      @dispatch () ->
        @_makeCallback "runReport&params=" + params
      return

    onExportGetResourcePath: (link) ->
      @dispatch () ->
        @_makeCallback "exportPath&link=" + link

    onRefreshSuccess: ->
      @dispatch () ->
        @_makeCallback "reportDidDidEndRefreshSuccessful"

    onRefreshError: (error) ->
      @dispatch () ->
        @_makeCallback "reportDidEndRefreshFailured&error=" + error

    onMultiPageStateObtained: (isMultipage) ->
      @dispatch () ->
        @_makeCallback "reportDidObtaineMultipageState&isMultiPage=" + isMultipage

    onChartTypeListObtained: (chartTypes) ->
      @dispatch () ->
        @_makeCallback "reportDidObtaineChartTypeList&chartTypeList=" + chartTypes
        
    onChartTypeChangedSuccess: () ->
      @dispatch () ->
        @_makeCallback "reportDidChangeChartTypeSuccessfull"
        
    onChartTypeChangedFail: (error) ->
      @dispatch () ->
        @_makeCallback "reportDidChangeChartTypeFailed&error=" + error

    _makeCallback: (command) ->
      window.location.href = "http://jaspermobile.callback/" + command
