define 'js.mobile.report.wrapper', () ->
  class ReportWrapper
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new ReportWrapper context

    constructor: (@context) ->

    load: (options) ->
      @context.session = new Session options
      options.context = @context
      reportController = new ReportController options
      reportController.runReport()


  root = window ? exports
  root.ReportWrapper = ReportWrapper
