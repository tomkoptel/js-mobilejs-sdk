define 'js.mobile.report.controller', (reqiure) ->
  jQuery = require 'jquery'

  class ReportController
    constructor: (options) ->
      {@context, @uri, @session, @params, @pages} = options
      @callback = @context.callback
      @logger = @context.logger

      @logger.log @uri

      @params ||= {}
      @totalPages = 0
      @pages ||= '1'

    selectPage: (page) ->
      if @loader?
        @loader
          .pages(page)
          .run()
          .done(@_processSuccess)
          .fail(@_processErrors)

    runReport: ->
      @callback.onLoadStart()
      @_runReportWithoutAuthButWithHack()

    _runReportWithoutAuth: =>
      @logger.log "_runReportWithoutAuth"
      visualize @_executeReport, @_runReportWithoutAuthButWithHack, @_executeAlways

    _runReportWithoutAuthButWithHack: (error) =>
      @logger.log "_runReportWithoutAuthHack."
      if error?
        @logger.log " Reason: #{error.message}"

      skipAuth =
        auth:
          # if we are at this point we are already authenticated with HTTP API, so hook Viz.js auth to do nothing
          loginFn: (properties, request) ->
            # jQuery here is just for sample, any resolved Promise will work
            return (new jQuery.Deferred()).resolve()

      visualize(
        skipAuth,
        @_executeReport,
        @_runReportWithAuth,
        @_executeAlways
      )

    _runReportWithAuth: (error) =>
      @logger.log "_runReportWithAuth"
      if error?
        @logger.log " Reason: #{error.message}"
      visualize @session.authOptions(), @_executeReport, @_executeFailedCallback, @_executeAlways

    exportReport: (format) ->
      @loader.export({ outputFormat: format })
             .done(@_exportResource)

    destroyReport: ->
      @logger.log "destroy"
      @loader.destroy()

    _executeReport: (visualize) =>
      console.log "I am in execute report"
      @loader = visualize.report
        resource: @uri
        params: @params
        pages: @pages
        container: "#container"
        scale: "width"
        linkOptions:
          events:
            click: @_processLinkClicks
        error: @_processErrors
        events:
          changeTotalPages: @_processChangeTotalPages
        success: @_processSuccess

    _executeFailedCallback: (error) =>
      console.log error.message

    _executeAlways: ->
      console.log "always"

    _processChangeTotalPages: (@totalPages) =>
        @callback.onTotalPagesLoaded @totalPages

    _processSuccess: (parameters) =>
      @callback.onLoadDone parameters

    _processErrors: (error) =>
      @logger.log error
      @callback.onLoadError error

    _processLinkClicks: (event, link) =>
      type = link.type

      switch type
        when "ReportExecution" then @_startReportExecution link
        when "LocalAnchor" then @_navigateToAnchor link
        when "LocalPage" then @_navigateToPage link
        when "Reference" then @_openRemoteLink link

    _startReportExecution: (link) =>
      params = link.parameters
      reportUri = params._report
      paramsAsString = JSON.stringify params, null, 2
      @callback.onReportExecutionClick reportUri, paramsAsString

    _navigateToAnchor: (link) =>
      window.location.hash = link.href

    _navigateToPage: (link) =>
      href = link.href
      numberPattern = /\d+/g
      matches = href.match numberPattern
      if matches?
        pageNumber = matches.join ""
        @_loadPage pageNumber

    _openRemoteLink: (link) =>
      href = link.href
      @callback.onReferenceClick href

    _loadPage: (page) ->
      @loader.pages(page)
        .run()
        .fail(@_processErrors)
        .done(@_notifyPageChange)

    _notifyPageChange: =>
      @callback.onPageChange @loader.pages()

    _exportReport: (format) ->
      console.log("export with format: " + format)
      @loader.export({ outputFormat: format })
             .done(@_exportResource)

    _exportResource: (link) =>
      @callback.onExportGetResourcePath link.href
