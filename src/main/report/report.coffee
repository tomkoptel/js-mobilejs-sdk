define 'js.mobile.report', (require) ->
  Session = require 'js.mobile.session'
  ReportController = require 'js.mobile.report.controller'

  class MobileReport
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileReport context

    @setCredentials: (options) ->
      @_instance.setCredentials options

    @destroy: ->
      @_instance.destroyReport()

    @run: (options) ->
      @_instance.run options

    @selectPage: (page) ->
      @_instance.selectPage page

    constructor: (@context) ->

    setCredentials: (options) ->
      @session = new Session options

    selectPage: (page) ->
      if @reportController
        @reportController.selectPage page

    run: (options) ->
      options.session = @session
      options.context = @context
      @reportController = new ReportController options
      @reportController.runReport()

    destroyReport: ->
      @reportController.destroyReport()

  root = window ? exports
  root.MobileReport = MobileReport
