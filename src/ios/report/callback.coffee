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
      @_makeCallback "reportDidEndRenderFailured"
      return

    onTotalPagesLoaded: (pages) ->
      @_makeCallback "changeTotalPages&totalPage=" + pages
      return

    onPageChange: (page) ->
      console.log "onPageChange"
      return

    onReferenceClick: (location) ->
      console.log "onReferenceClick"
      return

    onReportExecutionClick: (reportUri, params) ->
      console.log "onReportExecutionClick"
      return

    _makeCallback: (command) ->
      window.location.href = "http://jaspermobile.callback/" + command
