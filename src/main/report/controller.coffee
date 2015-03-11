define 'js.mobile.report.controller', () ->
  class ReportController
    constructor: (options) ->
      {@context, @uri, @params} = options
      @callback = @context.callback
      @logger = @context.logger

      @logger.log @uri

      @params ||= {}


    runReport: ->
      session = @context.session
      v(session.authOptions(), @_loadReport)

    _loadReport: (v) ->
      @callback.onLoadStart()

      v.report
        resource: @uri
        params: @params
        container: "#container"
        scale: "width"
        linkOptions:
          events:
            click: @_processLinkClicks
            success: @_processSuccess
            error: @_processErrors
            events:
              changeTotalPages: @_processChangeTotalPages

    _processLinkClicks: (event, link) ->

    _processChangeTotalPages: (@totalPages) ->
        @callback.onTotalPagesLoaded totalPages

    _processSuccess: (parameters) ->
      @logger.log parameters
      @callback.onLoadDone parameters

    _processErrors: (error) ->
      @logger.log error
      @callback.onLoadError error

  root = window ? exports
  root.ReportWrapper = ReportWrapper
