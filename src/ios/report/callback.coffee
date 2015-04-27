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
      @_makeCallback "refrshDidEndSuccessful"

    onRefreshError: (error) ->
      @_makeCallback "refrshDidEndError&error=" + error

    _makeCallback: (command) ->
      window.location.href = "http://jaspermobile.callback/" + command
