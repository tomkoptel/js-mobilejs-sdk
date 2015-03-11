define 'js.mobile.android.report.callback', (require) ->
  Callback = require 'js.mobile.report.callback'

  class ReportCallback extends Callback
    onLoadStart: ->
    onLoadDone: (parameters) ->
    onLoadError: (error) ->
    onTotalPagesLoaded: (pages) ->
    onPageChange: (page) ->
    onRemoteCall: (type, location) ->
