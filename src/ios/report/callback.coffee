define 'js.mobile.ios.report.callback', (require) ->

  class ReportCallback
    onScriptLoaded: ->
      @_makeCallback "DOMContentLoaded"
      return

    onLoadStart: ->
      console.log "onLoadStart"
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
      console.log "onPageChange"
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
      console.log "onRefreshSuccess"
      @_makeCallback "reportDidDidEndRefreshSuccessful"

    onRefreshError: (error) ->
      console.log "onRefreshError"
      @_makeCallback "reportDidEndRefreshFailured&error=" + error

    onMultipageStateObtained: (isMultipage) ->
      console.log "onMultipageStateObtained"
      @_makeCallback "onMultipageStateObtained&isMultipage=" + isMultipage

    _makeCallback: (command) ->
      window.location.href = "http://jaspermobile.callback/" + command
