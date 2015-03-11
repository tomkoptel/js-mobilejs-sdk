define 'js.mobile.report', () ->
  class MobileReport
    @_instance: null

    @getInstance: (context) ->
      @_instance ||= new MobileReport context

    constructor: (@context) ->

    load: (options) ->
      @context.session = new Session options
      options.context = @context
      reportController = new ReportController options
      reportController.runReport()


  root = window ? exports
  root.MobileReport = MobileReport
