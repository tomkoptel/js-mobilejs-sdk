define 'js.mobile.report', (require) ->
  Session = require 'js.mobile.report.session'
  ReportController = require 'js.mobile.report.controller'

  class MobileReport
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileReport context

    constructor: (@context) ->

    @run: (options) ->
      @_instance.run options

    @selectPage: (page) ->
      @_instance.selectPage page

    selectPage: (page) ->
      if @reportController
        @reportController.selectPage page

    run: (options) ->
      options.session = new Session options
      options.context = @context
      @reportController = new ReportController options
      @reportController.runReport()

  root = window ? exports
  root.MobileReport = MobileReport
