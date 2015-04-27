define 'js.mobile.report.controller', ->
  class ReportController
    constructor: (options) ->
      {@context, @session, @uri, @params, @pages} = options
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
      visualize @session.authOptions(), @_executeReport

    exportReport: (format) ->
      @loader.export({ outputFormat: format })
             .done(@_exportResource)

    destroyReport: ->
      @logger.log "destroy"
      @loader.destroy()

    refresh: ->
      @loader.refresh(
        @callback.onRefreshSuccess,
        (error) => @callback.onRefreshError error.message,
        () ->
      )

    _executeReport: (visualize) =>
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
      window.loader = @loader

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
