requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    #  Common components
    'js.mobile.logger': 'main/logger'
    'js.mobile.context': 'main/context'
    'js.mobile.client': 'main/client'

    #  Dashboards
    'js.mobile.dashboard.callback.implementor': 'main/dashboard/callback_implementor'
    'js.mobile.dashboard.wrapper': 'main/dashboard/dashboard_wrapper'
    'js.mobile.dashboard.window': 'main/dashboard/dashboard_window'
    'js.mobile.dashboard.controller': 'main/dashboard/dashboard_controller'
    'js.mobile.dashboard.view': 'main/dashboard/view'

    #  Reports
    'js.mobile.report.callback.implementor': 'main/report/callback_implementor'
    'js.mobile.report.controller': 'main/report/report_controller'
    'js.mobile.report.wrapper': 'main/report/report_wrapper'

    # Legacy
    'fastclick': '../bower_components/fastclick/lib/fastclick'
  shim:
    'fastclick': {'exports': 'fastclick'}
