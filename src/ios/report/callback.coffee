define 'js.mobile.ios.report.callback', (require) ->
  CallbackDispatcher = require 'js.mobile.callback_dispatcher'

  class ReportCallback extends CallbackDispatcher
    onScriptLoaded: ->
      @_makeCallback "DOMContentLoaded"
      return

    onLoadStart: ->
      return

    onLoadDone: (parameters) ->
      @_makeCallback "reportDidEndRenderSuccessful"
      return

    onLoadError: (error) ->
      @_makeCallback "reportDidEndRenderFailured&error=" + error
      return

    onTotalPagesLoaded: (pages) ->
      @_makeCallback "changeTotalPages&totalPage=" + pages
      return

    onPageChange: (page) ->
      return

    onReferenceClick: (location) ->
      @_makeCallback "handleReferenceClick&location=" + location
      return

    onReportExecutionClick: (reportUri, params) ->
      @_makeCallback "runReport&params=" + params
      return

    onExportGetResourcePath: (link) ->
      @_makeCallback "exportPath&link=" + link

    onRefreshSuccess: ->
      @_makeCallback "reportDidDidEndRefreshSuccessful"

    onRefreshError: (error) ->
      @_makeCallback "reportDidEndRefreshFailured&error=" + error

    _makeCallback: (command) ->
      @dispatch () ->
        window.location.href = "http://jaspermobile.callback/" + command
