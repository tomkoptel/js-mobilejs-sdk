define 'js.mobile.report', (require) ->
  Session = require 'js.mobile.session'
  ReportController = require 'js.mobile.report.controller'

  class MobileReport
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileReport context

    @authorize: (options) ->
      @_instance._authorize options

    @destroy: ->
      @_instance._destroyReport()

    @run: (options) ->
      @_instance._run options

    @selectPage: (page) ->
      @_instance._selectPage page

    @exportReport: (format) ->
      @_instance._exportReport format

    @refresh: ->
      @_instance._refreshController()

    @applyReportParams: (params) ->
      @_instance._applyReportParams params

    constructor: (@context) ->
      @context.callback.onScriptLoaded()

    # Run {'uri': '%@', 'params': %@} // default pages = '1'
    # Run {'uri': '%@', 'params': %@, 'pages' : '%@'}
    # Run {'uri': '%@', 'params': %@, 'pages' : '%@-%@'}
    _run: (options) ->
      options.session = @session
      options.context = @context
      @reportController = new ReportController options
      @reportController.runReport()

    # Auth {'username': '%@', 'password': '%@', 'organization': '%@'}
    _authorize: (options) ->
      @session = new Session options

    _selectPage: (page) ->
      if @reportController
        @reportController.selectPage page
    _exportReport: (format) ->
      @reportController.exportReport format

    _destroyReport: ->
      @reportController.destroyReport()

    _refreshController: ->
      @reportController.refresh()

    _applyReportParams: (params) ->
      @reportController.applyReportParams params

  window.MobileReport = MobileReport
