requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    #  Common components
    'js.mobile.logger': 'main/logger'
    'js.mobile.context': 'main/context'
    'js.mobile.client': 'main/client'

    #  Dashboard components
    'js.mobile.dashboard': 'main/dashboard/dashboard'
    'js.mobile.dashboard.callback': 'main/dashboard/callback'
    'js.mobile.dashboard.window': 'main/dashboard/window'
    'js.mobile.dashboard.controller': 'main/dashboard/controller'
    'js.mobile.dashboard.view': 'main/dashboard/view'

    #  Report components
    'js.mobile.report.report': 'main/report/report'
    'js.mobile.report.callback': 'main/report/callback'
    'js.mobile.report.controller': 'main/report/controller'

    # Legacy components
    'fastclick': '../bower_components/fastclick/lib/fastclick'
  shim:
    'fastclick': {'exports': 'fastclick'}
