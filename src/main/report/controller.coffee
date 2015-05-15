define 'js.mobile.report.controller', (reqiure) ->
  jQuery = require 'jquery'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class ReportController extends Module
    @include lifecycle.reportController.instanceMethods

    constructor: (@callback, @scaler, options) ->
      {@session, @uri, @params, @pages} = options
      js_mobile.log @uri

      @params ||= {}
      @totalPages = 0
      @pages ||= '1'

  #---------------------------------------------------------------------
  # Public API
  #---------------------------------------------------------------------
    runReport: ->
      js_mobile.log "runReport"
      @scaler.applyScale()
      @callback.onLoadStart()
      @_getServerVersion @_runReportOnTheVersionBasis

    refresh: =>
      js_mobile.log "refresh"
      @report.refresh(
        @_processSuccess
        @_processErrors
      )

    applyReportParams: (parameters) ->
      js_mobile.log "applyReportParams"
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
      js_mobile.log "destroyReport"
      @report.destroy()

  #---------------------------------------------------------------------
  # Helper Methods
  #---------------------------------------------------------------------
    _runReportOnTheVersionBasis: (version) =>
      isAmber2orHigher = (version >= 6.1)
      js_mobile.log "Version: #{version} Is amber2 or higher: #{isAmber2orHigher}"

      if isAmber2orHigher
        @_runReportWithoutAuth()
      else
        @_runReportWithoutAuthButWithHack()

    _runReportWithoutAuth: =>
      js_mobile.log "_runReportWithoutAuth"
      visualize(
        @_executeReportForAmber2OrHigher,
        @_runReportWithoutAuthButWithHack
      )

    _runReportWithoutAuthButWithHack: (error) =>
      js_mobile.log "_runReportWithoutAuthButWithHack"
      if error?
        js_mobile.log " Reason: #{error.message}"

      skipAuth =
        auth:
          # if we are at this point we are already authenticated with HTTP API, so hook Viz.js auth to do nothing
          loginFn: (properties, request) ->
            # jQuery here is just for sample, any resolved Promise will work
            return (new jQuery.Deferred()).resolve()

      visualize skipAuth, @_executeReportForAmber

    _runReportWithAuth: (error) =>
      js_mobile.log "_runReportWithAuth"
      if error?
        js_mobile.log " Reason: #{error.message}"
      visualize @session.authOptions(), @_executeReportForAmber, @_executeFailedCallback, @_executeAlways

    _executeReportForAmber2OrHigher: (visualize) =>
      params =
        chart:
          animation: false
          zoom: false
      @_executeReport visualize, params

    _executeReportForAmber: (visualize) =>
      @_executeReport visualize, {}

    _executeReport: (visualize, params) =>
      js_mobile.log "_executeReport"
      defaultParams =
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
      actualParams = jQuery.extend {}, defaultParams, params
      @report = visualize.report actualParams

    _executeFailedCallback: (error) =>
      js_mobile.log error.message

    _checkMultipageState: ->
      @report.export({ outputFormat: "html", pages: "2"})
        .done (params) =>
          @_processMultipageState(true)
        .fail (error) =>
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
      js_mobile.log("export with format: " + format)
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
          js_mobile.log status
          js_mobile.log JSON.stringify error
          @_processErrors error
      jQuery
        .ajax("#{window.location.href}/rest_v2/serverInfo", params)

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
      js_mobile.log "onReportCompleted"
      @callback.onReportCompleted status, @report.data().totalPages, error

    _processMultipageState: (isMultipage) =>
      js_mobile.log "multi #{isMultipage}"
      @callback.onMultiPageStateObtained(isMultipage)

    _processSuccess: (parameters) =>
      js_mobile.log "_processSuccess"
      @_checkMultipageState()
      @callback.onLoadDone parameters

    _processErrors: (error) =>
      js_mobile.log error
      if error.errorCode is "authentication.error"
        js_mobile.log "onLoadStart"
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
