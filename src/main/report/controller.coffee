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
      if @report?
        @report
          .pages(page)
          .run()
          .done(@_processSuccess)
          .fail(@_processErrors)

    runReport: ->
      @logger.log "onLoadStart"
      @callback.onLoadStart()
      @_getServerVersion @_runReportOnTheVersionBasis

    _runReportOnTheVersionBasis: (version) =>
      isAmber2orHigher = (version >= 6.1)
      @logger.log "Version: #{version} Is amber2 or higher: #{isAmber2orHigher}"

      if isAmber2orHigher
        @_runReportWithoutAuth()
      else
        @_runReportWithoutAuthButWithHack()

    _runReportWithoutAuth: =>
      visualize(
        @_executeReport,
        @_runReportWithoutAuthButWithHack
      )

    _runReportWithoutAuthButWithHack: (error) =>
      if error?
        @logger.log " Reason: #{error.message}"

      skipAuth =
        auth:
          # if we are at this point we are already authenticated with HTTP API, so hook Viz.js auth to do nothing
          loginFn: (properties, request) ->
            # jQuery here is just for sample, any resolved Promise will work
            return (new jQuery.Deferred()).resolve()

      visualize skipAuth, @_executeReport

    _runReportWithAuth: (error) =>
      if error?
        @logger.log " Reason: #{error.message}"
      visualize @session.authOptions(), @_executeReport, @_executeFailedCallback, @_executeAlways

    exportReport: (format) ->
      @report.export({ outputFormat: format })
             .done(@_exportResource)

    destroyReport: ->
      @logger.log "destroy"
      @report.destroy()

    refresh: ->
      @report.refresh(
        () => @callback.onRefreshSuccess(),
        (error) => @callback.onRefreshError error.message
      )

    applyReportParams: (parameters) ->
      @logger.log "onLoadStart"
      @callback.onLoadStart()
      @report
        .params(parameters)
        .run()
        .done(@_processSuccess)
        .fail(@_processErrors)

    _executeReport: (visualize) =>
      @report = visualize.report
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
          reportCompleted: @_processReportComplete
        success: @_processSuccess

    _executeFailedCallback: (error) =>
      @logger.log error.message

    _processChangeTotalPages: (@totalPages) =>
      @logger.log "onTotalPagesLoaded"
      @callback.onTotalPagesLoaded @totalPages

    _processReportComplete: (status, error) =>
      @logger.log "onReportCompleted"
      @callback.onReportCompleted status, @report.data().totalPages, error

    _processSuccess: (parameters) =>
      if parameters.components.length == 0
        @callback.onEmptyReportEvent()
      else
        window.setTimeout(@_processLoadDone, 2000)

    _processLoadDone: (parameters) =>
        @logger.log "onLoadDone"
        @callback.onLoadDone parameters

    _processErrors: (error) =>
      @logger.log error
      if error.errorCode is "authentication.error"
        @logger.log "onLoadStart"
        @callback.onLoadStart()
        @_runReportWithAuth error
      else
        @callback.onLoadError error.message

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
      @report.pages(page)
        .run()
        .fail(@_processErrors)
        .done(@_notifyPageChange)

    _notifyPageChange: =>
      @callback.onPageChange @report.pages()

    _exportReport: (format) ->
      @logger.log("export with format: " + format)
      @report.export({ outputFormat: format })
             .done(@_exportResource)

    _exportResource: (link) =>
      @callback.onExportGetResourcePath link.href

    _getServerVersion: (callback) =>
      jQuery
        .ajax("#{window.location.href}/rest_v2/serverInfo", {dataType: 'json'})
        .done (response) =>
          version = @_parseServerVersion(response)
          callback.call(@, version)

    _parseServerVersion: (response) =>
      serverVersion = response.version
      digits = serverVersion.match(/\d/g)
      result = 0
      for digit, index in digits
        result += digit * Math.pow(10, index * -1)
      return result
