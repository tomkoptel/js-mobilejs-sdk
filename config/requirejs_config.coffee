requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    #  Common components
    'js.mobile.logger': 'main/logger'
    'js.mobile.context': 'main/context'
    'js.mobile.client': 'main/client'
    'js.mobile.session': 'main/session'

    # Amber Dashboard components
    'js.mobile.amber.dashboard': 'main/amber/dashboard/dashboard'
    'js.mobile.amber.dashboard.callback': 'main/amber/dashboard/callback'
    'js.mobile.amber.dashboard.controller': 'main/amber/dashboard/controller'
    'js.mobile.amber.dashboard.view': 'main/amber/dashboard/view'
    'js.mobile.amber.dashboard.window': 'main/amber/dashboard/window'

    # Amber2 Dashboard components
    'js.mobile.amber2.dashboard': 'main/amber2/dashboard/dashboard'
    'js.mobile.amber2.dashboard.controller': 'main/amber2/dashboard/controller'

    #  Report components
    'js.mobile.report': 'main/report/report'
    'js.mobile.report.callback': 'main/report/callback'
    'js.mobile.report.controller': 'main/report/controller'

    # Legacy components
    'fastclick': '../bower_components/fastclick/lib/fastclick'
    'jquery': '../bower_components/jquery/dist/jquery.min'
  shim:
    'fastclick': {'exports': 'fastclick'}
    'jquery': {'exports': 'jquery'}
