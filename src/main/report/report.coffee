define 'js.mobile.report', (require) ->
  Session = require 'js.mobile.session'
  ReportController = require 'js.mobile.report.controller'
  ReportScaler = require 'js.mobile.report.scaler'
  lifecycle = require 'js.mobile.lifecycle'
  Module = require 'js.mobile.module'

  class MobileReport extends Module
    @include lifecycle.report.instanceMethods
    @extend lifecycle.report.staticMethods
    @_instance: null

    @getInstance: (args) ->
      @_instance ||= new MobileReport args

    #  Deprecated please use @configure
    @authorize: (options) ->
      @_instance._authorize options

    # 'auth' contains meta data required for authorize
    # 'diagonal' info required for scaler
    @configure: (options) ->
      @_instance._configure options
      @_instance

    @destroy: ->
      @_instance._destroyReport()

    @run: (options) ->
      @_instance.run options

    @selectPage: (page) ->
      @_instance._selectPage page

    @exportReport: (format) ->
      @_instance._exportReport format

    @refresh: ->
      @_instance._refreshController()

    @applyReportParams: (params) ->
      @_instance._applyReportParams params

    constructor: (args) ->
      {@callback} = args
      @scaler = new ReportScaler {}
      @callback.onScriptLoaded()

    _authorize: (options) ->
      @session = new Session options

    _configure: (options) ->
      @scaler = new ReportScaler options
      @session = new Session options.auth

    _destroyReport: ->
      @_controller.destroyReport()

    # 'uri' report uri  // default pages = '1'
    # 'params' specific report paramaters
    # 'pages' by default '1'. Acceptable format '2' or '2-10'
    run: (options) ->
      options.session = @session
      options.callback = @callback
      options.scaler = @scaler
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
