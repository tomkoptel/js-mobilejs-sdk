define 'js.mobile.report.controller', (reqiure) ->
  jQuery = require 'jquery'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class ReportController extends Module
    @include lifecycle.reportController.instanceMethods

    constructor: (options) ->
      {@context, @uri, @session, @params, @pages} = options
      @callback = @context.callback
      @logger = @context.logger

      @logger.log @uri

      @params ||= {}
      @totalPages = 0
      @pages ||= '1'

  #---------------------------------------------------------------------
  # Public API
  #---------------------------------------------------------------------
    runReport: ->
      @logger.log "runReport"
      @callback.onLoadStart()
      @_getServerVersion @_runReportOnTheVersionBasis

    refresh: =>
      @logger.log "refresh"
      @report.refresh(
        @_processSuccess
        @_processErrors
      )

    applyReportParams: (parameters) ->
      @logger.log "applyReportParams"
      @callback.onLoadStart()
      @report
        .params(parameters)
        .run()
        .done(@_processSuccess)
        .fail(@_processErrors)

    selectPage: (page) ->
      if @report?
        @report
          .pages(page)
          .run()

    exportReport: (format) ->
      @report.export({ outputFormat: format })
             .done(@_exportResource)

    destroyReport: ->
      @logger.log "destroyReport"
      @report.destroy()

  #---------------------------------------------------------------------
  # Helper Methods
  #---------------------------------------------------------------------
    _runReportOnTheVersionBasis: (version) =>
      isAmber2orHigher = (version >= 6.1)
      @logger.log "Version: #{version} Is amber2 or higher: #{isAmber2orHigher}"

      if isAmber2orHigher
        @_runReportWithoutAuth()
      else
        @_runReportWithoutAuthButWithHack()

    _runReportWithoutAuth: =>
      @logger.log "_runReportWithoutAuth"
      visualize(
        @_executeReport,
        @_runReportWithoutAuthButWithHack
      )

    _runReportWithoutAuthButWithHack: (error) =>
      @logger.log "_runReportWithoutAuthButWithHack"
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
      @logger.log "_runReportWithAuth"
      if error?
        @logger.log " Reason: #{error.message}"
      visualize @session.authOptions(), @_executeReport, @_executeFailedCallback, @_executeAlways

    _executeReport: (visualize) =>
      @logger.log "_executeReport"
      @report = visualize.report
        resource: @uri
        params: @params
        pages: @pages
        scale: "width"
        linkOptions:
          events:
            click: @_processLinkClicks
        error: @_processErrors
        events:
          reportCompleted: @_processReportComplete
        success: (parameters) =>
          @report.container("#container")
            .render()
            .done () => @_processSuccess(parameters)

    _executeFailedCallback: (error) =>
      @logger.log error.message

    _checkMultipageState: ->
      @report.export({ outputFormat: "html", pages: "2"})
        .done (params) =>
          @_fetchHTMLPage params.href, (isPageExists) =>
            @_processMultipageState(isPageExists)           
        .fail (error) =>
          @logger.log "multipage error: #{JSON.stringify error}"
          @_processMultipageState(false)

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
        .fail(@)
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
      params =
        async: false,
        dataType: 'json',
        success: (response) => 
          version = @_parseServerVersion(response)
          callback.call(@, version)
        error: (error) => 
          @logger.log status
          @logger.log JSON.stringify error
          @_processErrors error
      jQuery
        .ajax("#{window.location.href}/rest_v2/serverInfo", params)

    _fetchHTMLPage: (pageURL, callback) ->
      @logger.log "_fetchHTMLPage"
      params = 
        dataType: 'html',
        success: (response, status) => 
          if response.length > 0
            callback(true)
          else
            callback(false)        
        error: (error, status) => 
          callback(false)        
      jQuery.ajax(pageURL, params)
    
    _parseServerVersion: (response) =>
      serverVersion = response.version
      digits = serverVersion.match(/\d/g)
      result = 0
      for digit, index in digits
        result += digit * Math.pow(10, index * -1)
      return result

  #---------------------------------------------------------------------
  # Method callbacks
  #---------------------------------------------------------------------
    _processReportComplete: (status, error) =>
      @logger.log "onReportCompleted"
      @callback.onReportCompleted status, @report.data().totalPages, error

    _processMultipageState: (isMultipage) =>
      @logger.log "multi #{isMultipage}"
      @callback.onMultiPageStateObtained(isMultipage)

    _processSuccess: (parameters) =>
      @logger.log "_processSuccess"
      @_checkMultipageState()
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
