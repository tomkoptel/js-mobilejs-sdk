define 'js.mobile.report.controller', ->
  class ReportController
    constructor: (options) ->
      {@context, @session, @uri, @params} = options
      @callback = @context.callback
      @logger = @context.logger

      @logger.log @uri

      @params ||= {}
      @totalPages = 0

    selectPage: (page) ->
      if @loader?
        @loader
          .pages(page)
          .run()
          .done(@_processSuccess)
          .fail(@_processErrors)

    runReport: ->
      @callback.onLoadStart()
      @logger.log "start loading visualize"

      visualize @session.authOptions(), @_executeReport

    _executeReport: (visualize) =>
      @logger.log "start report execution"

      @loader = visualize.report
        resource: @uri
        params: @params
        container: "#container"
        scale: "width"
        linkOptions:
          events:
            click: @_processLinkClicks
        error: @_processErrors
        events:
          changeTotalPages: @_processChangeTotalPages
        success: @_processSuccess

    _processLinkClicks: (event, link) =>

    _processChangeTotalPages: (@totalPages) =>
        @callback.onTotalPagesLoaded @totalPages

    _processSuccess: (parameters) =>
      @logger.log parameters
      @callback.onLoadDone parameters

    _processErrors: (error) =>
      @logger.log error
      @callback.onLoadError error
