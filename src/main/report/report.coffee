define 'js.mobile.report', (require) ->
  Session = require 'js.mobile.session'
  ReportController = require 'js.mobile.report.controller'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileReport extends Module
    @include lifecycle.report.instanceMethods
    @extend lifecycle.report.staticMethods
    @_instance: null

    @getInstance: (args) ->
      @_instance ||= new MobileReport args

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

    constructor: (@args) ->
      @args.callback.onScriptLoaded()

    # Auth {'username': '%@', 'password': '%@', 'organization': '%@'}
    _authorize: (options) ->
      @session = new Session options

    _destroyReport: ->
      @_controller.destroyReport()

    # Run {'uri': '%@', 'params': %@} // default pages = '1'
    # Run {'uri': '%@', 'params': %@, 'pages' : '%@'}
    # Run {'uri': '%@', 'params': %@, 'pages' : '%@-%@'}
    _run: (options) ->
      options.session = @session
      options.callback = @args.callback
      @_controller = new ReportController options
      @_controller.runReport()

    _selectPage: (page) ->
      if @_controller
        @_controller.selectPage page

    _exportReport: (format) ->
      @_controller.exportReport format

    _refreshController: ->
      @_controller.refresh()

    _applyReportParams: (params) ->
      @_controller.applyReportParams params

  window.MobileReport = MobileReport
