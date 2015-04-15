define 'js.mobile.report', (require) ->
  Session = require 'js.mobile.session'
  ReportController = require 'js.mobile.report.controller'

  class MobileReport
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileReport context

    @authorize: (options) ->
      @_instance.authorize options

    @destroy: ->
      @_instance.destroyReport()

    @run: (options) ->
      @_instance.run options

    @selectPage: (page) ->
      @_instance.selectPage page

    @exportReport: (format) ->
      @_instance.exportReport format

    constructor: (@context) ->
      @context.callback.onScriptLoaded()

    # Auth {'username': '%@', 'password': '%@', 'organization': '%@'}
    authorize: (options) ->
      @session = new Session options

    selectPage: (page) ->
      if @reportController
        @reportController.selectPage page

    # Run {'uri': '%@', 'params': %@} // default pages = '1'
    # Run {'uri': '%@', 'params': %@, 'pages' : '%@'}
    # Run {'uri': '%@', 'params': %@, 'pages' : '%@-%@'}
    run: (options) ->
      console.log "run report with options" + options
      options.session = @session
      options.context = @context
      @reportController = new ReportController options
      @reportController.runReport()

    exportReport: (format) ->
      @reportController.exportReport format

    destroyReport: ->
      @reportController.destroyReport()

  root = window ? exports
  root.MobileReport = MobileReport
